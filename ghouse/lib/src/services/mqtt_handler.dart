import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ghouse/src/controllers/controller.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

final String serverUri = "192.168.43.252";
final int port = 1883;
final String topicName = "v1/devices/me/telemetry";

class MQTTClientWrapper {
  MqttServerClient client;
  String username;

  MqttCurrentConnectionState connectionState = MqttCurrentConnectionState.IDLE;
  MqttSubscriptionState subscriptionState = MqttSubscriptionState.IDLE;

  final VoidCallback onConnectedCallback;

  MQTTClientWrapper(this.onConnectedCallback, this.username);

  void prepareMqttClient() async {
    _setupMqttClient();
    await _connectClient(this.username);
    _subscribeToTopic(topicName);
  }

  // void publishLocation(LocationData locationData) {
  //   String locationJson = locationToJsonConverter.convert(locationData);
  //   _publishMessage(locationJson);
  // }

  void _setupMqttClient() {
    client = MqttServerClient.withPort(serverUri, '#', port);
    client.logging(on: false);
    client.keepAlivePeriod = 200;
    client.onDisconnected = _onDisconnected;
    client.onConnected = _onConnected;
    client.onSubscribed = _onSubscribed;
    client.autoReconnect = true;
    print('bass by 1');
  }

  Future<void> _connectClient(String username) async {
    try {
      print('MQTTClientWrapper::Mosquitto client connecting....');
      connectionState = MqttCurrentConnectionState.CONNECTING;
      await client.connect(username);
    } on Exception catch (e) {
      print('MQTTClientWrapper::client exception - $e');
      connectionState = MqttCurrentConnectionState.ERROR_WHEN_CONNECTING;
      client.disconnect();
    }

    if (client.connectionStatus.state == MqttConnectionState.connected) {
      connectionState = MqttCurrentConnectionState.CONNECTED;
      print('MQTTClientWrapper::Mosquitto client connected');
    } else {
      print(
          'MQTTClientWrapper::ERROR Mosquitto client connection failed - disconnecting, status is ${client.connectionStatus}');
      connectionState = MqttCurrentConnectionState.ERROR_WHEN_CONNECTING;
      client.disconnect();
    }
  }

  void _subscribeToTopic(String topicName) {
    print('MQTTClientWrapper::Subscribing to the $topicName topic');
    client.subscribe(topicName, MqttQos.atMostOnce);

    client.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage recMess = c[0].payload;
      final String newTelemetryJson =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

      print("MQTTClientWrapper::GOT A NEW MESSAGE $newTelemetryJson");
      Controller ctrl;
      ctrl.change(newTelemetryJson);

      // LocationData newLocationData = _convertJsonToLocation(newLocationJson);
      // if (newLocationData != null) onLocationReceivedCallback(newLocationData);
    }, onError: (e) {
      print('errroorrr');
    }, onDone: () {
      print('donnnneee');
    });
  }

  // LocationData _convertJsonToLocation(String newLocationJson) {
  //   try {
  //     return jsonToLocationConverter.convert(
  //         newLocationJson);
  //   } catch (exception) {
  //     print("Json can't be formatted ${exception.toString()}");
  //   }
  //   return null;
  // }

  void publishMessage(String message) {
    final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
    builder.addString(message);

    print('MQTTClientWrapper::Publishing message $message to topic $topicName');
    client.publishMessage(topicName, MqttQos.exactlyOnce, builder.payload);
  }

  void _onSubscribed(String topic) {
    print('MQTTClientWrapper::Subscription confirmed for topic $topic');
    subscriptionState = MqttSubscriptionState.SUBSCRIBED;
  }

  void _onDisconnected() {
    print(
        'MQTTClientWrapper::OnDisconnected client callback - Client disconnection');
    if (client.connectionStatus.returnCode ==
        MqttConnectReturnCode.brokerUnavailable) {
      print(
          'MQTTClientWrapper::OnDisconnected callback is solicited, this is correct');
    }
    connectionState = MqttCurrentConnectionState.DISCONNECTED;
  }

  void _onConnected() {
    connectionState = MqttCurrentConnectionState.CONNECTED;
    print(
        'MQTTClientWrapper::OnConnected client callback - Client connection was sucessful');
    onConnectedCallback();
  }
}

enum MqttCurrentConnectionState {
  IDLE,
  CONNECTING,
  CONNECTED,
  DISCONNECTED,
  ERROR_WHEN_CONNECTING
}

enum MqttSubscriptionState { IDLE, SUBSCRIBED }

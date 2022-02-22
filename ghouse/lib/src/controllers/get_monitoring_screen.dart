import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghouse/res/constant.dart';
import 'package:ghouse/res/screens/monitor/monitoring_widget.dart';
import 'package:ghouse/src/models/device_model.dart';
import 'package:ghouse/src/services/websocket_handler.dart';
import 'package:ghouse/res/constant.dart' as cons;

class GetMonitoringScreen extends GetxController {
  var temperature = '0'.obs;
  var humidity = '0'.obs;
  var moisture = '0'.obs;
  var water = '0'.obs;
  var light = '0'.obs;

  var dht11Model, moistureModel, waterModel, lightModel = DeviceModel();
  WebSocketHandler dht11WSHandler,
      moistureWSHandler,
      waterWSHandler,
      lightWSHandler;

  @override
  void onInit() {
    dht11WSHandler = WebSocketHandler();
    moistureWSHandler = WebSocketHandler();
    waterWSHandler = WebSocketHandler();
    lightWSHandler = WebSocketHandler();

    dht11WSHandler.initSocket(cons.dht11Payload);
    moistureWSHandler.initSocket(cons.moisturePayload);
    waterWSHandler.initSocket(cons.waterPayload);
    lightWSHandler.initSocket(cons.ldrPayload);

    dht11WSHandler.channel.stream.listen((event) {
      dht11Model = deviceFromJson(event.toString());
      temperature(dht11Model.data["temperature"][0][1]);
      humidity(dht11Model.data["humidity"][0][1]);
    });
    moistureWSHandler.channel.stream.listen((event) {
      moistureModel = deviceFromJson(event.toString());
      moisture(moistureModel.data["moisture"][0][1]);
    });
    waterWSHandler.channel.stream.listen((event) {
      waterModel = deviceFromJson(event.toString());
      water(waterModel.data["water"][0][1]);
    });
    lightWSHandler.channel.stream.listen((event) {
      lightModel = deviceFromJson(event.toString());
      light(lightModel.data['light'][0][1]);
    });
    super.onInit();
  }

  Widget statu(Devices device, {var value}) {
    switch (device) {
      case Devices.TEMPERATURE_SENSOR:
        if (value <= 35) return goodState;
        return badState;
        break;
      case Devices.HUMIDITY_SENSOR:
        if (value <= 45) return goodState;
        return badState;
        break;
      case Devices.MOISTURE_SENSOR:
        if (value >= 70) return goodState;
        return badState;
        break;
      case Devices.WATER_SENSOR:
        if (value >= 70) return goodState;
        return badState;
        break;
      default:
        return goodState;
    }
  }
}

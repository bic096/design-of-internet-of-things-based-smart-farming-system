import 'dart:convert';

import 'package:ghouse/src/repositorys/jwt_maintain.dart';
import 'package:web_socket_channel/io.dart';

import 'package:ghouse/res/constant.dart' as consts;
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketHandler {
  WebSocketChannel channel;

  void initSocket(var payload) {
    print('iniiiiiiiiiit sooooket' + token);

    ///[need to deal with the network exceptions]
    channel = WebSocketChannel.connect(Uri.parse(
        'ws://${consts.host}:8080/api/ws/plugins/telemetry?token=$token'));
    channel.sink.add(jsonEncode(payload));
  }

  // void attributeSocket(
  //   var payload,
  // ) {
  //   print(token);

  //   ///[need to deal with the network exceptions]
  //   channel = IOWebSocketChannel.connect(
  //       'ws://192.168.43.252:8080/api/plugins/telemetry/ASSET/b89c12f0-20ad-11ec-9161-932316a31a3e/values/attributes/SERVER_SCOPE?token=$token');
  //   channel.sink.add(jsonEncode(payload));
  // }
}

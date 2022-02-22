import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:ghouse/src/services/jwt_base64decoder.dart' as jwtDecoder;
import 'package:ghouse/src/services/shared_pref_helper.dart' as prefs;
import 'package:ghouse/res/constant.dart' as consts;

const url = 'http://127.0.0.1:8080/api/auth/login';
Uri uri = Uri.http('${consts.host}:8080', 'api/auth/login');

String token;

const headers = {
  'Content-Type': 'application/json',
  'Accept': 'application/json'
};
const body = {"username": "tenant@thingsboard.org", "password": "tenant"};

Future<dynamic> tokenRefresh() async {
  http.Response res =
      await http.post(uri, body: jsonEncode(body), headers: headers);

  if (res.statusCode == 200) {
    print('fromprovider__post__tokenRefresh\n' + "${res.statusCode}" + '\n\n');
    print('fromprovider__post__tokenRefresh\n' + res.body + '\n\n');
    return {
      'statusCode': 200,
      'payload': jsonDecode(utf8.decode(res.bodyBytes)),
      'token': jsonDecode(utf8.decode(res.bodyBytes))['token']
    };
  }

  // if (res.statusCode == 400) {
  //   print(res.statusCode.toString());
  //   print(res.body);
  //   return {'statusCode': 400, 'payload': 'Bad Reuest'};
  // }

  if (res.statusCode != 200) {
    print(res.statusCode.toString());
    print(res.body);
    return {'statusCode': res.statusCode, 'payload': res.statusCode.toString()};
  }
  print('fromprovider__post__tokenRefresh\n');
  print(res.statusCode);
  print('\n\n');

  return null;
}

Future<bool> tokenVerify() async {
  token = await prefs.readFromStorage(key: 'token');
  if (token != null) {
    var decodedToken = jwtDecoder.parseJwtPayLoad(token);

    if (DateTime.now().millisecondsSinceEpoch >=
            (decodedToken["iat"] * 1000) + 86100000 ||
        DateTime.now().millisecondsSinceEpoch <=
            (decodedToken["iat"] * 1000) - 60000) {
      var res = await tokenRefresh();

      if (res['statusCode'] == 200) {
        print(res["payload"]["token"]);
        print('refreshed token: ' + res["token"]);
        prefs.writeToStorage(key: 'token', value: res['payload']['token']);
        token = res['payload']['token'];
        return true;
      } else {
        print(res['refreshed token: faild' + 'statusCode'].toString());
        // SystemChannels.platform.invokeListMethod('SystemNavigator.pop');
        SystemNavigator.pop();
        exit(0);
      }
    }
    token = await prefs.readFromStorage(key: 'token');
    print('token is valied : ' + token);
    return true;
  } else if (token == null) {
    print('no token please login');
    var res = await tokenRefresh();

    if (res['statusCode'] == 200) {
      print(res["payload"]["token"]);
      print('refreshed token: ' + res["token"]);
      token = res['payload']['token'];
      prefs.writeToStorage(key: 'token', value: res['payload']['token']);
    }
    return true;
  }
  print('hererrrrrrrrrrrrrrrr');
  return false;
}

Future<void> getTokenFromStorage() async {
  token = await prefs.readFromStorage(key: 'token');
}

var queryParameters = {
  'location': [73.98754, 40.759845],
};
Uri urii = Uri.http('192.168.43.252:8080', 'api/auth/login');

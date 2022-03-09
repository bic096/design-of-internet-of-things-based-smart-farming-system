import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:get/get.dart';
import 'package:ghouse/res/screens/home/home_screen.dart';
import 'package:ghouse/src/controllers/get_monitoring_screen.dart';
import 'package:ghouse/src/repositorys/jwt_maintain.dart';
import 'package:ghouse/src/services/thingsboard_service.dart';

class InitScreen extends StatefulWidget {
  @override
  _InitScreenState createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  GetMonitoringScreen getMonitoringScreen;
  ThingsBoardService thingsBoardService;
  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    thingsBoardService = ThingsBoardService();
    thingsBoardService.initServer();
    await tokenVerify();

    Get.put(GetMonitoringScreen());
    Timer(
        Duration(seconds: 1),
        () => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return MyHomePage(title: 'Flutter Demo Home Page');
            })));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Color(0xff1dd117),
      child: Center(
        child: Image.asset('assets/baseline.png'),
      ),
    );
  }
}

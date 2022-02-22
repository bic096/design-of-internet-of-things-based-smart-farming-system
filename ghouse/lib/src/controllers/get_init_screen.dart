import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghouse/res/screens/home/home_screen.dart';
import 'package:ghouse/src/repositorys/jwt_maintain.dart';

class GetInitScreen extends GetxController {
  BuildContext context;
  GetInitScreen(this.context);
  @override
  void onInit() {
    init();

    super.onInit();
  }

  void init() async {
    await tokenVerify();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MyHomePage();
    }));
  }
}

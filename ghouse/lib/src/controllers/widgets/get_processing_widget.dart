import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetProcessingWidget extends GetxController
    with SingleGetTickerProviderMixin {
  var angle = 0.0.obs;
  var color = Color(0xFFA5D6A7).obs;
  var popOff = false.obs; //last upDate
  AnimationController processingCTRL;
  Animation processingAnimation;
  Animation processingcolor;

  @override
  void onInit() async {
    super.onInit();
    processingCTRL =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    processingAnimation = Tween(begin: -20.0, end: 20).animate(processingCTRL);
    processingcolor =
        ColorTween(begin: Color(0xFFA5D6A7), end: Colors.green[900])
            .animate(processingCTRL);
    processingAnimation.addListener(() {
      angle(processingAnimation.value);
      color(processingcolor.value);
    });
    processingCTRL.repeat(reverse: true);
  }

  @override
  void onClose() {
    super.onClose();
    processingCTRL.dispose();
  }
}

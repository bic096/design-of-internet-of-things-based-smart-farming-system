import 'package:flutter/material.dart';
import 'package:ghouse/src/controllers/widgets/get_processing_widget.dart';
import 'package:get/get.dart';

class ProcessingWiget extends StatelessWidget {
  ProcessingWiget({Key key}) : super(key: key);

  // final GetProcessingWidget getProcessingWidget =
  //     Get.put(GetProcessingWidget());
  final GetProcessingWidget getProcessingWidget =
      Get.find<GetProcessingWidget>();

  @override
  Widget build(BuildContext context) {
    return
        //  AnimatedBuilder(
        //     animation: getProcessingWidget.processingAnimation,
        //     builder: (context, w) =>
        Obx(
      () => Transform.translate(
        // angle: getProcessingWidget.processingAnimation.value,
        // angle: getProcessingWidget.angle.value,
        offset: Offset(0, getProcessingWidget.angle.value - 70),
        child: Container(
          height: 10,
          width: 10,
          color: Colors.transparent,
          child: Center(
            child: Obx(() {
              if (getProcessingWidget.popOff.value == true)
                Navigator.pop(context);
              return Image.asset(
                'assets/baseline.png',
                width: 40,
                height: 40,
                color: getProcessingWidget.color.value,
              );
            }),
          ),
        ),
      ),
      // ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghouse/src/controllers/get_control_screen.dart';

class ControlWidget extends StatelessWidget {
  final String title;
  final String status;
  final IconData icon;
  final Widget iconWidget;
  final btnClik;

  const ControlWidget(
      {Key key,
      @required this.title,
      @required this.status,
      @required this.icon,
      this.iconWidget,
      this.btnClik})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final GetControlScreen getControlScreen = Get.put(GetControlScreen());
    // final Controller c = Get.put(Controller());
    return Obx(() => Container(
          // padding: EdgeInsets.all(10),
          height: 80,
          width: 350,
          decoration: BoxDecoration(
            color: getControlScreen.ctrlbtnColor.value,
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, .9),
                  spreadRadius: .1,
                  blurRadius: 22)
            ],
            borderRadius: BorderRadius.circular(30),
          ),
          child: Obx(() => RawMaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                onPressed: getControlScreen.mode.value == "auto"
                    ? null
                    : () {
                        // c.increment();
                        btnClik();
                      },
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      iconWidget,
                      // FaIcon(
                      //   icon,
                      //   size: 32,
                      //   color: Colors.black45,
                      // ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 10, left: 35),
                            child: Text(
                              title,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 40),
                                child: Text(
                                  status,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.green),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )),
        ));
  }
}

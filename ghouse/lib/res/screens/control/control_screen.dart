import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ghouse/res/screens/control/control_wiget.dart';
import 'package:ghouse/src/controllers/get_control_screen.dart';
import 'package:ghouse/src/controllers/widgets/get_processing_widget.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:ghouse/res/constant.dart' as consts;
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

class ControlScreen extends StatelessWidget {
  ControlScreen({Key key}) : super(key: key);
  final GetControlScreen getControlScreen = Get.put(GetControlScreen());

  final getProcessingWidget = Get.put(GetProcessingWidget());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ProgressHUD(
        child: Builder(builder: (context) {
          return Scaffold(
              appBar: AppBar(
                actions: [
                  SizedBox(
                    width: 20,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Obx(
                        () {
                          return ToggleSwitch(
                              activeBgColor: [Colors.cyan.shade800],
                              activeFgColor: Colors.white,
                              inactiveBgColor: Colors.grey,
                              inactiveFgColor: Colors.grey[900],
                              initialLabelIndex:
                                  getControlScreen.mode.value == 'auto' ? 0 : 1,
                              changeOnTap: false,
                              totalSwitches: 2,
                              labels: ['auto', 'manual'],
                              onToggle: (index) =>
                                  getControlScreen.changeMode(index, context));
                        },
                      ))
                ],
                title: (Text('Control')),
              ),
              body: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Obx(() => ControlWidget(
                            title: 'fan',
                            status: getControlScreen.fan.value,
                            icon: FontAwesomeIcons.fan,
                            iconWidget: Image.asset(
                              'fan.png',
                              height: 58,
                              width: 58,
                              color: Colors.grey[600],
                            ),
                            btnClik: () async {
                              getControlScreen.sendRPC(
                                  deviceId: consts.dhtSensor['ID'],
                                  deviceName: consts.Devices.FAN,
                                  currentState: getControlScreen.fan,
                                  context: context);
                            },
                          )),
                      SizedBox(
                        height: 30,
                      ),
                      Obx(() => ControlWidget(
                          title: 'pump',
                          status: getControlScreen.pump.value,
                          icon: FontAwesomeIcons.gasPump,
                          iconWidget: Image.asset(
                            'water-pump.png',
                            height: 58,
                            width: 58,
                            color: Colors.grey[600],
                          ),
                          btnClik: () {
                            getControlScreen.sendRPC(
                                deviceId: consts.moisSensor['ID'],
                                deviceName: consts.Devices.PUMP,
                                currentState: getControlScreen.pump,
                                context: context);
                          })),
                      SizedBox(
                        height: 30,
                      ),
                      Obx(() => ControlWidget(
                          title: 'light',
                          status: getControlScreen.lamp.value,
                          icon: FontAwesomeIcons.lightbulb,
                          iconWidget: FaIcon(
                            FontAwesomeIcons.lightbulb,
                            size: 58,
                            color: Colors.black45,
                          ),
                          btnClik: () {
                            getControlScreen.sendRPC(
                                deviceId: consts.lightSensor['ID'],
                                deviceName: consts.Devices.LAMP,
                                currentState: getControlScreen.lamp,
                                context: context);
                          })),
                      SizedBox(
                        height: 30,
                      ),
                      Obx(() => ControlWidget(
                          title: 'tank motor',
                          status: getControlScreen.motor.value,
                          icon: FontAwesomeIcons.pumpSoap,
                          iconWidget: Image.asset(
                            'water-motor.png',
                            height: 58,
                            width: 58,
                          ),
                          btnClik: () {
                            getControlScreen.sendRPC(
                                deviceId: consts.waterSensor['ID'],
                                deviceName: consts.Devices.MOTOR,
                                currentState: getControlScreen.motor,
                                context: context);
                          })),
                    ],
                  ),
                ),
              ));
        }),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ghouse/res/constant.dart';
import 'package:ghouse/res/screens/monitor/monitoring_widget.dart';
import 'package:ghouse/src/controllers/get_monitoring_screen.dart';

class MonitoringScreen extends StatelessWidget {
  MonitoringScreen({Key key}) : super(key: key);
  final GetMonitoringScreen getMonitoringScreen =
      Get.put(GetMonitoringScreen());

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SafeArea(
            child: Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Monitor Mode')),
      ),
      body: Container(
          child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 15.0,
        mainAxisSpacing: 20.0,
        padding: EdgeInsets.only(left: 15, right: 15, top: 30, bottom: 30),
        childAspectRatio: 1.7,
        children: [
          Obx(() => MonitoringWidget(
                statu: getMonitoringScreen.statu(Devices.TEMPERATURE_SENSOR,
                    value: int.tryParse(getMonitoringScreen.temperature.value)),
                title: 'Temperature',
                value: getMonitoringScreen.temperature.value,
                status: 'good',
                icon: FontAwesomeIcons.temperatureHigh,
                mark: 'C',
              )),
          Obx(() => MonitoringWidget(
                title: 'Humidity',
                value: getMonitoringScreen.humidity.value,
                status: 'good',
                statu: getMonitoringScreen.statu(Devices.HUMIDITY_SENSOR,
                    value: int.tryParse(getMonitoringScreen.humidity.value)),
                icon: FontAwesomeIcons.cloudRain,
                mark: '%',
              )),
          Obx(() => MonitoringWidget(
                statu: getMonitoringScreen.statu(Devices.MOISTURE_SENSOR,
                    value: int.tryParse(getMonitoringScreen.moisture.value)),
                title: 'Moisture',
                value: getMonitoringScreen.moisture.value,
                status: 'good',
                icon: FontAwesomeIcons.water,
                mark: '%',
              )),
          Obx(() => MonitoringWidget(
                statu: getMonitoringScreen.statu(Devices.WATER_SENSOR,
                    value: int.tryParse(getMonitoringScreen.water.value)),
                title: 'Water Level',
                value: getMonitoringScreen.water.value,
                status: 'good',
                icon: FontAwesomeIcons.handHoldingWater,
                mark: '%',
              )),
          Obx(() => MonitoringWidget(
                statu: getMonitoringScreen.statu(Devices.WATER_SENSOR,
                    value: int.tryParse(getMonitoringScreen.water.value)),
                title: 'Light Level',
                value: (int.tryParse(getMonitoringScreen.light.value) / 10)
                    .toString(),
                status: 'good',
                icon: FontAwesomeIcons.lightbulb,
                mark: '%',
              )),
        ],
      )),
    )));
  }
}

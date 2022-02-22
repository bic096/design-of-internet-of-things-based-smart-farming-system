import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghouse/res/constant.dart' as consts;
import 'package:ghouse/src/controllers/get_profile_screen.dart';
import 'package:toggle_switch/toggle_switch.dart';

var checkBoxVal = false;

class ProfileScreen extends StatelessWidget {
  final GetProfileScreen getProfileScreen = Get.put(GetProfileScreen());
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Profile')),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            // width: double.infinity,
            // height: double.infinity,

            child: Column(
              children: [
                ProfileWidget(
                  plantName: consts.profileInfo[0]['name'],
                  moisture:
                      consts.profileInfo[0]["data"]['moistureLow'].toString(),
                  light:
                      consts.profileInfo[0]["data"]['lightTimeLow'].toString() +
                          ' Hrs',
                  temperature:
                      consts.profileInfo[0]["data"]['tempLow'].toString(),
                  humidity:
                      consts.profileInfo[0]["data"]['humidityLow'].toString(),
                  id: 1,
                ),
                ProfileWidget(
                  plantName: consts.profileInfo[1]['name'],
                  moisture:
                      consts.profileInfo[1]["data"]['moistureLow'].toString(),
                  light:
                      consts.profileInfo[1]["data"]['lightTimeLow'].toString() +
                          ' Hrs',
                  temperature:
                      consts.profileInfo[1]["data"]['tempLow'].toString(),
                  humidity:
                      consts.profileInfo[1]["data"]['humidityLow'].toString(),
                  id: 2,
                ),
                ProfileWidget(
                  plantName: consts.profileInfo[2]['name'],
                  moisture:
                      consts.profileInfo[2]["data"]['moistureLow'].toString(),
                  light:
                      consts.profileInfo[2]["data"]['lightTimeLow'].toString() +
                          ' Hrs',
                  temperature:
                      consts.profileInfo[2]["data"]['tempLow'].toString(),
                  humidity:
                      consts.profileInfo[2]["data"]['humidityLow'].toString(),
                  id: 3,
                ),
                ProfileWidget(
                  plantName: consts.profileInfo[3]['name'],
                  moisture:
                      consts.profileInfo[3]["data"]['moistureLow'].toString(),
                  light:
                      consts.profileInfo[3]["data"]['lightTimeLow'].toString() +
                          ' Hrs',
                  temperature:
                      consts.profileInfo[3]["data"]['tempLow'].toString(),
                  humidity:
                      consts.profileInfo[3]["data"]['humidityLow'].toString(),
                  id: 4,
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}

class ProfileWidget extends StatelessWidget {
  final GetProfileScreen getProfileScreen = Get.find();
  ProfileWidget(
      {Key key,
      this.humidity,
      this.light,
      this.moisture,
      this.plantName,
      this.plantPic,
      this.temperature,
      this.border,
      this.isChecked,
      this.id})
      : super(key: key);
  final plantName;
  final plantPic;
  final temperature;
  final humidity;
  final light;
  final moisture;
  final border;
  final isChecked;
  final id;
  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          margin: EdgeInsets.only(
            top: 20,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(5, 0),
                  spreadRadius: 2,
                  blurRadius: 15)
            ],
            borderRadius: BorderRadius.circular(10),
            border: getProfileScreen.checkedProfile.value ==
                    (consts.profileInfo[id - 1]['id'])
                ? Border.all(
                    color: Colors.green,
                    width: 2,
                  )
                : null,
          ),
          // height: 220,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        plantName,
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.normal,
                            color: Colors.black87),
                      ),
                      Row(
                        children: [],
                      )
                    ],
                  ),
                  Spacer(),
                  // CircleAvatar(
                  //   radius: 37,
                  // )
                  Obx(() => Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: ToggleSwitch(
                          // borderColor: [Colors.grey, Colors.grey],
                          activeBgColor: [Colors.green.shade800],
                          activeFgColor: Colors.white,
                          inactiveBgColor: Colors.grey,
                          inactiveFgColor: Colors.grey[900],
                          changeOnTap: false,
                          initialLabelIndex:
                              getProfileScreen.checkedProfile.value ==
                                      consts.profileInfo[id - 1]['id']
                                  ? 0
                                  : 1,
                          minHeight: 30,
                          minWidth: 50,
                          // changeOnTap: false,
                          totalSwitches: 2,
                          labels: ['on', 'off'],
                          onToggle: (index) =>
                              getProfileScreen.checkedProfile.value ==
                                      consts.profileInfo[id - 1]['id']
                                  ? print('no toggle')
                                  : getProfileScreen.changeProfile(
                                      consts.profileInfo[id - 1]['id']),
                        ),
                      ))
                ],
              ),
              Divider(
                thickness: 0.5,
                color: Colors.black,
                // endIndent: 20,
                // indent: 20,
                height: 25,
              ),
              Text('info',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
              SizedBox(
                height: 10,
              ),
              Container(
                // height: 80,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Tempearture :  ',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Text(temperature,
                                style: TextStyle(fontWeight: FontWeight.w500)),
                          ],
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Row(
                          children: [
                            Text(
                              'Humidity :  ',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(humidity,
                                style: TextStyle(fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Light :  ',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Text(light,
                                style: TextStyle(fontWeight: FontWeight.w500)),
                          ],
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Row(
                          children: [
                            Text(
                              'Moisture :  ',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(moisture,
                                style: TextStyle(fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

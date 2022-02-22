import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:get/get.dart';
import 'package:ghouse/src/models/modes.dart';
import 'package:ghouse/src/services/thingsboard_service.dart' as tbService;
// import 'package:ghouse/src/services/websocket_handler.dart';
import 'package:thingsboard_client/thingsboard_client.dart';
import 'package:ghouse/res/constant.dart' as consts;

class GetControlScreen extends GetxController {
  RxString mode = "auto".obs;
  RxString motor = "on".obs;
  RxString pump = "on".obs;
  RxString lamp = "on".obs;
  RxString fan = "on".obs;
  RxInt modeIndex = RxInt(0);
  Rx<consts.RequestStatus> changeModeRequstStatus =
      consts.RequestStatus.IDEL.obs;
  Rx<consts.RequestStatus> rpcRequstStatus = consts.RequestStatus.IDEL.obs;
  Rx<Color> ctrlbtnColor = Colors.white.obs;

  tbService.ThingsBoardService thingsBoardServic =
      tbService.ThingsBoardService();

  List<AttributesModel> attributeModel = [AttributesModel()];
  // WebSocketHandler attributeWSHandler;

  @override
  Future<void> onInit() async {
    initctrScreen();
    checkMode();
    super.onInit();
  }

  void initctrScreen() {
    var subscription = thingsBoardServic.attributeSubscription(
        entityId: consts.assetId,
        attributeScope: AttributeScope.SERVER_SCOPE.toShortString(),
        entityType: EntityType.ASSET);

    subscription.attributeDataStream.listen((attributeUpdate) {
      print('Received device attributes: $attributeUpdate');
      mode((attributeUpdate
          .firstWhere((element) => element.key == 'mode')
          .value));

      modeIndex(attributeUpdate
                  .firstWhere((element) => element.key == 'mode')
                  .value ==
              'auto'
          ? 0
          : 1);
      fan((attributeUpdate
          .firstWhere((element) => element.key == 'fan')
          .value));
      motor((attributeUpdate
          .firstWhere((element) => element.key == 'motor')
          .value));
      lamp((attributeUpdate
          .firstWhere((element) => element.key == 'lamp')
          .value));
      pump((attributeUpdate
          .firstWhere((element) => element.key == 'pump')
          .value));
      checkMode();
    });

    subscription.subscribe();
  }

  Future<void> changeMode(int index, BuildContext context) async {
    if (modeIndex.value != index) {
      final progress = ProgressHUD.of(context);

      var res;
      if (index == 0) {
        try {
          progress.showWithText('looding.. .');
          res = await thingsBoardServic.tbClient
              .getAttributeService()
              .saveEntityAttributesV2(
            EntityId.fromTypeAndUuid(EntityType.ASSET, consts.assetId),
            AttributeScope.SERVER_SCOPE.toShortString(),
            {"mode": "auto"},
          );
          print('index $index');
          print('index $index change mode');
          print(res);
          progress.dismiss();
        } on ThingsboardError {
          mode('auto');
          print(
              'Save Attribue Exception: \n Exception While Changing The Mode');
          progress.dismiss();
        } catch (e) {
          print(e);
        }
      } else {
        try {
          progress.showWithText('looding.. .');
          res = await thingsBoardServic.tbClient
              .getAttributeService()
              .saveEntityAttributesV2(
            EntityId.fromTypeAndUuid(EntityType.ASSET, consts.assetId),
            AttributeScope.SERVER_SCOPE.toShortString(),
            {"mode": "manual"},
          );

          print(res);
          print('index $index');
          print('index $index change mode');
          progress.dismiss();
        } on ThingsboardError {
          progress.dismiss();
          mode('manual');
          print(
              'Save Attribue Exception: \n Exception While Changing The Mode');
        } catch (e) {
          print(e);
        }
      }
    } else
      print('same');
  }

  void checkMode() {
    if (mode.value == "auto")
      ctrlbtnColor(Colors.transparent);
    else
      ctrlbtnColor(Colors.white);
  }

  ///sendRPC is a function that responsible of send manual control command to run
  ///or stop a device.
  ///### `CUTION` [We do not use the ID of The Device it Self]
  ///* `params`
  ///* `device id` is the ID  of the sensor That control the device when it's
  ///   running in the auto mode.
  ///* `Device Name` use FOr the Compartion.
  ///* `Current State` read the current state So we switch to anouther one.
  ///## 'Consideration When Using it.
  ///* The Id OF the device must be the Id of the related Sensor.
  ///* There Must be a Device That are Listennig.
  ///* `StatusCode 409` When No Device are Listennig.
  ///* `StatusCode 200` When The Device Get The Request.
  void sendRPC(
      {String deviceId,
      consts.Devices deviceName,
      RxString currentState,
      BuildContext context}) async {
    final progress = ProgressHUD.of(context);
    progress.showWithText('looding.. .');
    Map requestBody;
    switch (deviceName) {
      case consts.Devices.FAN:
        if (currentState.value == 'off')
          requestBody = consts.startFan;
        else
          requestBody = consts.stopFan;
        break;
      case consts.Devices.LAMP:
        if (currentState.value == 'off')
          requestBody = consts.startLamp;
        else
          requestBody = consts.stopLamp;
        break;
      case consts.Devices.MOTOR:
        if (currentState.value == 'off')
          requestBody = consts.startMotor;
        else
          requestBody = consts.stopMotor;
        break;
      case consts.Devices.PUMP:
        if (currentState.value == 'off')
          requestBody = consts.startPump;
        else
          requestBody = consts.stopPump;
        break;

      default:
    }
    try {
      await thingsBoardServic.tbClient
          .getDeviceService()
          .handleTwoWayDeviceRPCRequest(deviceId, requestBody);
      print(requestBody);
      progress.dismiss();
    } on ThingsboardError {
      progress.dismiss();
      print(rpcRequstStatus.value.toString() +
          'Thingsboard Exception: \nRPC Command Exception: \n Exception While Running an RPC command.');
    } catch (e) {
      progress.dismiss();
      print(e);
    }
  }
}

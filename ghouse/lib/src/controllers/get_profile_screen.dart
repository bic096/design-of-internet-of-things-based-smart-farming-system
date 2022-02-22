import 'package:get/get.dart';
import 'package:ghouse/src/services/thingsboard_service.dart' as tbService;
import 'package:thingsboard_client/thingsboard_client.dart';
import 'package:ghouse/res/constant.dart' as consts;

class GetProfileScreen extends GetxController {
  var checkedProfile = 1.obs;

  tbService.ThingsBoardService thingsBoardService =
      tbService.ThingsBoardService();
  @override
  void onInit() {
    initProScreen();
    super.onInit();
  }

  Future<void> changeProfile(int id) async {
    var profile = {
      "lightThrish": (consts.profileInfo[id - 1]['data']['lightTimeLow'] +
              consts.profileInfo[id - 1]['data']['lightTimeHight']) /
          2,
      "moisThrish": (consts.profileInfo[id - 1]['data']['moistureLow'] +
              consts.profileInfo[id - 1]['data']['moistureHight']) /
          2,
      "tempThrish": (consts.profileInfo[id - 1]['data']['tempLow'] +
              consts.profileInfo[id - 1]['data']['tempHight']) /
          2,
      "humThrish": (consts.profileInfo[id - 1]['data']['humidityLow'] +
              consts.profileInfo[id - 1]['data']['humidityHight']) /
          2,
      "checkedProfile": id
    };
    try {
      await thingsBoardService.tbClient
          .getAttributeService()
          .saveEntityAttributesV2(
            EntityId.fromTypeAndUuid(EntityType.ASSET, consts.assetId),
            AttributeScope.SERVER_SCOPE.toShortString(),
            profile,
          );
      checkedProfile(id);
    } on ThingsboardError {
      print('thingsboard error');
    } catch (e) {
      print(e);
    }
  }

  Future<void> initProScreen() async {
    var subscription = thingsBoardService.attributeSubscription(
        entityId: consts.assetId,
        attributeScope: AttributeScope.SERVER_SCOPE.toShortString(),
        entityType: EntityType.ASSET);

    subscription.attributeDataStream.listen((attributeUpdate) {
      print('Received device attributes: $attributeUpdate');
      checkedProfile(int.parse(attributeUpdate
          .firstWhere((element) => element.key == 'checkedProfile')
          .value));
    });

    var res = await thingsBoardService.tbClient
        .getAttributeService()
        .getAttributeKvEntries(
            EntityId.fromTypeAndUuid(EntityType.ASSET, consts.assetId),
            ["checkedProfile"]);
    print(int.parse(res[0].getLongValue().toString()));
    checkedProfile(res[0].getLongValue());

    subscription.subscribe();
  }
}

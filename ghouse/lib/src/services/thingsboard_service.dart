import 'package:thingsboard_client/thingsboard_client.dart';
import 'package:ghouse/res/constant.dart' as consts;

class ThingsBoardService {
  static final ThingsBoardService _thingsBoardService =
      ThingsBoardService._internal();
  static const thingsBoardApiEndpoint = 'http://${consts.host}:8080';
  static const username = 'tenant@thingsboard.org';
  static const password = 'tenant';

  factory ThingsBoardService() {
    return _thingsBoardService;
  }

  ThingsBoardService._internal();

  ThingsboardClient tbClient = ThingsboardClient(thingsBoardApiEndpoint);

  Future<void> initServer() async {
    await tbClient.login(LoginRequest(username, password));
  }

  TelemetrySubscriber attributeSubscription(
      {String entityId, String attributeScope, EntityType entityType}) {
    return TelemetrySubscriber.createEntityAttributesSubscription(
        telemetryService: tbClient.getTelemetryService(),
        entityId: EntityId.fromTypeAndUuid(entityType, entityId),
        attributeScope: attributeScope);
  }
}

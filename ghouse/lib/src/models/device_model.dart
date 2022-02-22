import "dart:convert";

DeviceModel deviceFromJson(String str) =>
    DeviceModel.fromJson(json.decode(str));

String deviceToJson(DeviceModel data) => json.encode(data.toJson());

class DeviceModel {
  DeviceModel(
      {this.subscriptionId,
      this.errorCode,
      this.errorMsg,
      this.data,
      this.latestValues});

  int subscriptionId;
  int errorCode;
  String errorMsg;
  // Map<String, List<List<Object>>> data;
  Map<String, dynamic> data;
  // var data;
  Map<String, dynamic> latestValues;

  factory DeviceModel.fromJson(Map<String, dynamic> json) => DeviceModel(
        subscriptionId:
            json["subscriptionId"] == null ? -1 : json["subscriptionId"],
        errorCode: json["errorCode"] == null ? -1 : json["errorCode"],
        errorMsg: json["errorMsg"] == null ? "null" : json["errorMsg"],
        data: json["data"] == null ? {"data": 'null'} : json["data"],
        latestValues:
            json["latestValues"] == null ? "null" : json["latestValues"],
      );

  Map<String, dynamic> toJson() => {
        "subscriptionId": subscriptionId,
        "errorCode": errorCode,
        "errorMsg": errorMsg,
        "data": data,
        "latestValues": latestValues,
      };
}

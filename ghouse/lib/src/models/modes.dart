// To parse this JSON data, do
//
//     final attributeModel = attributeModelFromJson(jsonString);

import 'dart:convert';

import 'package:thingsboard_client/thingsboard_client.dart';

List<AttributesModel> attributeModelFromJson(String str) =>
    List<AttributesModel>.from(
        json.decode(str).map((x) => AttributesModel.fromJson(x)));

String attributeModelToJson(List<AttributesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AttributesModel extends AttributeData {
  AttributesModel({
    this.lastUpdateTs,
    this.key,
    this.value,
  });

  int lastUpdateTs;
  String key;
  dynamic value;

  factory AttributesModel.fromJson(Map<String, dynamic> json) =>
      AttributesModel(
        lastUpdateTs: json["lastUpdateTs"],
        key: json["key"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "lastUpdateTs": lastUpdateTs,
        "key": key,
        "value": value,
      };
}

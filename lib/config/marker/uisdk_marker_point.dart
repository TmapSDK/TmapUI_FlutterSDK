import 'dart:convert';
import 'dart:core';
import 'package:json_annotation/json_annotation.dart';

// json serialize를 위해 자동 생성된 file
part 'uisdk_marker_point.g.dart';

// NOTE. if this class is changed, please run below command in project root folder.
// $ flutter pub run build_runner build
@JsonSerializable()
class UISDKMarkerPoint {
  @JsonKey(name: 'longitude')
  double longitude = 0.0;

  @JsonKey(name: 'latitude')
  double latitude = 0.0;

  UISDKMarkerPoint({this.latitude = 0,
    this.longitude = 0});

  // ref : https://flutter-ko.dev/docs/development/data-and-backend/json
  factory UISDKMarkerPoint.fromJson(Map<String, dynamic> json) => _$UISDKMarkerPointFromJson(json);
  Map<String, dynamic> toJson() => _$UISDKMarkerPointToJson(this);

  String toJsonString() => jsonEncode(this.toJson());
  factory UISDKMarkerPoint.fromJsonString(String json) => UISDKMarkerPoint.fromJson(jsonDecode(json));
}
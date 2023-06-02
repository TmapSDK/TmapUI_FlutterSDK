import 'dart:convert';
import 'dart:core';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmap_ui_sdk/config/marker/uisdk_marker.dart';

// json serialize를 위해 자동 생성된 file
part 'uisdk_marker_config.g.dart';

// NOTE. if this class is changed, please run below command in project root folder.
// $ flutter pub run build_runner build
@JsonSerializable()
class UISDKMarkerConfig {
  @JsonKey(name: 'marker_info')
  List<UISDKMarker>? markers;

  UISDKMarkerConfig({this.markers});

  // ref : https://flutter-ko.dev/docs/development/data-and-backend/json
  factory UISDKMarkerConfig.fromJson(Map<String, dynamic> json) => _$UISDKMarkerConfigFromJson(json);
  Map<String, dynamic> toJson() => _$UISDKMarkerConfigToJson(this);

  String toJsonString() => jsonEncode(this.toJson());
  factory UISDKMarkerConfig.fromJsonString(String json) => UISDKMarkerConfig.fromJson(jsonDecode(json));
}
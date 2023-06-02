import 'dart:convert';
import 'dart:core';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmap_ui_sdk/route/data/planning_option.dart';
import 'package:tmap_ui_sdk/route/data/route_point.dart';

// json serialize를 위해 자동 생성된 file
part 'route_request_data.g.dart';

// NOTE. if this class is changed, please run below command in project root folder.
// $ flutter pub run build_runner build
@JsonSerializable()
class RouteRequestData {
  @JsonKey(name: 'source')
  RoutePoint? source;

  @JsonKey(name: 'destination')
  RoutePoint? destination;

  @JsonKey(name: 'route_options')
  List<PlanningOption>? routeOption;

  @JsonKey(name: 'way_points')
  List<RoutePoint>? wayPoints;

  @JsonKey(name: 'guide_without_preview')
  bool guideWithoutPreview = false;

  @JsonKey(name: 'safe_driving')
  bool safeDriving = false;

  RouteRequestData({this.source,
    this.destination,
    this.routeOption,
    this.wayPoints,
    this.guideWithoutPreview = false,
    this.safeDriving = false});

  // ref : https://flutter-ko.dev/docs/development/data-and-backend/json
  factory RouteRequestData.fromJson(Map<String, dynamic> json) => _$RouteRequestDataFromJson(json);
  Map<String, dynamic> toJson() => _$RouteRequestDataToJson(this);

  String toJsonString() => jsonEncode(this.toJson());
  factory RouteRequestData.fromJsonString(String json) => RouteRequestData.fromJson(jsonDecode(json));

}

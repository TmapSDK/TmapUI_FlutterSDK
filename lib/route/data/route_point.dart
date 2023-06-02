import 'dart:convert';
import 'dart:core';
import 'package:json_annotation/json_annotation.dart';

// json serialize를 위해 자동 생성된 file
part 'route_point.g.dart';

// NOTE. if this class is changed, please run below command in project root folder.
// $ flutter pub run build_runner build
@JsonSerializable()
class RoutePoint {
  @JsonKey(name: 'longitude')
  double longitude = 0.0;

  @JsonKey(name: 'latitude')
  double latitude = 0.0;

  @JsonKey(name: 'name')
  String name = "";

  RoutePoint({this.longitude = 0.0,
    this.latitude = 0.0,
    this.name = ""});

  // ref : https://flutter-ko.dev/docs/development/data-and-backend/json
  factory RoutePoint.fromJson(Map<String, dynamic> json) => _$RoutePointFromJson(json);
  Map<String, dynamic> toJson() => _$RoutePointToJson(this);

  String toJsonString() => jsonEncode(this.toJson());
  factory RoutePoint.fromJsonString(String json) => RoutePoint.fromJson(jsonDecode(json));

}

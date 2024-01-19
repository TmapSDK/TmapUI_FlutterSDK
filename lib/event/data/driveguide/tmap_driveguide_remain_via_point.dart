import 'dart:convert';
import 'dart:core';
import 'package:json_annotation/json_annotation.dart';

// json serialize를 위해 자동 생성된 file
part 'tmap_driveguide_remain_via_point.g.dart';

// NOTE. if this class is changed, please run below command in project root folder.
// $ flutter pub run build_runner build
@JsonSerializable()
class TmapDriveGuideRemainViaPoint {
  /// 경유지 index (1부터 시작)
  @JsonKey(name: 'via_index')
  int viaIndex = 0;
  /// 경유지까지의 거리 (단위: 미터)
  @JsonKey(name: 'via_distance')
  int viaDistance = -1;
  /// 경유지까지의 소요시간 (단위: 초)
  @JsonKey(name: 'via_time')
  int viaTime = -1;
  /// 경유지의 위도
  @JsonKey(name: 'latitude')
  double viaLatitude;
  /// 경유지까지의 소요시간 (단위: 초)
  @JsonKey(name: 'longitude')
  double viaLongitude;

  TmapDriveGuideRemainViaPoint({this.viaIndex = -1,
    this.viaDistance = -1,
    this.viaTime = -1,
    this.viaLatitude = 0,
    this.viaLongitude = 0
  });

  // ref : https://flutter-ko.dev/docs/development/data-and-backend/json
  factory TmapDriveGuideRemainViaPoint.fromJson(Map<String, dynamic> json) => _$TmapDriveGuideRemainViaPointFromJson(json);
  Map<String, dynamic> toJson() => _$TmapDriveGuideRemainViaPointToJson(this);

  String toJsonString() => jsonEncode(this.toJson());
  factory TmapDriveGuideRemainViaPoint.fromJsonString(String json) => TmapDriveGuideRemainViaPoint.fromJson(jsonDecode(json));
}
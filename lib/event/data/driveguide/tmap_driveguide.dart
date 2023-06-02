import 'dart:convert';
import 'dart:core';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmap_ui_sdk/event/data/driveguide/tmap_driveguide_lane.dart';
import 'package:tmap_ui_sdk/event/data/driveguide/tmap_driveguide_remain_via_point.dart';
import 'package:tmap_ui_sdk/event/data/driveguide/tmap_driveguide_sdi.dart';
import 'package:tmap_ui_sdk/event/data/driveguide/tmap_driveguide_tbt.dart';

// json serialize를 위해 자동 생성된 file
part 'tmap_driveguide.g.dart';

enum GpsStatus {
  @JsonValue("noSignal") noSignal('noSignal'),
  @JsonValue("bad") bad('bad'),
  @JsonValue("good") good('good'),
  @JsonValue("tunnel") tunnel('tunnel'),
  @JsonValue("underpass") underpass('underpass'),
  ;
  final String text;
  const GpsStatus(this.text);

  factory GpsStatus.getByText(String text){
    return GpsStatus.values.firstWhere((value) => value.text == text,
        orElse: () => GpsStatus.noSignal);
  }
}

// NOTE. if this class is changed, please run below command in project root folder.
// $ flutter pub run build_runner build
@JsonSerializable()
class TmapDriveGuide {
  /// 현재의 속도를 나타냅니다. (kmh)
  @JsonKey(name: 'speed_in_kmh')
  int speedInKmPerHour = 0;
  /// 음영지역인지의 여부를 나타냅니다.
  @JsonKey(name: 'is_shade_area')
  bool isShadeArea = false;
  /// gps신호를 획득하지 못한지의 여부를 나타냅니다.
  @JsonKey(name: 'no_location_signal')
  bool noLocationSignal = false;
  /// gps상태를 나타냅니다.
  @JsonKey(name: 'gps_state')
  GpsStatus gpsState = GpsStatus.noSignal;
  /// dark mode의 여부를 나타냅니다.
  @JsonKey(name: 'is_night_mode')
  bool isNightMode = false;
  /// 현재 주행중인 도로의 이름을 나타냅니다.
  @JsonKey(name: 'current_road_name')
  String currentRoadName = "";
  /// 현재 주행중인 차선의 정보를 나타냅니다.
  @JsonKey(name: 'lane_info')
  TmapDriveGuideLane? laneInfo;

  /// SDI의 표시 여부를 나타냅니다.
  @JsonKey(name: 'show_sdi')
  bool showSDI = false;
  /// 제한속도의 존재여부를 나타냅니다.
  @JsonKey(name: 'is_caution')
  bool isCaution = false;
  /// 주행중인 평균 속도를 나타냅니다.
  @JsonKey(name: 'average_speed')
  int averageSpeed = 0;
  /// 제한속도를 나타냅니다.
  @JsonKey(name: 'limit_speed')
  int limitSpeed = 0;
  /// SDI의 정보를 나타냅니다.
  @JsonKey(name: 'first_sdi_info')
  TmapDriveGuideSDI? firstSDIInfo;

  /// TBT의 정보 존재여부를 나타냅니다.
  @JsonKey(name: 'has_tbt_info')
  bool hasTbtInfo = false;
  /// TBT의 정보를 나타냅니다.
  @JsonKey(name: 'first_tbt_info')
  TmapDriveGuideTBT? firstTBTInfo;

  /// 목적지까지의 남은 거리를 나타냅니다. (meter)
  @JsonKey(name: 'remain_distance_to_destination_in_meter')
  int remainDistanceToDestinationInMeter = 0;
  /// 목적지까지의 남은 시간을 나타냅니다. (초)
  @JsonKey(name: 'remain_time_to_destination_in_sec')
  int remainTimeToDestinationInSec = 0;

  /// 다음 경유지까지의 남은 거리를 나타냅니다. (meter)
  @JsonKey(name: 'remain_distance_to_go_position_in_meter')
  int remainDistanceToGoPositionInMeter = 0;
  /// 다음 경유지까지의 남은 시간을 나타냅니다. (초)
  @JsonKey(name: 'remain_time_to_go_position_in_sec')
  int remainTimeToGoPositionInSec = 0;
  /// 남은 경유지들의 정보
  @JsonKey(name: 'remain_via_point')
  List<TmapDriveGuideRemainViaPoint>? remainViaPoint;

  TmapDriveGuide({this.speedInKmPerHour = 0,
    this.isShadeArea = false,
    this.noLocationSignal = false,
    this.gpsState = GpsStatus.noSignal,
    this.isNightMode = false,
    this.currentRoadName = "",
    this.laneInfo,
    this.showSDI = false,
    this.isCaution = false,
    this.averageSpeed = 0,
    this.limitSpeed = 0,
    this.firstSDIInfo,
    this.hasTbtInfo = false,
    this.firstTBTInfo,
    this.remainDistanceToDestinationInMeter = 0,
    this.remainTimeToDestinationInSec = 0,
    this.remainDistanceToGoPositionInMeter = 0,
    this.remainTimeToGoPositionInSec = 0,
    this.remainViaPoint,
  });

  // ref : https://flutter-ko.dev/docs/development/data-and-backend/json
  factory TmapDriveGuide.fromJson(Map<String, dynamic> json) => _$TmapDriveGuideFromJson(json);
  Map<String, dynamic> toJson() => _$TmapDriveGuideToJson(this);

  String toJsonString() => jsonEncode(this.toJson());
  factory TmapDriveGuide.fromJsonString(String json) => TmapDriveGuide.fromJson(jsonDecode(json));
}
import 'dart:convert';
import 'dart:core';
import 'package:json_annotation/json_annotation.dart';

// json serialize를 위해 자동 생성된 file
part 'tmap_driveguide_lane.g.dart';

enum LaneTurnType {
  @JsonValue("uTurn") uTurn('uTurn'),
  @JsonValue("left") left('left'),
  @JsonValue("leftside") leftside('leftside'),
  @JsonValue("strait") strait('strait'),
  @JsonValue("rightside") rightside('rightside'),
  @JsonValue("right") right('right'),
  ;
  final String text;
  const LaneTurnType(this.text);

  factory LaneTurnType.getByText(String text){
    return LaneTurnType.values.firstWhere((value) => value.text == text,
        orElse: () => LaneTurnType.strait);
  }
}

enum LaneEtcType {
  @JsonValue("leftPocket") leftPocket('leftPocket'),
  @JsonValue("rightPocket") rightPocket('rightPocket'),
  @JsonValue("sky") sky('sky'),
  @JsonValue("underpass") underpass('underpass'),
  @JsonValue("rotary") rotary('rotary'),
  @JsonValue("pTurn") pTurn('pTurn'),
  @JsonValue("bus") bus('bus'),
  @JsonValue("suggestedLane") suggestedLane('suggestedLane'),
  ;
  final String text;
  const LaneEtcType(this.text);

  factory LaneEtcType.getByText(String text){
    return LaneEtcType.values.firstWhere((value) => value.text == text,
        orElse: () => LaneEtcType.suggestedLane);
  }
}

// NOTE. if this class is changed, please run below command in project root folder.
// $ flutter pub run build_runner build
@JsonSerializable()
class TmapDriveGuideLane {
  /// 차선의 표출여부를 나타냅니다.
  @JsonKey(name: 'show_lane')
  bool showLane = false;
  /// 차선의 수를 나타냅니다.
  @JsonKey(name: 'lane_count')
  int laneCount = 0;
  /// 차선까지의 거리를 나타냅니다.
  @JsonKey(name: 'lane_distance')
  int laneDistance = 0;
  /// 차선별 회전정보를 나타냅니다.
  @JsonKey(name: 'lane_turn_info')
  List<List<LaneTurnType>>? nLaneTurnInfo;
  /// 차선별 기타 정보를 나타냅니다.
  @JsonKey(name: 'lane_etc_info')
  List<List<LaneEtcType>>? nLaneEtcInfo;
  /// 주행가능한 회전정보를 나타냅니다. 차선수에 상관없이 가능한 회전은 1개만 존재합니다.
  @JsonKey(name: 'available_turn')
  LaneTurnType availableTurn = LaneTurnType.strait;

  TmapDriveGuideLane({this.showLane = false,
    this.laneCount = 0,
    this.laneDistance = 0,
    this.nLaneTurnInfo,
    this.nLaneEtcInfo,
    this.availableTurn = LaneTurnType.strait});

  // ref : https://flutter-ko.dev/docs/development/data-and-backend/json
  factory TmapDriveGuideLane.fromJson(Map<String, dynamic> json) => _$TmapDriveGuideLaneFromJson(json);
  Map<String, dynamic> toJson() => _$TmapDriveGuideLaneToJson(this);

  String toJsonString() => jsonEncode(this.toJson());
  factory TmapDriveGuideLane.fromJsonString(String json) => TmapDriveGuideLane.fromJson(jsonDecode(json));
}
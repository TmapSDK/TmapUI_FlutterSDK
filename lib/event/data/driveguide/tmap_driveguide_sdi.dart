import 'dart:convert';
import 'dart:core';
import 'package:json_annotation/json_annotation.dart';

// json serialize를 위해 자동 생성된 file
part 'tmap_driveguide_sdi.g.dart';

enum SDIType {
  @JsonValue("speedAccidentPos") speedAccidentPos('speedAccidentPos'),
  @JsonValue("speedLimitPos") speedLimitPos('speedLimitPos'),
  @JsonValue("speedBlockStartPos") speedBlockStartPos('speedBlockStartPos'),
  @JsonValue("speedBlockEndPos") speedBlockEndPos('speedBlockEndPos'),
  @JsonValue("speedBlockMidPos") speedBlockMidPos('speedBlockMidPos'),
  @JsonValue("tail") tail('tail'),
  @JsonValue("signalAccidentPos") signalAccidentPos('signalAccidentPos'),
  @JsonValue("speedLimitDangerousArea") speedLimitDangerousArea('speedLimitDangerousArea'),
  @JsonValue("boxSpeedLimitPos") boxSpeedLimitPos('boxSpeedLimitPos'),
  @JsonValue("busLane") busLane('busLane'),
  @JsonValue("changeroadPos") changeroadPos('changeroadPos'),
  @JsonValue("roadControlPos") roadControlPos('roadControlPos'),
  @JsonValue("intruderArea") intruderArea('intruderArea'),
  @JsonValue("trafficinfoCollectPos") trafficinfoCollectPos('trafficinfoCollectPos'),
  @JsonValue("cctvArea") cctvArea('cctvArea'),
  @JsonValue("overloadDangerousArea") overloadDangerousArea('overloadDangerousArea'),
  @JsonValue("loadBadControlPos") loadBadControlPos('loadBadControlPos'),
  @JsonValue("parkingControlPos") parkingControlPos('parkingControlPos'),
  @JsonValue("oneWayArea") oneWayArea('oneWayArea'),
  @JsonValue("railwayCrossing") railwayCrossing('railwayCrossing'),
  @JsonValue("schoolZoneStart") schoolZoneStart('schoolZoneStart'),
  @JsonValue("schoolZoneEnd") schoolZoneEnd('schoolZoneEnd'),
  @JsonValue("speedbump") speedbump('speedbump'),
  @JsonValue("lpgStation") lpgStation('lpgStation'),
  @JsonValue("tunnelArea") tunnelArea('tunnelArea'),
  @JsonValue("serviceArea") serviceArea('serviceArea'),
  @JsonValue("tollgate") tollgate('tollgate'),
  @JsonValue("fogArea") fogArea('fogArea'),
  @JsonValue("hazardousArea") hazardousArea('hazardousArea'),
  @JsonValue("accidentArea") accidentArea('accidentArea'),
  @JsonValue("sharpCurveArea") sharpCurveArea('sharpCurveArea'),
  @JsonValue("newCurveArea") newCurveArea('newCurveArea'),
  @JsonValue("slopeArea") slopeArea('slopeArea'),
  @JsonValue("roadKillArea") roadKillArea('roadKillArea'),
  @JsonValue("visualRightArea") visualRightArea('visualRightArea'),
  @JsonValue("visualFrontArea") visualFrontArea('visualFrontArea'),
  @JsonValue("visualLeftArea") visualLeftArea('visualLeftArea'),
  @JsonValue("signalViolationArea") signalViolationArea('signalViolationArea'),
  @JsonValue("speedDrivingArea") speedDrivingArea('speedDrivingArea'),
  @JsonValue("trafficCongestArea") trafficCongestArea('trafficCongestArea'),
  @JsonValue("directionLane") directionLane('directionLane'),
  @JsonValue("walkCrossArea") walkCrossArea('walkCrossArea'),
  @JsonValue("roadAccidentArea") roadAccidentArea('roadAccidentArea'),
  @JsonValue("speedAccidentArea") speedAccidentArea('speedAccidentArea'),
  @JsonValue("sleepAccidentArea") sleepAccidentArea('sleepAccidentArea'),
  @JsonValue("accidentPos") accidentPos('accidentPos'),
  @JsonValue("pedestrianAccidentPos") pedestrianAccidentPos('pedestrianAccidentPos'),
  @JsonValue("vehicleBurglaryPos") vehicleBurglaryPos('vehicleBurglaryPos'),
  @JsonValue("fallingArea") fallingArea('fallingArea'),
  @JsonValue("freezingArea") freezingArea('freezingArea'),
  @JsonValue("bottleneckPoint") bottleneckPoint('bottleneckPoint'),
  @JsonValue("mergePoint") mergePoint('mergePoint'),
  @JsonValue("crashArea") crashArea('crashArea'),
  @JsonValue("undergroundArea") undergroundArea('undergroundArea'),
  @JsonValue("trafficCalmingArea") trafficCalmingArea('trafficCalmingArea'),
  @JsonValue("interchange") interchange('interchange'),
  @JsonValue("junction") junction('junction'),
  @JsonValue("serviceAreaLpg") serviceAreaLpg('serviceAreaLpg'),
  @JsonValue("bridge") bridge('bridge'),
  @JsonValue("hwa03") hwa03('hwa03'),
  @JsonValue("hwa06") hwa06('hwa06'),
  @JsonValue("hwa09") hwa09('hwa09'),
  @JsonValue("goalOpposite") goalOpposite('goalOpposite'),
  @JsonValue("restPlace") restPlace('restPlace'),
  @JsonValue("sdiExhaustGasGrade") sdiExhaustGasGrade('sdiExhaustGasGrade'),
  @JsonValue("sdiTunnelChangeLanePos") sdiTunnelChangeLanePos('sdiTunnelChangeLanePos'),
  @JsonValue("unknown") unknown('unknown'),
  ;
  final String text;
  const SDIType(this.text);

  factory SDIType.getByText(String text){
    return SDIType.values.firstWhere((value) => value.text == text,
        orElse: () => SDIType.unknown);
  }
}

// NOTE. if this class is changed, please run below command in project root folder.
// $ flutter pub run build_runner build
@JsonSerializable()
class TmapDriveGuideSDI {
  /// Sdi의 종류를 나타냅니다.
  @JsonKey(name: 'sdi_type')
  SDIType sdiType = SDIType.unknown;
  /// 현 위치에서 SDI까지의 거리를 나타냅니다.
  @JsonKey(name: 'sdi_distance')
  int sdiDistance = -1;
  /// 제한속도가 있는 경우 제한속도를 나타냅니다.
  @JsonKey(name: 'sdi_speedlimit')
  int sdiSpeedLimit = -1;
  /// 구간단속 여부를 나타냅니다.
  @JsonKey(name: 'sdi_is_block_section')
  bool sdiIsBlockSection = false;
  /// 구간단속 시작지점까지의 거리를 나타냅니다.
  @JsonKey(name: 'sdi_block_distance')
  int sdiBlockDistance = -1;
  /// 구간단속 내의 제한속도를 나타냅니다.
  @JsonKey(name: 'sdi_block_speed')
  int sdiBlockSpeed = -1;
  /// 구간단속 내에서의 주행한 평균 속도를 나타냅니다.
  @JsonKey(name: 'sdi_block_average_speed')
  int sdiBlockAverageSpeed = -1;
  /// 구간단속 내에서의 주행 시간을 나타냅니다.
  @JsonKey(name: 'sdi_block_time')
  int sdiBlockTime = -1;
  /// 제한속도의 가변여부를 나타냅니다.
  @JsonKey(name: 'is_changable_speed_type')
  bool isChangableSpeedType = false;
  /// 구간시작점 및 구간종점 300m 지점에서 과속표지판 변경여부를 타나냅니다.
  @JsonKey(name: 'is_limit_speed_sign_changed')
  bool isLimitSpeedSignChanged = false;

  TmapDriveGuideSDI({this.sdiType = SDIType.unknown,
    this.sdiDistance = -1,
    this.sdiSpeedLimit = -1,
    this.sdiIsBlockSection = false,
    this.sdiBlockDistance = -1,
    this.sdiBlockSpeed = -1,
    this.sdiBlockAverageSpeed = -1,
    this.sdiBlockTime = -1,
    this.isChangableSpeedType = false,
    this.isLimitSpeedSignChanged = false});

  // ref : https://flutter-ko.dev/docs/development/data-and-backend/json
  factory TmapDriveGuideSDI.fromJson(Map<String, dynamic> json) => _$TmapDriveGuideSDIFromJson(json);
  Map<String, dynamic> toJson() => _$TmapDriveGuideSDIToJson(this);

  String toJsonString() => jsonEncode(this.toJson());
  factory TmapDriveGuideSDI.fromJsonString(String json) => TmapDriveGuideSDI.fromJson(jsonDecode(json));
}
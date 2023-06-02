// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tmap_driveguide_lane.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TmapDriveGuideLane _$TmapDriveGuideLaneFromJson(Map<String, dynamic> json) =>
    TmapDriveGuideLane(
      showLane: json['show_lane'] as bool? ?? false,
      laneCount: json['lane_count'] as int? ?? 0,
      laneDistance: json['lane_distance'] as int? ?? 0,
      nLaneTurnInfo: (json['lane_turn_info'] as List<dynamic>?)
          ?.map((e) => (e as List<dynamic>)
              .map((e) => $enumDecode(_$LaneTurnTypeEnumMap, e))
              .toList())
          .toList(),
      nLaneEtcInfo: (json['lane_etc_info'] as List<dynamic>?)
          ?.map((e) => (e as List<dynamic>)
              .map((e) => $enumDecode(_$LaneEtcTypeEnumMap, e))
              .toList())
          .toList(),
      availableTurn:
          $enumDecodeNullable(_$LaneTurnTypeEnumMap, json['available_turn']) ??
              LaneTurnType.strait,
    );

Map<String, dynamic> _$TmapDriveGuideLaneToJson(TmapDriveGuideLane instance) =>
    <String, dynamic>{
      'show_lane': instance.showLane,
      'lane_count': instance.laneCount,
      'lane_distance': instance.laneDistance,
      'lane_turn_info': instance.nLaneTurnInfo
          ?.map((e) => e.map((e) => _$LaneTurnTypeEnumMap[e]!).toList())
          .toList(),
      'lane_etc_info': instance.nLaneEtcInfo
          ?.map((e) => e.map((e) => _$LaneEtcTypeEnumMap[e]!).toList())
          .toList(),
      'available_turn': _$LaneTurnTypeEnumMap[instance.availableTurn]!,
    };

const _$LaneTurnTypeEnumMap = {
  LaneTurnType.uTurn: 'uTurn',
  LaneTurnType.left: 'left',
  LaneTurnType.leftside: 'leftside',
  LaneTurnType.strait: 'strait',
  LaneTurnType.rightside: 'rightside',
  LaneTurnType.right: 'right',
};

const _$LaneEtcTypeEnumMap = {
  LaneEtcType.leftPocket: 'leftPocket',
  LaneEtcType.rightPocket: 'rightPocket',
  LaneEtcType.sky: 'sky',
  LaneEtcType.underpass: 'underpass',
  LaneEtcType.rotary: 'rotary',
  LaneEtcType.pTurn: 'pTurn',
  LaneEtcType.bus: 'bus',
  LaneEtcType.suggestedLane: 'suggestedLane',
};

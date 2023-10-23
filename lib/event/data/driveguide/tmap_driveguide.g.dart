// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tmap_driveguide.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TmapDriveGuide _$TmapDriveGuideFromJson(Map<String, dynamic> json) =>
    TmapDriveGuide(
      speedInKmPerHour: json['speed_in_kmh'] as int? ?? 0,
      isShadeArea: json['is_shade_area'] as bool? ?? false,
      noLocationSignal: json['no_location_signal'] as bool? ?? false,
      gpsState: $enumDecodeNullable(_$GpsStatusEnumMap, json['gps_state']) ??
          GpsStatus.noSignal,
      isNightMode: json['is_night_mode'] as bool? ?? false,
      currentRoadName: json['current_road_name'] as String? ?? "",
      laneInfo: json['lane_info'] == null
          ? null
          : TmapDriveGuideLane.fromJson(
              json['lane_info'] as Map<String, dynamic>),
      showSDI: json['show_sdi'] as bool? ?? false,
      isCaution: json['is_caution'] as bool? ?? false,
      averageSpeed: json['average_speed'] as int? ?? 0,
      limitSpeed: json['limit_speed'] as int? ?? 0,
      firstSDIInfo: json['first_sdi_info'] == null
          ? null
          : TmapDriveGuideSDI.fromJson(
              json['first_sdi_info'] as Map<String, dynamic>),
      secondSDIInfo: json['second_sdi_info'] == null
          ? null
          : TmapDriveGuideSDI.fromJson(
          json['second_sdi_info'] as Map<String, dynamic>),
      hasTbtInfo: json['has_tbt_info'] as bool? ?? false,
      firstTBTInfo: json['first_tbt_info'] == null
          ? null
          : TmapDriveGuideTBT.fromJson(
              json['first_tbt_info'] as Map<String, dynamic>),
      secondTBTInfo: json['second_tbt_info'] == null
          ? null
          : TmapDriveGuideTBT.fromJson(
          json['second_tbt_info'] as Map<String, dynamic>),
      remainDistanceToDestinationInMeter:
          json['remain_distance_to_destination_in_meter'] as int? ?? 0,
      remainTimeToDestinationInSec:
          json['remain_time_to_destination_in_sec'] as int? ?? 0,
      remainViaPointSize:
          json['remain_via_point_size'] as int? ?? 0,
      remainDistanceToGoPositionInMeter:
          json['remain_distance_to_go_position_in_meter'] as int? ?? 0,
      remainTimeToGoPositionInSec:
          json['remain_time_to_go_position_in_sec'] as int? ?? 0,
      remainViaPoint: (json['remain_via_point'] as List<dynamic>?)
          ?.map((e) =>
              TmapDriveGuideRemainViaPoint.fromJson(e as Map<String, dynamic>))
          .toList(),
      matchedLatitude: json['matched_latitude'] as double? ?? 0,
      matchedLongitude: json['matched_longitude'] as double? ?? 0,
    );

Map<String, dynamic> _$TmapDriveGuideToJson(TmapDriveGuide instance) =>
    <String, dynamic>{
      'speed_in_kmh': instance.speedInKmPerHour,
      'is_shade_area': instance.isShadeArea,
      'no_location_signal': instance.noLocationSignal,
      'gps_state': _$GpsStatusEnumMap[instance.gpsState]!,
      'is_night_mode': instance.isNightMode,
      'current_road_name': instance.currentRoadName,
      'lane_info': instance.laneInfo,
      'show_sdi': instance.showSDI,
      'is_caution': instance.isCaution,
      'average_speed': instance.averageSpeed,
      'limit_speed': instance.limitSpeed,
      'first_sdi_info': instance.firstSDIInfo,
      'second_sdi_info': instance.secondSDIInfo,
      'has_tbt_info': instance.hasTbtInfo,
      'first_tbt_info': instance.firstTBTInfo,
      'second_tbt_info': instance.secondTBTInfo,
      'remain_distance_to_destination_in_meter':
          instance.remainDistanceToDestinationInMeter,
      'remain_time_to_destination_in_sec':
          instance.remainTimeToDestinationInSec,
      'remain_via_point_size':
          instance.remainViaPointSize,
      'remain_distance_to_go_position_in_meter':
          instance.remainDistanceToGoPositionInMeter,
      'remain_time_to_go_position_in_sec': instance.remainTimeToGoPositionInSec,
      'remain_via_point': instance.remainViaPoint,
      'matched_latitude': instance.matchedLatitude,
      'matched_longitude': instance.matchedLongitude,
    };

const _$GpsStatusEnumMap = {
  GpsStatus.noSignal: 'noSignal',
  GpsStatus.bad: 'bad',
  GpsStatus.good: 'good',
  GpsStatus.tunnel: 'tunnel',
  GpsStatus.underpass: 'underpass',
};

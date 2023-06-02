// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tmap_driveguide_remain_via_point.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TmapDriveGuideRemainViaPoint _$TmapDriveGuideRemainViaPointFromJson(
        Map<String, dynamic> json) =>
    TmapDriveGuideRemainViaPoint(
      viaIndex: json['via_index'] as int? ?? -1,
      viaDistance: json['via_distance'] as int? ?? -1,
      viaTime: json['via_time'] as int? ?? -1,
    );

Map<String, dynamic> _$TmapDriveGuideRemainViaPointToJson(
        TmapDriveGuideRemainViaPoint instance) =>
    <String, dynamic>{
      'via_index': instance.viaIndex,
      'via_distance': instance.viaDistance,
      'via_time': instance.viaTime,
    };

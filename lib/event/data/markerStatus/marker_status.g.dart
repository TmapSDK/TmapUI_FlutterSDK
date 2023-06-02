// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'marker_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarkerStatus _$MarkerStatusFromJson(Map<String, dynamic> json) => MarkerStatus(
      markerId: json['selected_marker_id'] as String? ?? "",
      markerType: $enumDecodeNullable(
              _$SelectedMarkerTypeEnumMap, json['selected_marker_type']) ??
          SelectedMarkerType.point,
    );

Map<String, dynamic> _$MarkerStatusToJson(MarkerStatus instance) =>
    <String, dynamic>{
      'selected_marker_id': instance.markerId,
      'selected_marker_type': _$SelectedMarkerTypeEnumMap[instance.markerType]!,
    };

const _$SelectedMarkerTypeEnumMap = {
  SelectedMarkerType.point: 'point',
  SelectedMarkerType.callout: 'callout',
};

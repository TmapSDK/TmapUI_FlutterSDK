// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'uisdk_marker.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UISDKMarker _$UISDKMarkerFromJson(Map<String, dynamic> json) => UISDKMarker(
      markerPoint: (json['marker_point'] as List<dynamic>?)
          ?.map((e) => UISDKMarkerPoint.fromJson(e as Map<String, dynamic>))
          .toList(),
      markerId: json['marker_id'] as String? ?? "",
      imageName: json['image_name'] as String? ?? "",
      markerType:
          $enumDecodeNullable(_$MarkerTypeEnumMap, json['marker_type']) ??
              MarkerType.point,
    );

Map<String, dynamic> _$UISDKMarkerToJson(UISDKMarker instance) =>
    <String, dynamic>{
      'marker_point': instance.markerPoint,
      'marker_id': instance.markerId,
      'image_name': instance.imageName,
      'marker_type': _$MarkerTypeEnumMap[instance.markerType]!,
    };

const _$MarkerTypeEnumMap = {
  MarkerType.point: 'point',
  MarkerType.line: 'line',
};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'uisdk_marker_point.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UISDKMarkerPoint _$UISDKMarkerPointFromJson(Map<String, dynamic> json) =>
    UISDKMarkerPoint(
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$UISDKMarkerPointToJson(UISDKMarkerPoint instance) =>
    <String, dynamic>{
      'longitude': instance.longitude,
      'latitude': instance.latitude,
    };

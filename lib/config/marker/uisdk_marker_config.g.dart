// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'uisdk_marker_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UISDKMarkerConfig _$UISDKMarkerConfigFromJson(Map<String, dynamic> json) =>
    UISDKMarkerConfig(
      markers: (json['marker_info'] as List<dynamic>?)
          ?.map((e) => UISDKMarker.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UISDKMarkerConfigToJson(UISDKMarkerConfig instance) =>
    <String, dynamic>{
      'marker_info': instance.markers,
    };

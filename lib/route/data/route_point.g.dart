// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_point.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoutePoint _$RoutePointFromJson(Map<String, dynamic> json) => RoutePoint(
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      name: json['name'] as String? ?? "",
    );

Map<String, dynamic> _$RoutePointToJson(RoutePoint instance) =>
    <String, dynamic>{
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'name': instance.name,
    };

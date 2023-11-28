// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_request_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RouteRequestData _$RouteRequestDataFromJson(Map<String, dynamic> json) =>
    RouteRequestData(
      source: json['source'] == null
          ? null
          : RoutePoint.fromJson(json['source'] as Map<String, dynamic>),
      destination: json['destination'] == null
          ? null
          : RoutePoint.fromJson(json['destination'] as Map<String, dynamic>),
      routeOption: (json['route_options'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$PlanningOptionEnumMap, e))
          .toList(),
      wayPoints: (json['way_points'] as List<dynamic>?)
          ?.map((e) => RoutePoint.fromJson(e as Map<String, dynamic>))
          .toList(),
      guideWithoutPreview: json['guide_without_preview'] as bool? ?? false,
      safeDriving: json['safe_driving'] as bool? ?? false,
      continueDriving: json['continue_driving'] as bool? ?? false,
    );

Map<String, dynamic> _$RouteRequestDataToJson(RouteRequestData instance) =>
    <String, dynamic>{
      'source': instance.source,
      'destination': instance.destination,
      'route_options': instance.routeOption
          ?.map((e) => _$PlanningOptionEnumMap[e]!)
          .toList(),
      'way_points': instance.wayPoints,
      'guide_without_preview': instance.guideWithoutPreview,
      'safe_driving': instance.safeDriving,
      'continue_driving': instance.continueDriving,
    };

const _$PlanningOptionEnumMap = {
  PlanningOption.recommend: 'Traffic_Recommend',
  PlanningOption.minTime: 'Traffic_MinTime',
  PlanningOption.free: 'Traffic_Free',
  PlanningOption.shortest: 'Shortest_ChargedAndFree',
  PlanningOption.highway: 'Traffic_Highway',
  PlanningOption.firstTime: 'Traffic_FirstTime',
  PlanningOption.generalRoad: 'Traffic_GeneralRoad',
  PlanningOption.truck: 'Traffic_Truck',
  PlanningOption.avoidSchoolZone: 'Traffic_AvoidSchoolZone',
};

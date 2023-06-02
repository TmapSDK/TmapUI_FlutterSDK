// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'uisdk_truck_option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UISDKTruckOption _$UISDKTruckOptionFromJson(Map<String, dynamic> json) =>
    UISDKTruckOption(
      truckHeight: json['truck_height'] as int? ?? 0,
      truckLoadingWeight: json['truck_load_weight'] as int? ?? 0,
      truckType: $enumDecodeNullable(_$TruckTypeEnumMap, json['truck_type']) ??
          TruckType.none,
      truckWidth: json['truck_width'] as int? ?? 0,
      truckLength: json['truck_length'] as int? ?? 0,
    );

Map<String, dynamic> _$UISDKTruckOptionToJson(UISDKTruckOption instance) =>
    <String, dynamic>{
      'truck_height': instance.truckHeight,
      'truck_load_weight': instance.truckLoadingWeight,
      'truck_type': _$TruckTypeEnumMap[instance.truckType]!,
      'truck_width': instance.truckWidth,
      'truck_length': instance.truckLength,
    };

const _$TruckTypeEnumMap = {
  TruckType.none: 'None',
  TruckType.truck: 'Truck',
  TruckType.constructionTruck: 'ConstructionTruck',
  TruckType.specialTruck: 'SpecialTruck',
  TruckType.dangerousTruck: 'DangerousTruck',
  TruckType.car: 'Car',
  TruckType.van: 'Van',
  TruckType.bus: 'Bus',
};

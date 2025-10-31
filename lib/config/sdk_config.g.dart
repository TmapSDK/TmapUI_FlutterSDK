// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sdk_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SDKConfig _$SDKConfigFromJson(Map<String, dynamic> json) => SDKConfig(
      carType: $enumDecodeNullable(_$UISDKCarModelEnumMap, json['car_type']) ??
          UISDKCarModel.normal,
      truckOption: json['truck_option'] == null
          ? null
          : UISDKTruckOption.fromJson(
              json['truck_option'] as Map<String, dynamic>),
      fuelType: $enumDecodeNullable(_$UISDKFuelEnumMap, json['fuel_type']) ??
          UISDKFuel.gas,
      showTrafficAccident: json['show_traffic_accident'] as bool? ?? true,
      mapTextSize: $enumDecodeNullable(
              _$UISDKMapFontSizeEnumMap, json['map_text_size']) ??
          UISDKMapFontSize.medium,
      nightMode: $enumDecodeNullable(
              _$UISDKAutoNightModeTypeEnumMap, json['night_mode']) ??
          UISDKAutoNightModeType.auto,
      isUseSpeedReactMapScale:
          json['is_use_speed_react_map_scale'] as bool? ?? true,
      isShowTrafficInRoute: json['is_show_traffic_in_route'] as bool? ?? true,
      isShowExitPopupWhenStopDriving:
          json['is_show_exit_popup_in_stop_driving'] as bool? ?? true,
      useRealTimeAutoReroute:
          json['use_realtime_auto_reroute'] as bool? ?? true,
      suspendInBackground: json['suspend_in_background'] as bool? ?? true,
    );

Map<String, dynamic> _$SDKConfigToJson(SDKConfig instance) => <String, dynamic>{
      'car_type': _$UISDKCarModelEnumMap[instance.carType]!,
      'truck_option': instance.truckOption,
      'fuel_type': _$UISDKFuelEnumMap[instance.fuelType]!,
      'show_traffic_accident': instance.showTrafficAccident,
      'map_text_size': _$UISDKMapFontSizeEnumMap[instance.mapTextSize]!,
      'night_mode': _$UISDKAutoNightModeTypeEnumMap[instance.nightMode]!,
      'is_use_speed_react_map_scale': instance.isUseSpeedReactMapScale,
      'is_show_traffic_in_route': instance.isShowTrafficInRoute,
      'is_show_exit_popup_when_stop_driving': instance.isShowExitPopupWhenStopDriving,
      'use_realtime_auto_reroute': instance.useRealTimeAutoReroute,
      'suspend_in_background': instance.suspendInBackground
    };

const _$UISDKCarModelEnumMap = {
  UISDKCarModel.compact: 'CT_COMPACT',
  UISDKCarModel.normal: 'CT_NORMAL',
  UISDKCarModel.middle: 'CT_MIDDLE',
  UISDKCarModel.large: 'CT_LARGE',
  UISDKCarModel.smallTruck: 'CT_SMALL_TRUCK',
  UISDKCarModel.truck: 'CT_TRUCK',
  UISDKCarModel.special: 'CT_SPECIAL',
};

const _$UISDKFuelEnumMap = {
  UISDKFuel.gas: 'FT_GAS',
  UISDKFuel.diesel: 'FT_DIESEL',
  UISDKFuel.lpg: 'FT_LPG',
  UISDKFuel.gaspm: 'FT_GASPM',
  UISDKFuel.ev: 'FT_EV',
};

const _$UISDKMapFontSizeEnumMap = {
  UISDKMapFontSize.small: '작게',
  UISDKMapFontSize.medium: '보통',
  UISDKMapFontSize.large: '크게',
};

const _$UISDKAutoNightModeTypeEnumMap = {
  UISDKAutoNightModeType.auto: '자동',
  UISDKAutoNightModeType.allways: '항상 사용',
  UISDKAutoNightModeType.never: '사용 안함',
};

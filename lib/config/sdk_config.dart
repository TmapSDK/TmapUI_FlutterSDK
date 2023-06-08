import 'dart:convert';
import 'dart:core';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmap_ui_sdk/config/uisdk_truck_option.dart';

// json serialize를 위해 자동 생성된 file
part 'sdk_config.g.dart';

enum UISDKCarModel {
  @JsonValue("CT_COMPACT")      compact('CT_COMPACT'),          // 경차
  @JsonValue("CT_NORMAL")       normal('CT_NORMAL'),            // 승용차
  @JsonValue("CT_MIDDLE")       middle('CT_MIDDLE'),            // 중형승합차
  @JsonValue("CT_LARGE")        large('CT_LARGE'),              // 대형승합차
  @JsonValue("CT_SMALL_TRUCK")  smallTruck('CT_SMALL_TRUCK'),   // 소형화물차
  @JsonValue("CT_TRUCK")        truck('CT_TRUCK'),              // 대형화물차
  @JsonValue("CT_SPECIAL")      special('CT_SPECIAL'),          // 특수화물차
;
  final String text;
  const UISDKCarModel(this.text);

  factory UISDKCarModel.getByText(String text){
    return UISDKCarModel.values.firstWhere((value) => value.text == text,
        orElse: () => UISDKCarModel.normal);
  }
}

enum UISDKFuel {
  @JsonValue("FT_GAS")    gas('FT_GAS'),      // 휘발유
  @JsonValue("FT_DIESEL") diesel('FT_DIESEL'),// 경유
  @JsonValue("FT_LPG")    lpg('FT_LPG'),      // LPG
  @JsonValue("FT_GASPM")  gaspm('FT_GASPM'),  // 고급휘발유
  @JsonValue("FT_EV")     ev('FT_EV');        // 전기

  final String text;
  const UISDKFuel(this.text);

  factory UISDKFuel.getByText(String text){
    return UISDKFuel.values.firstWhere((value) => value.text == text,
        orElse: () => UISDKFuel.gas);
  }
}

enum UISDKMapFontSize {
  @JsonValue("작게") small('작게'),
  @JsonValue("보통") medium('보통'),
  @JsonValue("크게") large('크게');

  final String text;
  const UISDKMapFontSize(this.text);

  factory UISDKMapFontSize.getByText(String text){
    return UISDKMapFontSize.values.firstWhere((value) => value.text == text,
        orElse: () => UISDKMapFontSize.medium);
  }
}

enum UISDKAutoNightModeType {
  @JsonValue("자동")       auto('자동'),
  @JsonValue("항상 사용")   allways('항상 사용'),
  @JsonValue("사용 안함")   never('사용 안함');

  final String text;
  const UISDKAutoNightModeType(this.text);

  factory UISDKAutoNightModeType.getByText(String text){
    return UISDKAutoNightModeType.values.firstWhere((value) => value.text == text,
        orElse: () => UISDKAutoNightModeType.auto);
  }
}

// NOTE. if this class is changed, please run below command in project root folder.
// $ flutter pub run build_runner build
@JsonSerializable()
class SDKConfig {
  /// 자동차의 종류
  @JsonKey(name: 'car_type')
  UISDKCarModel carType = UISDKCarModel.normal;

  /// truck 정보
  @JsonKey(name: 'truck_option')
  UISDKTruckOption? truckOption = null;

  /// 자동차 연로 종류
  @JsonKey(name: 'fuel_type')
  UISDKFuel fuelType = UISDKFuel.gas;

  /// Map상에서 교통량 및 사고정보 표시 여부
  @JsonKey(name: 'show_traffic_accident')
  bool showTrafficAccident = true;

  /// Map의 text size
  @JsonKey(name: 'map_text_size')
  UISDKMapFontSize mapTextSize = UISDKMapFontSize.medium;

  /// 야간지도 사용 설정
  @JsonKey(name: 'night_mode')
  UISDKAutoNightModeType nightMode = UISDKAutoNightModeType.auto;

  /// 속도 반응형 지도 사용 여부
  @JsonKey(name: 'is_use_speed_react_map_scale')
  bool isUseSpeedReactMapScale = true;

  /// 안내 경로의 교통정보 on/off
  @JsonKey(name: 'is_show_traffic_in_route')
  bool isShowTrafficInRoute = true;

  /// 경로안내 종료 시 popup on/off
  @JsonKey(name: 'is_show_exit_popup_when_stop_driving')
  bool isShowExitPopupWhenStopDriving = true;

  SDKConfig({this.carType = UISDKCarModel.normal,
    this.truckOption = null,
    this.fuelType = UISDKFuel.gas,
    this.showTrafficAccident = true,
    this.mapTextSize = UISDKMapFontSize.medium,
    this.nightMode = UISDKAutoNightModeType.auto,
    this.isUseSpeedReactMapScale = true,
    this.isShowTrafficInRoute = true,
    this.isShowExitPopupWhenStopDriving = true});

  // ref : https://flutter-ko.dev/docs/development/data-and-backend/json
  factory SDKConfig.fromJson(Map<String, dynamic> json) => _$SDKConfigFromJson(json);
  Map<String, dynamic> toJson() => _$SDKConfigToJson(this);

  String toJsonString() => jsonEncode(this.toJson());
  factory SDKConfig.fromJsonString(String json) => SDKConfig.fromJson(jsonDecode(json));
}

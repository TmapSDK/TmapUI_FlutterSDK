import 'dart:convert';
import 'dart:core';
import 'package:json_annotation/json_annotation.dart';

// json serialize를 위해 자동 생성된 file
part 'uisdk_truck_option.g.dart';

enum TruckType {
  @JsonValue("None")              none('None'),                             // 선택없음
  @JsonValue("Truck")             truck('Truck'),                           // 화물자동차
  @JsonValue("ConstructionTruck") constructionTruck('ConstructionTruck'),   // 건설기계
  @JsonValue("SpecialTruck")      specialTruck('SpecialTruck'),             // 특수자동차
  @JsonValue("DangerousTruck")    dangerousTruck('DangerousTruck'),         // 고압가스/위험물적재차량
  @JsonValue("Car")               car('Car'),                               // 승용차, 소형승합차 (15인승 이하)
  @JsonValue("Van")               van('Van'),                               // 중형승합차(16~32인승, 길이 9m 미만)
  @JsonValue("Bus")               bus('Bus'),                               // 대형승합차(33인승 이상, 길이 9m 이상)
  ;
  final String text;
  const TruckType(this.text);

  factory TruckType.getByText(String text){
    return TruckType.values.firstWhere((value) => value.text == text,
        orElse: () => TruckType.none);
  }
}

// NOTE. if this class is changed, please run below command in project root folder.
// $ flutter pub run build_runner build
@JsonSerializable()
class UISDKTruckOption {
  /// truck의 높이를 나타냅니다. (단위 : cm)
  @JsonKey(name: 'truck_height')
  int truckHeight = 0;
  /// truck의 적재중량을 나타냅니다. (단위 : kg)
  @JsonKey(name: 'truck_load_weight')
  int truckLoadingWeight = 0;
  /// truck의 종류를 나타냅니다.
  ///     None    선택없음
  ///     Truck    화물자동차
  ///     constructionTruck    건설기계
  ///     SpecialTruck    특수자동차
  ///     DangerousTruck    고압가스/위험물적재차량
  ///     Car    승용차, 소형승합차 (15인승 이하)
  ///     Van    중형승합차(16~32인승, 길이 9m 미만)
  ///     Bus    대형승합차(33인승 이상, 길이 9m 이상)
  @JsonKey(name: 'truck_type')
  TruckType truckType = TruckType.none;
  /// truck의 폭을 나타냅니다. (단위 : cm)
  @JsonKey(name: 'truck_width')
  int truckWidth = 0;
  /// truck의 길이를 나타냅니다. (단위 : cm)
  @JsonKey(name: 'truck_length')
  int truckLength = 0;

  UISDKTruckOption({this.truckHeight = 0,
    this.truckLoadingWeight = 0,
    this.truckType = TruckType.none,
    this.truckWidth = 0,
    this.truckLength = 0});

  // ref : https://flutter-ko.dev/docs/development/data-and-backend/json
  factory UISDKTruckOption.fromJson(Map<String, dynamic> json) => _$UISDKTruckOptionFromJson(json);
  Map<String, dynamic> toJson() => _$UISDKTruckOptionToJson(this);

  String toJsonString() => jsonEncode(this.toJson());
  factory UISDKTruckOption.fromJsonString(String json) => UISDKTruckOption.fromJson(jsonDecode(json));
}
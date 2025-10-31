import 'dart:convert';
import 'dart:core';
import 'package:json_annotation/json_annotation.dart';

// json serialize를 위해 자동 생성된 file
part 'auth_data.g.dart';

// NOTE. if this class is changed, please run below command in project root folder.
// $ flutter pub run build_runner build
@JsonSerializable()
class AuthData {
  /// SDK가 적용된 service이름
  @JsonKey(name: 'client_service_name')
  String clientServiceName;

  /// SDK가 적용된 app version
  @JsonKey(name: 'client_app_version')
  String clientAppVersion;

  /// 발급받은 ClientID
  @JsonKey(name: 'client_id')
  String clientID;

  /// 발급받은 apiKey - 필수
  @JsonKey(name: 'client_api_key')
  String clientApiKey;

  /// 발급받은 apCode
  @JsonKey(name: 'client_ap_code')
  String clientApCode;

  /// 인증에 필요한 사용자 key
  @JsonKey(name: 'user_key')
  String userKey;

  /// 인증에 필요한 Device key
  @JsonKey(name: 'device_key')
  String deviceKey;

  /// 사용자를 식별하기 위한 ID
  /// 빈문자열 또는 Null을 입력하게 되면 SDK내부적으로 uuid형태를 생성하여 이용하게 됨.
  @JsonKey(name: 'client_device_id')
  String clientDeviceId;

  /// SDK가 백그라운드에서 동작할지 여부 on/off
  /// true로 한다면 Xcode에서 Background Mode > Location을 필수로 켜줘야 함.
  @JsonKey(name: 'is_available_in_background')
  bool isAvailableInBackground;

  AuthData({this.clientServiceName = "",
      this.clientAppVersion = "",
      this.clientID = "",
      this.clientApiKey = "", //필수
      this.clientApCode = "",
      this.userKey = "",
      this.deviceKey = "",
      this.clientDeviceId = "",
      this.isAvailableInBackground = false});

  // ref : https://flutter-ko.dev/docs/development/data-and-backend/json
  factory AuthData.fromJson(Map<String, dynamic> json) => _$AuthDataFromJson(json);
  Map<String, dynamic> toJson() => _$AuthDataToJson(this);

  String toJsonString() => jsonEncode(this.toJson());
  factory AuthData.fromJsonString(String json) => AuthData.fromJson(jsonDecode(json));
}
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthData _$AuthDataFromJson(Map<String, dynamic> json) => AuthData(
      clientServiceName: json['client_service_name'] as String? ?? "",
      clientAppVersion: json['client_app_version'] as String? ?? "",
      clientID: json['client_id'] as String? ?? "",
      clientApiKey: json['client_api_key'] as String? ?? "",
      clientApCode: json['client_ap_code'] as String? ?? "",
      userKey: json['user_key'] as String? ?? "",
      deviceKey: json['device_key'] as String? ?? "",
      clientDeviceId: json['client_device_id'] as String? ?? "",
    );

Map<String, dynamic> _$AuthDataToJson(AuthData instance) => <String, dynamic>{
      'client_service_name': instance.clientServiceName,
      'client_app_version': instance.clientAppVersion,
      'client_id': instance.clientID,
      'client_api_key': instance.clientApiKey,
      'client_ap_code': instance.clientApCode,
      'user_key': instance.userKey,
      'device_key': instance.deviceKey,
      'client_device_id': instance.clientDeviceId,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tmap_sdk_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TmapSDKStatusMsg _$TmapSDKStatusMsgFromJson(Map<String, dynamic> json) =>
    TmapSDKStatusMsg(
      sdkStatus:
      $enumDecodeNullable(_$TmapSDKStatusEnumMap, json['sdk_status']) ??
          TmapSDKStatus.none,
      extraData: json['status_extra_data'] as String? ?? "",
    );

Map<String, dynamic> _$TmapSDKStatusMsgToJson(TmapSDKStatusMsg instance) =>
    <String, dynamic>{
      'sdk_status': instance.sdkStatus,
      'status_extra_data': instance.extraData,
    };

const _$TmapSDKStatusEnumMap = {
  TmapSDKStatus.none: 'none',
  TmapSDKStatus.mapInitializing: 'mapInitializing',
  TmapSDKStatus.requestingAuth: 'requestingAuth',
  TmapSDKStatus.vsmError: 'vsmError',
  TmapSDKStatus.authError: 'authError',
  TmapSDKStatus.completed: 'completed',
  TmapSDKStatus.ready: 'ready',
  TmapSDKStatus.dismissReq: 'dismissReq',
  TmapSDKStatus.dismissNRequestPermission: 'dismissNRequestPermission',
  TmapSDKStatus.requestPermission: 'requestPermission',
  TmapSDKStatus.finished: 'finished',
  TmapSDKStatus.savedDriveInfo: 'savedDriveInfo',
};

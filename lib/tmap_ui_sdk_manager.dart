import 'dart:async';

import 'package:tmap_ui_sdk/config/marker/uisdk_marker_config.dart';
import 'package:tmap_ui_sdk/config/sdk_config.dart';
import 'package:tmap_ui_sdk/event/data/driveStatus/tmap_drivestatus.dart';
import 'package:tmap_ui_sdk/event/data/driveguide/tmap_driveguide.dart';
import 'package:tmap_ui_sdk/event/data/markerStatus/marker_status.dart';
import 'package:tmap_ui_sdk/event/data/sdkStatus/tmap_sdk_status.dart';
import 'package:tmap_ui_sdk/tmap_ui_sdk_method_channel.dart';
import 'package:tmap_ui_sdk/tmap_ui_sdk_platform_interface.dart';

import 'auth/data/auth_data.dart';
import 'auth/data/init_result.dart';

// ignore_for_file: camel_case_types
typedef onTmapSDKStatusAvailable = Function(TmapSDKStatusMsg status);
typedef onMarkerStatusAvailable = Function(MarkerStatus status);
typedef onTmapDriveGuideAvailable = Function(TmapDriveGuide guide);
typedef onTmapDriveStatusAvailable = Function(TmapDriveStatus status);

class TmapUISDKManager {
  TmapUISDKManager._privateConstructor();
  static final TmapUISDKManager _instance = TmapUISDKManager._privateConstructor();

  factory TmapUISDKManager() {
    return _instance;
  }

  /// SDK초기화 진행
  Future<InitResult?> initSDK(AuthData authInfo) async {
    MethodChannelTmapUiSdk channel = MethodChannelTmapUiSdk();
    final result = await channel.initSDK(authInfo);
    return result;
  }

  /// SDK종료
  Future<bool?> finalizeSDK() async {
    MethodChannelTmapUiSdk channel = MethodChannelTmapUiSdk();
    final result = await channel.finalizeSDK();
    return result;
  }

  /// SDK설정
  Future<bool?> setConfigSDK(SDKConfig configInfo) async {
    MethodChannelTmapUiSdk channel = MethodChannelTmapUiSdk();
    final result = await channel.configSDK(configInfo);
    return result;
  }

  /// 주행종료
  Future<bool?> stopDriving() async {
    MethodChannelTmapUiSdk channel = MethodChannelTmapUiSdk();
    final result = await channel.stopDriving();
    return result;
  }

  /// 저장되어 있는 이어가기 주행정보를 삭제합니다.
  Future<bool?> clearContinueDriveInfo() async {
    MethodChannelTmapUiSdk channel = MethodChannelTmapUiSdk();
    final result = await channel.clearContinueDriveInfo();
    return result;
  }

  /// custom marker 설정
  Future<bool?> configMarker(UISDKMarkerConfig configInfo) async {
    MethodChannelTmapUiSdk channel = MethodChannelTmapUiSdk();
    final result = await channel.configMarker(configInfo);
    return result;
  }

  /// 다음경유지로의 안내
  Future<bool?> toNextViaPointRequest() async {
    MethodChannelTmapUiSdk channel = MethodChannelTmapUiSdk();
    final result = await channel.toNextViaPointRequest();
    return result;
  }

  /// 최대 볼륨 반환
  Future<int> getMaxVolume() async {
    MethodChannelTmapUiSdk channel = MethodChannelTmapUiSdk();
    final result = await channel.getMaxVolume();
    return result;
  }

  /// 현재 볼륨 반환
  Future<int> getVolume() async {
    MethodChannelTmapUiSdk channel = MethodChannelTmapUiSdk();
    final result = await channel.getVolume();
    return result;
  }

  /// 음성 안내 볼륨 설정
  Future<void> setVolume(int volume) async {
    MethodChannelTmapUiSdk channel = MethodChannelTmapUiSdk();
    await channel.setVolume(volume);
  }

  /// 사운드 체크 실행
  Future<void> runSoundCheck() async {
    MethodChannelTmapUiSdk channel = MethodChannelTmapUiSdk();
    await channel.runSoundCheck();
  }

  StreamSubscription<TmapSDKStatusMsg>? _tmapSDKStatusStreamSubscription;

  Future<void> startTmapSDKStatusStream(
      onTmapSDKStatusAvailable onAvailable) async {
    _tmapSDKStatusStreamSubscription = TmapUiSdkPlatform.instance
        .onStreamedTmapSDKStatus()
        .listen((TmapSDKStatusMsg status) {
      onAvailable(status);
    });
  }

  Future<void> stopTmapSDKStatusStream() async {
    await _tmapSDKStatusStreamSubscription?.cancel();
    _tmapSDKStatusStreamSubscription = null;
  }

  StreamSubscription<MarkerStatus>? _markerStatusStreamSubscription;

  Future<void> startMarkerStatusStream(
      onMarkerStatusAvailable onAvailable) async {
    _markerStatusStreamSubscription = TmapUiSdkPlatform.instance
        .onStreamedMarkerStatus()
        .listen((MarkerStatus status) {
      onAvailable(status);
    });
  }

  Future<void> stopMarkerStatusStream() async {
    await _markerStatusStreamSubscription?.cancel();
    _markerStatusStreamSubscription = null;
  }

  StreamSubscription<TmapDriveGuide>? _tmapDriveGuideStreamSubscription;

  Future<void> startTmapDriveGuideStream(
      onTmapDriveGuideAvailable onAvailable) async {
    _tmapDriveGuideStreamSubscription = TmapUiSdkPlatform.instance
        .onStreamedTmapDriveGuide()
        .listen((TmapDriveGuide guide) {
      onAvailable(guide);
    });
  }

  Future<void> stopTmapDriveGuideStream() async {
    await _tmapDriveGuideStreamSubscription?.cancel();
    _tmapDriveGuideStreamSubscription = null;
  }

  StreamSubscription<TmapDriveStatus>? _tmapDriveStatusStreamSubscription;

  Future<void> startTmapDriveStatusStream(
      onTmapDriveStatusAvailable onAvailable) async {
    _tmapDriveStatusStreamSubscription = TmapUiSdkPlatform.instance
        .onStreamedTmapDriveStatus()
        .listen((TmapDriveStatus status) {
      onAvailable(status);
    });
  }

  Future<void> stopTmapDriveStatusStream() async {
    await _tmapDriveStatusStreamSubscription?.cancel();
    _tmapDriveStatusStreamSubscription = null;
  }
}

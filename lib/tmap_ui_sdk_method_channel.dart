import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:tmap_ui_sdk/config/marker/uisdk_marker_config.dart';
import 'package:tmap_ui_sdk/event/channel/driveStatus/drivestatus_event_channel.dart';
import 'package:tmap_ui_sdk/event/channel/driveguide/driveguide_event_channel.dart';
import 'package:tmap_ui_sdk/event/channel/markerStatus/marker_status_event_channel.dart';
import 'package:tmap_ui_sdk/event/channel/sdkStatus/tmap_sdk_status_event_channel.dart';
import 'package:tmap_ui_sdk/event/data/driveStatus/tmap_drivestatus.dart';
import 'package:tmap_ui_sdk/event/data/driveguide/tmap_driveguide.dart';
import 'package:tmap_ui_sdk/event/data/markerStatus/marker_status.dart';
import 'package:tmap_ui_sdk/event/data/sdkStatus/tmap_sdk_status.dart';

import 'auth/data/auth_data.dart';
import 'auth/data/init_result.dart';
import 'config/sdk_config.dart';
import 'extensions/extensions.dart';
import 'tmap_ui_sdk_platform_interface.dart';

// ignore_for_file: constant_identifier_names
/// An implementation of [TmapUiSdkPlatform] that uses method channels.
class MethodChannelTmapUiSdk extends TmapUiSdkPlatform {
  static const String CHANNEL_TMAPUISDK = 'com.tmapmobility.tmap.tmapsdk.flutter.tmapuisdk';

  static const String METHOD_GET_VERSION = 'getPlatformVersion';

  static const String ARGS_METHOD = "args";
  static const String METHOD_INIT_SDK_INIT = "initSDK";
  static const String METHOD_FINALIZE_SDK = "finalizeSDK";
  static const String METHOD_CONFIG_SDK = "configSDK";
  static const String METHOD_CONFIG_MARKER = "configMarker";
  static const String METHOD_STOP_DRIVING = "stopDriving";
  static const String METHOD_TO_NEXT_VIA_POINT = "toNextViaPointRequest";
  static const String METHOD_CLEAR_CONTINUE_DRIVE_INFO = "clearContinueDriveInfo";
  static const String METHOD_GET_MAX_VOLUME = "getMaxVolume";
  static const String METHOD_GET_VOLUME = "getVolume";
  static const String METHOD_SET_VOLUME = "setVolume";
  static const String METHOD_RUN_SOUND_CHECK = "runSoundCheck";

  StreamSubscription<dynamic>? _tmapSDKStatusStreamSubscription;
  StreamSubscription<dynamic>? _markerStatusStreamSubscription;
  StreamSubscription<dynamic>? _tmapDriveGuideStreamSubscription;
  StreamSubscription<dynamic>? _tmapDriveStatusStreamSubscription;

  StreamController<TmapSDKStatusMsg>? _tmapSDKStatusController;
  StreamController<MarkerStatus>? _markerStatusController;
  StreamController<TmapDriveGuide>? _tmapDriveGuideController;
  StreamController<TmapDriveStatus>? _tmapDriveStatusController;

  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel(CHANNEL_TMAPUISDK);

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>(METHOD_GET_VERSION);
    return version;
  }

  @override
  Future<InitResult?> initSDK(AuthData authInfo) async {
    final initResultString = await methodChannel.invokeMethod<String>(
        METHOD_INIT_SDK_INIT,
        {ARGS_METHOD:authInfo.toJsonString()}
    );
    return InitResult.getByText(initResultString ?? InitResult.notGranted.text);
  }

  @override
  Future<bool?> finalizeSDK() async {
    final finalizeResultString = await methodChannel.invokeMethod<String>(
        METHOD_FINALIZE_SDK
    );
    return finalizeResultString?.toBoolean();
  }

  @override
  Future<bool?> configSDK(SDKConfig configInfo) async {
    final configResult = await methodChannel.invokeMethod<String>(
        METHOD_CONFIG_SDK,
        {ARGS_METHOD:configInfo.toJsonString()}
    );

    return configResult?.toBoolean();
  }

  @override
  Future<bool?> stopDriving() async {
    final configResult = await methodChannel.invokeMethod<String>(
        METHOD_STOP_DRIVING
    );

    return configResult?.toBoolean();
  }

  @override
  Future<bool?> clearContinueDriveInfo() async {
    final configResult = await methodChannel.invokeMethod<String>(
        METHOD_CLEAR_CONTINUE_DRIVE_INFO
    );

    return configResult?.toBoolean();
  }

  @override
  Future<bool?> toNextViaPointRequest() async {
    final configResult = await methodChannel.invokeMethod<String>(
        METHOD_TO_NEXT_VIA_POINT
    );

    return configResult?.toBoolean();
  }

  @override
  Future<bool?> configMarker(UISDKMarkerConfig configInfo) async {
    final configResult = await methodChannel.invokeMethod<String>(
        METHOD_CONFIG_MARKER,
        {ARGS_METHOD:configInfo.toJsonString()}
    );

    return configResult?.toBoolean();
  }

  @override
  Future<int> getMaxVolume() async {
    final volume = await methodChannel.invokeMethod<int>(
      METHOD_GET_MAX_VOLUME
    );
    return volume ?? -1;
  }

  @override
  Future<int> getVolume() async {
    final volume = await methodChannel.invokeMethod<int>(
      METHOD_GET_VOLUME
    );
    return volume ?? -1;
  }

  @override
  Future<void> setVolume(int volume) async {
    await methodChannel.invokeMethod<void>(
      METHOD_SET_VOLUME,
      {ARGS_METHOD: volume}
    );
  }

  @override
  Future<void> runSoundCheck() async {
    await methodChannel.invokeMethod<void>(
      METHOD_RUN_SOUND_CHECK
    );
  }

  @override
  Stream<TmapSDKStatusMsg> onStreamedTmapSDKStatus() {
    _installTmapSDKStatusStreamController(
        onListen: _startTmapSDKStatusEventStream);
    return _tmapSDKStatusController!.stream;
  }

  StreamController<TmapSDKStatusMsg> _installTmapSDKStatusStreamController(
      {Function()? onListen}) {
    _tmapSDKStatusController = StreamController<TmapSDKStatusMsg>(
      onListen: onListen ?? () {},
      onCancel: _onTmapSDKStatusStreamCancel,
    );
    return _tmapSDKStatusController!;
  }

  void _startTmapSDKStatusEventStream() {
    _tmapSDKStatusStreamSubscription =
        TmapSDKStatusEvent.readings.listen((TmapSDKStatusMsg sdkStatus) {
      _tmapSDKStatusController?.add(sdkStatus);
    });
  }

  FutureOr<void> _onTmapSDKStatusStreamCancel() async {
    await _tmapSDKStatusStreamSubscription?.cancel();
    _tmapSDKStatusStreamSubscription = null;
    _tmapSDKStatusController = null;
  }

  @override
  Stream<MarkerStatus> onStreamedMarkerStatus() {
    _installMarkerStreamController(
        onListen: _startUISDKMarkerStatusEventStream);
    return _markerStatusController!.stream;
  }

  StreamController<MarkerStatus> _installMarkerStreamController(
      {Function()? onListen}) {
    _markerStatusController = StreamController<MarkerStatus>(
      onListen: onListen ?? () {},
      onCancel: _onUISDKMarkerStatusStreamCancel,
    );
    return _markerStatusController!;
  }

  void _startUISDKMarkerStatusEventStream() {
    _markerStatusStreamSubscription =
        UISDKMarkerStatusEvent.readings.listen((MarkerStatus selectedMarker) {
      _markerStatusController?.add(selectedMarker);
    });
  }

  FutureOr<void> _onUISDKMarkerStatusStreamCancel() async {
    await _markerStatusStreamSubscription?.cancel();
    _markerStatusStreamSubscription = null;
    _markerStatusController = null;
  }

  @override
  Stream<TmapDriveGuide> onStreamedTmapDriveGuide() {
    _installTmapDriveGuideStreamController(
        onListen: _startTmapDriveGuideEventStream);
    return _tmapDriveGuideController!.stream;
  }

  StreamController<TmapDriveGuide> _installTmapDriveGuideStreamController(
      {Function()? onListen}) {
    _tmapDriveGuideController = StreamController<TmapDriveGuide>(
      onListen: onListen ?? () {},
      onCancel: _onTmapDriveGuideStreamCancel,
    );
    return _tmapDriveGuideController!;
  }

  void _startTmapDriveGuideEventStream() {
    _tmapDriveGuideStreamSubscription =
        TmapDriveGuideEvent.readings.listen((TmapDriveGuide driveGuide) {
          _tmapDriveGuideController?.add(driveGuide);
        });
  }

  FutureOr<void> _onTmapDriveGuideStreamCancel() async {
    await _tmapDriveGuideStreamSubscription?.cancel();
    _tmapDriveGuideStreamSubscription = null;
    _tmapDriveGuideController = null;
  }


  @override
  Stream<TmapDriveStatus> onStreamedTmapDriveStatus() {
    _installTmapDriveStatusStreamController(
        onListen: _startTmapDriveStatusEventStream);
    return _tmapDriveStatusController!.stream;
  }

  StreamController<TmapDriveStatus> _installTmapDriveStatusStreamController(
      {Function()? onListen}) {
    _tmapDriveStatusController = StreamController<TmapDriveStatus>(
      onListen: onListen ?? () {},
      onCancel: _onTmapDriveStatusStreamCancel,
    );
    return _tmapDriveStatusController!;
  }

  void _startTmapDriveStatusEventStream() {
    _tmapDriveStatusStreamSubscription =
        TmapDriveStatusEvent.readings.listen((TmapDriveStatus driveStatus) {
          _tmapDriveStatusController?.add(driveStatus);
        });
  }

  FutureOr<void> _onTmapDriveStatusStreamCancel() async {
    await _tmapDriveStatusStreamSubscription?.cancel();
    _tmapDriveStatusStreamSubscription = null;
    _tmapDriveStatusController = null;
  }
}

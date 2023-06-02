import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:tmap_ui_sdk/config/marker/uisdk_marker_config.dart';
import 'package:tmap_ui_sdk/route/data/route_request_data.dart';

import 'auth/data/auth_data.dart';
import 'auth/data/init_result.dart';
import 'tmap_ui_sdk_platform_interface.dart';
import 'config/sdk_config.dart';
import 'extensions/extensions.dart';

/// An implementation of [TmapUiSdkPlatform] that uses method channels.
class MethodChannelTmapUiSdk extends TmapUiSdkPlatform {
  static const String CHANNEL_TMAPUISDK = 'com.tmapmobility.tmap.tmapsdk.flutter.tmapuisdk';

  static const String METHOD_GET_VERSION = 'getPlatformVersion';

  static const String ARGS_METHOD = "args";
  static const String METHOD_INIT_SDK_INIT = "initSDK";
  static const String METHOD_CONFIG_SDK = "configSDK";
  static const String METHOD_CONFIG_MARKER = "configMarker";
  static const String METHOD_STOP_DRIVING = "stopDriving";

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
  Future<bool?> configMarker(UISDKMarkerConfig configInfo) async {
    final configResult = await methodChannel.invokeMethod<String>(
        METHOD_CONFIG_MARKER,
        {ARGS_METHOD:configInfo.toJsonString()}
    );

    return configResult?.toBoolean();
  }
}

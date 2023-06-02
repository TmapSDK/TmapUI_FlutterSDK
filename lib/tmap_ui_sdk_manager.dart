import 'package:tmap_ui_sdk/config/sdk_config.dart';
import 'package:tmap_ui_sdk/config/marker/uisdk_marker_config.dart';
import 'package:tmap_ui_sdk/route/data/route_request_data.dart';
import 'package:tmap_ui_sdk/tmap_ui_sdk_method_channel.dart';

import 'auth/data/auth_data.dart';
import 'auth/data/init_result.dart';

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

  /// custom marker 설정
  Future<bool?> configMarker(UISDKMarkerConfig configInfo) async {
    MethodChannelTmapUiSdk channel = MethodChannelTmapUiSdk();
    final result = await channel.configMarker(configInfo);
    return result;
  }
}
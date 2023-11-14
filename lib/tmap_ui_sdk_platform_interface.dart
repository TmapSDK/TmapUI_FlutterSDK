import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:tmap_ui_sdk/auth/data/auth_data.dart';
import 'package:tmap_ui_sdk/auth/data/init_result.dart';
import 'package:tmap_ui_sdk/config/marker/uisdk_marker_config.dart';
import 'package:tmap_ui_sdk/config/sdk_config.dart';
import 'package:tmap_ui_sdk/event/data/driveStatus/tmap_drivestatus.dart';
import 'package:tmap_ui_sdk/event/data/driveguide/tmap_driveguide.dart';
import 'package:tmap_ui_sdk/event/data/markerStatus/marker_status.dart';
import 'package:tmap_ui_sdk/event/data/sdkStatus/tmap_sdk_status.dart';

import 'tmap_ui_sdk_method_channel.dart';

abstract class TmapUiSdkPlatform extends PlatformInterface {
  /// Constructs a TmapUiSdkPlatform.
  TmapUiSdkPlatform() : super(token: _token);

  static final Object _token = Object();

  static TmapUiSdkPlatform _instance = MethodChannelTmapUiSdk();

  /// The default instance of [TmapUiSdkPlatform] to use.
  ///
  /// Defaults to [MethodChannelTmapUiSdk].
  static TmapUiSdkPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [TmapUiSdkPlatform] when
  /// they register themselves.
  static set instance(TmapUiSdkPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<InitResult?> initSDK(AuthData authInfo) {
    throw UnimplementedError('initSDK() has not been implemented.');
  }

  Future<bool?> configSDK(SDKConfig configInfo) {
    throw UnimplementedError('configSDK() has not been implemented.');
  }

  Future<bool?> stopDriving() {
    throw UnimplementedError('stopDriving() has not been implemented.');
  }

  Future<bool?> toNextViaPointRequest() {
    throw UnimplementedError('stopDriving() has not been implemented.');
  }

  Future<bool?> configMarker(UISDKMarkerConfig configInfo) {
    throw UnimplementedError('configMarker() has not been implemented.');
  }

  Stream<TmapSDKStatus> onStreamedTmapSDKStatus() {
    throw UnimplementedError('onStreamedTmapSDKStatus() is not implemented.');
  }

  Stream<MarkerStatus> onStreamedMarkerStatus() {
    throw UnimplementedError('onStreamedMarkerStatus() is not implemented.');
  }

  Stream<TmapDriveGuide> onStreamedTmapDriveGuide() {
    throw UnimplementedError('onStreamedTmapDriveGuide() is not implemented.');
  }

  Stream<TmapDriveStatus> onStreamedTmapDriveStatus() {
    throw UnimplementedError('onStreamedTmapDriveStatus() is not implemented.');
  }
}

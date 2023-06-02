import 'package:plugin_platform_interface/plugin_platform_interface.dart';

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
}

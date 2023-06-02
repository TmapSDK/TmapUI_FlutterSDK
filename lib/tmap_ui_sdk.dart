
import 'tmap_ui_sdk_platform_interface.dart';

class TmapUiSdk {
  Future<String?> getPlatformVersion() {
    return TmapUiSdkPlatform.instance.getPlatformVersion();
  }
}

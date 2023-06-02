package android.src.main.kotlin.com.tmapmobility.tmap.tmapsdk.flutter.tmap_ui_sdk

import android.content.Context
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class TmapUiSdkFactory: PlatformViewFactory(StandardMessageCodec.INSTANCE) {
  override fun create(context: Context, id: Int, args: Any?): PlatformView {
    val creationParams = args as Map<*, *>?

    return TmapUiSdkView(context, creationParams)
  }
}

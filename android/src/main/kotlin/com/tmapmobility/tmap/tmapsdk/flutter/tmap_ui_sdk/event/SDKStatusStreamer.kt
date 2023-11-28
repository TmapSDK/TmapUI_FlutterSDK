package android.src.main.kotlin.com.tmapmobility.tmap.tmapsdk.flutter.tmap_ui_sdk.event

import com.google.gson.Gson
import android.src.main.kotlin.com.tmapmobility.tmap.tmapsdk.flutter.tmap_ui_sdk.model.TmapSDKStatusMsgModel
import io.flutter.plugin.common.EventChannel

class SDKStatusStreamer: EventChannel.StreamHandler {
    companion object {
        private var eventSink: EventChannel.EventSink? = null

        fun success(data: TmapSDKStatusMsgModel) {
            val gson = Gson()
            eventSink?.success(gson.toJson(data))
        }
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        eventSink = events
    }
    override fun onCancel(arguments: Any?) {
        eventSink = null
    }
}

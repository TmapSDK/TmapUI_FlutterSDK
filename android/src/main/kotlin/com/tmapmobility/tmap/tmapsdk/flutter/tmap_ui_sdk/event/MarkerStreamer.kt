package android.src.main.kotlin.com.tmapmobility.tmap.tmapsdk.flutter.tmap_ui_sdk.event

import com.google.gson.Gson
import android.src.main.kotlin.com.tmapmobility.tmap.tmapsdk.flutter.tmap_ui_sdk.model.MarkerStatusModel
import io.flutter.plugin.common.EventChannel

class MarkerStreamer: EventChannel.StreamHandler {
    companion object {
        private var eventSink: EventChannel.EventSink? = null

        fun success(status: MarkerStatusModel) {
            val gson = Gson()
            eventSink?.success(gson.toJson(status))
        }
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        eventSink = events
    }
    override fun onCancel(arguments: Any?) {
        eventSink = null
    }
}

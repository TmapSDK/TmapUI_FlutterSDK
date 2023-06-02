package android.src.main.kotlin.com.tmapmobility.tmap.tmapsdk.flutter.tmap_ui_sdk.event

import com.google.gson.Gson
import android.src.main.kotlin.com.tmapmobility.tmap.tmapsdk.flutter.tmap_ui_sdk.model.drive_guide.TmapDriveGuideModel
import io.flutter.plugin.common.EventChannel

class DriveGuideStreamer: EventChannel.StreamHandler {
    companion object {
        private var eventSink: EventChannel.EventSink? = null

        fun success(data: TmapDriveGuideModel) {
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

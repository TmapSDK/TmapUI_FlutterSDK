package android.src.main.kotlin.com.tmapmobility.tmap.tmapsdk.flutter.tmap_ui_sdk.event

import android.src.main.kotlin.com.tmapmobility.tmap.tmapsdk.flutter.tmap_ui_sdk.model.TmapDriveStatusModel
import io.flutter.plugin.common.EventChannel

class DriveStatusStreamer: EventChannel.StreamHandler {
    companion object {
        private var eventSink: EventChannel.EventSink? = null

        fun success(status: TmapDriveStatusModel) {
            eventSink?.success(status.text)
        }
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        eventSink = events
    }
    override fun onCancel(arguments: Any?) {
        eventSink = null
    }
}

package android.src.main.kotlin.com.tmapmobility.tmap.tmapsdk.flutter.tmap_ui_sdk.model

enum class TmapSDKStatusModel(val text: String) {
    NONE("none"),
    MAP_INITIALIZING("mapInitializing"),
    REQUESTING_AUTH("requestingAuth"),
    VSM_ERROR("vsmError"),
    AUTH_ERROR("authError"),
    COMPLETED("completed"),
    READY("ready"),
    DISMISS_REQ("dismissReq"),
    DISMISS_N_REQUEST_PERMISSION("dismissNRequestPermission"),
    REQUEST_PERMISSION("requestPermission"),
    FINISHED("finished"),
}

package android.src.main.kotlin.com.tmapmobility.tmap.tmapsdk.flutter.tmap_ui_sdk.model

import com.google.gson.annotations.SerializedName
enum class TmapSDKStatus(val text: String) {
    @SerializedName("none")
    NONE("none"),

    @SerializedName("mapInitializing")
    MAP_INITIALIZING("mapInitializing"),

    @SerializedName("requestingAuth")
    REQUESTING_AUTH("requestingAuth"),

    @SerializedName("vsmError")
    VSM_ERROR("vsmError"),

    @SerializedName("authError")
    AUTH_ERROR("authError"),

    @SerializedName("completed")
    COMPLETED("completed"),

    @SerializedName("ready")
    READY("ready"),

    @SerializedName("dismissReq")
    DISMISS_REQ("dismissReq"),

    @SerializedName("dismissNRequestPermission")
    DISMISS_N_REQUEST_PERMISSION("dismissNRequestPermission"),

    @SerializedName("requestPermission")
    REQUEST_PERMISSION("requestPermission"),

    @SerializedName("finished")
    FINISHED("finished"),

    @SerializedName("savedDriveInfo")
    SAVED_DRIVE_INFO("savedDriveInfo"),

    @SerializedName("continueDriveRequestedButNoSavedDriveInfo")
    CONTINUE_DRIVE_REQUESTED_NO_SAVED_DRIVE_INFO("continueDriveRequestedButNoSavedDriveInfo"),
}

data class TmapSDKStatusMsgModel(
    @SerializedName("sdk_status") var sdkStatus: TmapSDKStatus = TmapSDKStatus.NONE,
    @SerializedName("status_extra_data") var extraData: String = "",
)

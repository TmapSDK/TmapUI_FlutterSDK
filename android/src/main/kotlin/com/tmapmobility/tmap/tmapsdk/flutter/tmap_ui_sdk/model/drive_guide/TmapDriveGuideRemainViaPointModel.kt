package android.src.main.kotlin.com.tmapmobility.tmap.tmapsdk.flutter.tmap_ui_sdk.model.drive_guide

import com.google.gson.annotations.SerializedName

data class TmapDriveGuideRemainViaPointModel(
    @SerializedName("via_index") var viaIndex: Int = 0,
    @SerializedName("via_distance") var viaDistance: Int = -1,
    @SerializedName("via_time") var viaTime: Int = -1,
)

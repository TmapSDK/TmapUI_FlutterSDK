package android.src.main.kotlin.com.tmapmobility.tmap.tmapsdk.flutter.tmap_ui_sdk.model

import com.google.gson.annotations.SerializedName

data class MarkerStatusModel(
    @SerializedName("selected_marker_id") var markerId: String = "",
    @SerializedName("selected_marker_type") var markerType: SelectedMarkerType = SelectedMarkerType.POINT,
)

enum class SelectedMarkerType {
    @SerializedName("point")
    POINT,

    @SerializedName("callout")
    CALL_OUT,
}

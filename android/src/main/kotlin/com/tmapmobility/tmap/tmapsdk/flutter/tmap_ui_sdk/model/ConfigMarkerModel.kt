package android.src.main.kotlin.com.tmapmobility.tmap.tmapsdk.flutter.tmap_ui_sdk.model

import com.google.gson.Gson
import com.google.gson.annotations.SerializedName

data class ConfigMarkerModel(
    @SerializedName("marker_info") var markers: ArrayList<UISDKMarker>? = null,
) {
    companion object {
        var model: ConfigMarkerModel? = null
        fun create(jsonString: String) {
            val gson = Gson()
            model = gson.fromJson(jsonString, ConfigMarkerModel::class.java)
        }
    }
}

data class UISDKMarker(
    @SerializedName("marker_point") var markerPoint: ArrayList<UISDKMarkerPoint>? = null,
    @SerializedName("marker_id") var markerId: String? = null,
    @SerializedName("image_name") var imageName: String? = null,
    @SerializedName("marker_type") var markerType: MarkerType = MarkerType.POINT,
)

data class UISDKMarkerPoint(
    @SerializedName("latitude") var latitude: Double = 0.0,
    @SerializedName("longitude") var longitude: Double = 0.0,
)

enum class MarkerType {
    @SerializedName("point")
    POINT,
    @SerializedName("line")
    LINE,
}

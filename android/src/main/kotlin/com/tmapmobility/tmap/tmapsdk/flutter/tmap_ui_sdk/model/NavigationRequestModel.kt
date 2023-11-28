package android.src.main.kotlin.com.tmapmobility.tmap.tmapsdk.flutter.tmap_ui_sdk.model

import com.google.gson.Gson
import com.google.gson.annotations.SerializedName
import com.skt.tmap.engine.navigation.route.RoutePlanType
import com.skt.tmap.engine.navigation.route.data.MapPoint
import com.skt.tmap.engine.navigation.route.data.WayPoint
import com.tmapmobility.tmap.tmapsdk.ui.util.TmapUISDK

data class NavigationRequestModel(
    var departure: WayPoint?,
    var wayPoints: ArrayList<WayPoint>?,
    var destination: WayPoint,
    var withoutPreview: Boolean,
    var routeRequestListener: TmapUISDK.RouteRequestListener?,
    var safeDriving: Boolean,
    var continueDriving: Boolean,
    var routePlans: ArrayList<RoutePlanType>?,
)

data class RouteRequestData(
    @SerializedName("source") var source: RoutePoint? = null,
    @SerializedName("destination") var destination: RoutePoint? = null,
    @SerializedName("route_options") var routeOptions: ArrayList<String>? = null,
    @SerializedName("way_points") var wayPoints: ArrayList<RoutePoint>? = null,
    @SerializedName("guide_without_preview") var guideWithoutPreview: Boolean = false,
    @SerializedName("safe_driving") var safeDriving: Boolean = false,
    @SerializedName("continue_driving") var continueDriving: Boolean = false
) {
    companion object {
        fun create(jsonString: String): NavigationRequestModel {
            val gson = Gson()
            val data = gson.fromJson(jsonString, RouteRequestData::class.java)

            val departure = if (data.source == null) null else WayPoint(
                data.source?.name ?: "",
                MapPoint(
                    data.source?.longitude ?: 0.0,
                    data.source?.latitude ?: 0.0,
                )
            )
            val wayPoints: ArrayList<WayPoint>? =
                if (data.wayPoints == null) null else data.wayPoints?.map {
                    WayPoint(
                        it.name ?: "",
                        MapPoint(
                            it.longitude ?: 0.0,
                            it.latitude ?: 0.0,
                        )
                    )
                }?.let { ArrayList(it) }
            val destination = WayPoint(
                data.destination?.name ?: "",
                MapPoint(
                    data.destination?.longitude ?: 0.0,
                    data.destination?.latitude ?: 0.0,
                )
            )
            val withoutPreview = data.guideWithoutPreview
            val routeRequestListener: TmapUISDK.RouteRequestListener? = null
            val routePlans: ArrayList<RoutePlanType>? =
                if (data.routeOptions == null) null else data.routeOptions?.map{
                    RoutePlanType.valueOf(it)
                }?.let { ArrayList(it) }

            return NavigationRequestModel(
                departure,
                wayPoints,
                destination,
                withoutPreview,
                routeRequestListener,
                data.safeDriving,
                data.continueDriving,
                routePlans,
            )
        }
    }
}

data class RoutePoint(
    @SerializedName("longitude") var longitude: Double? = null,
    @SerializedName("latitude") var latitude: Double? = null,
    @SerializedName("name") var name: String? = null
)

package android.src.main.kotlin.com.tmapmobility.tmap.tmapsdk.flutter.tmap_ui_sdk.model.drive_guide

import android.os.Build
import android.os.Bundle
import com.google.gson.annotations.SerializedName
import java.io.Serializable

enum class GpsStatus(val value: Int) {
    @SerializedName("noSignal")
    NoSignal(0),
    @SerializedName("bad")
    Bad(1),
    @SerializedName("good")
    Good(2),
    @SerializedName("tunnel")
    Tunnel(3),
    @SerializedName("underpass")
    Underpass(4);

    companion object {
        infix fun from(value: Int): GpsStatus =
            GpsStatus.values().firstOrNull { it.value == value } ?: NoSignal
    }
}

data class TmapDriveGuideModel(
    @SerializedName("speed_in_kmh") var speedInKmPerHour: Int = 0,
    @SerializedName("is_shade_area") var isShadeArea: Boolean = false,
    @SerializedName("no_location_signal") var noLocationSignal: Boolean = false,
    @SerializedName("gps_state") var gpsState: GpsStatus = GpsStatus.NoSignal,
    @SerializedName("is_night_mode") var isNightMode: Boolean = false,
    @SerializedName("current_road_name") var currentRoadName: String = "",
    @SerializedName("lane_info") var laneInfo: TmapDriveGuideLaneModel? = null,
    @SerializedName("show_sdi") var showSDI: Boolean = false,
    @SerializedName("is_caution") var isCaution: Boolean = false,
    @SerializedName("average_speed") var averageSpeed: Int = 0,
    @SerializedName("limit_speed") var limitSpeed: Int = 0,
    @SerializedName("first_sdi_info") var firstSDIInfo: TmapDriveGuideSDIModel? = null,
    @SerializedName("has_tbt_info") var hasTbtInfo: Boolean = false,
    @SerializedName("first_tbt_info") var firstTBTInfo: TmapDriveGuideTBTModel? = null,
    @SerializedName("remain_distance_to_destination_in_meter") var remainDistanceToDestinationInMeter: Int = 0,
    @SerializedName("remain_time_to_destination_in_sec") var remainTimeToDestinationInSec: Int = 0,
    @SerializedName("remain_distance_to_go_position_in_meter") var remainDistanceToGoPositionInMeter: Int = 0,
    @SerializedName("remain_time_to_go_position_in_sec") var remainTimeToGoPositionInSec: Int = 0,
    @SerializedName("remain_via_point") var remainViaPoint: ArrayList<TmapDriveGuideRemainViaPointModel>? = null,
    @SerializedName("matched_latitude") var matchedLatitude: Double? = null,
    @SerializedName("matched_longitude") var matchedLongitude: Double? = null,
) {
    companion object {
        fun create(bundle: Bundle): TmapDriveGuideModel {
            val firstSDIInfo = bundle.serializable<HashMap<String, Any>>("firstSDIInfo")
            val firstTBTInfo = bundle.serializable<HashMap<String, Any>>("firstTBTInfo")
            val remainViaPointSize = bundle.getInt("remainViaPointSize")
            val remainViaPointMap = bundle.serializable<HashMap<String, Any>>("remainViaPoint")
            val remainViaPoint = ArrayList<TmapDriveGuideRemainViaPointModel>()
            var matchedLatitude = bundle.getDouble("matchedLatitude")
            var matchedLongitude = bundle.getDouble("matchedLongitude")
            remainViaPointMap?.let {
                for(i in 0..remainViaPointSize) {
                    val map = it[i.toString()] as HashMap<*, *>
                    remainViaPoint.add(
                        TmapDriveGuideRemainViaPointModel(
                            map["viaIdx"] as? Int ?: 0,
                            map["remainDist"] as? Int ?: 0,
                            map["remainTime"] as? Int ?: 0,
                        )
                    )
                }
            }

            return TmapDriveGuideModel(
                bundle.getInt("speedInKmPerHour"),
                bundle.getBoolean("isShadeArea"),
                bundle.getBoolean("noLocationSignal"),
                GpsStatus.from( bundle.getInt("gpsState") ),
                bundle.getBoolean("isNightMode"),
                bundle.getString("currentRoadName", ""),
                TmapDriveGuideLaneModel(
                    bundle.getBoolean("showLane"),
                    bundle.getInt("laneCount"),
                    bundle.getInt("laneDistance"),
                    TmapDriveGuideLaneModel.getNLaneTurnInfo(bundle.getIntArray("laneTurnInfo")),
                    TmapDriveGuideLaneModel.getNLaneEtcInfo(bundle.getIntArray("laneEtcInfo")),
                    TmapDriveGuideLaneModel.getAvailableTurn(bundle.getIntArray("laneAvailableInfo")),
                ),
                bundle.getBoolean("showSDI"),
                bundle.getBoolean("isCaution"),
                bundle.getInt("averageSpeed"),
                bundle.getInt("limitSpeed"),
                TmapDriveGuideSDIModel(
                    SDIType.from(firstSDIInfo?.get("nSdiType") as? Int ?: -1),
                    firstSDIInfo?.get("nSdiDist") as? Int ?: 0,
                    firstSDIInfo?.get("nSdiSpeedLimit") as? Int ?: 0,
                    firstSDIInfo?.get("bSdiBlockSection") as? Boolean ?: false,
                    firstSDIInfo?.get("nSdiBlockDist") as? Int ?: 0,
                    firstSDIInfo?.get("nSdiBlockSpeed") as? Int ?: 0,
                    firstSDIInfo?.get("nSdiBlockAverageSpeed") as? Int ?: 0,
                    firstSDIInfo?.get("nSdiBlockTime") as? Int ?: 0,
                    firstSDIInfo?.get("bIsChangeableSpeedType") as? Boolean ?: false,
                    firstSDIInfo?.get("bIsLimitSpeedSignChanged") as? Boolean ?: false,
                    firstSDIInfo?.get("nTruckLimit") as? String ?: "",
                ),
                bundle.getBoolean("hasTbtInfo"),
                TmapDriveGuideTBTModel(
                    firstTBTInfo?.get("nTBTDist") as? Int ?: 0,
                    firstTBTInfo?.get("nTBTTime") as? Int ?: 0,
                    TBTTurnType.from(firstTBTInfo?.get("nTBTTurnType") as? Int ?: 0),
                    firstTBTInfo?.get("nTollFee") as? Int ?: 0,
                    firstTBTInfo?.get("szRoadName") as? String ?: "",
                    firstTBTInfo?.get("szCrossName") as? String ?: "",
                    firstTBTInfo?.get("szNearDirName") as? String ?: "",
                    firstTBTInfo?.get("szMidDirName") as? String ?: "",
                    firstTBTInfo?.get("szFarDirName") as? String ?: "",
                    firstTBTInfo?.get("szTBTMainText") as? String ?: "",
                    ComplexIntersectionVoiceType.from(firstTBTInfo?.get("nExtcVoiceCode") as? Int ?: 0),
                ),
                bundle.getInt("remainDistanceToDestinationInMeter"),
                bundle.getInt("remainTimeToDestinationInSec"),
                0,
                0,
                remainViaPoint,
                matchedLatitude,
                matchedLongitude
            )
        }
    }
}

inline fun <reified T : Serializable> Bundle.serializable(key: String): T? = when {
    Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU -> getSerializable(key, T::class.java)
    else -> @Suppress("DEPRECATION") getSerializable(key) as? T
}

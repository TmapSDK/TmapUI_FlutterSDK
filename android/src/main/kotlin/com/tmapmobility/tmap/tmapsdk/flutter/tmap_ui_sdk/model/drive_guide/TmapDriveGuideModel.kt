package android.src.main.kotlin.com.tmapmobility.tmap.tmapsdk.flutter.tmap_ui_sdk.model.drive_guide

import android.os.Build
import android.os.Bundle
import com.google.gson.annotations.SerializedName
import com.skt.tmap.engine.navigation.route.RoutePlanType
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
    @SerializedName("second_sdi_info") var secondSDIInfo: TmapDriveGuideSDIModel? = null,
    @SerializedName("has_tbt_info") var hasTbtInfo: Boolean = false,
    @SerializedName("first_tbt_info") var firstTBTInfo: TmapDriveGuideTBTModel? = null,
    @SerializedName("second_tbt_info") var secondTBTInfo: TmapDriveGuideTBTModel? = null,
    @SerializedName("remain_distance_to_destination_in_meter") var remainDistanceToDestinationInMeter: Int = 0,
    @SerializedName("remain_time_to_destination_in_sec") var remainTimeToDestinationInSec: Int = 0,
    @SerializedName("remain_via_point_size") var remainViaPointSize: Int = 0,
    @SerializedName("remain_distance_to_go_position_in_meter") var remainDistanceToGoPositionInMeter: Int = 0,
    @SerializedName("remain_time_to_go_position_in_sec") var remainTimeToGoPositionInSec: Int = 0,
    @SerializedName("remain_via_point") var remainViaPoint: ArrayList<TmapDriveGuideRemainViaPointModel>? = null,
    @SerializedName("matched_latitude") var matchedLatitude: Double? = null,
    @SerializedName("matched_longitude") var matchedLongitude: Double? = null,
    @SerializedName("destination_latitude") var destinationLatitude: Double? = null,
    @SerializedName("destination_longitude") var destinationLongitude: Double? = null,
    @SerializedName("drive_option") var planningOption: RoutePlanType? = null,
) {
    companion object {
        fun create(bundle: Bundle): TmapDriveGuideModel {
            val firstSDIInfo = bundle.serializable<HashMap<String, Any>>("firstSDIInfo")
            val secondSDIInfo = bundle.serializable<HashMap<String, Any>>("secondSDIInfo")
            val firstTBTInfo = bundle.serializable<HashMap<String, Any>>("firstTBTInfo")
            val secondTBTInfo = bundle.serializable<HashMap<String, Any>>("secondTBTInfo")
            val remainViaPointSize = bundle.getInt("remainViaPointSize")
            val remainViaPointMap = bundle.serializable<HashMap<String, Any>>("remainViaPoint")
            val remainViaPoint = ArrayList<TmapDriveGuideRemainViaPointModel>()
            var matchedLatitude = bundle.getDouble("matchedLatitude")
            var matchedLongitude = bundle.getDouble("matchedLongitude")
            val destinationLatitude = bundle.getDouble("destinationLatitude")
            val destinationLongitude = bundle.getDouble("destinationLongitude")
            val planningOptionInt = bundle.getInt("currentRoutePlan")
            val planningOption = RoutePlanType.getRoutePlanType(planningOptionInt)
            remainViaPointMap?.let { remainViaPointMap ->
                for(i in 0 until remainViaPointSize) {
                    remainViaPointMap.getOrDefault(i.toString(),null)?.let {
                        val map = it as HashMap<*, *>
                        remainViaPoint.add(
                            TmapDriveGuideRemainViaPointModel(
                                map["viaIdx"] as? Int ?: 0,
                                map["viaName"] as? String ?: "",
                                map["remainDist"] as? Int ?: 0,
                                map["remainTime"] as? Int ?: 0,
                                map["latitude"] as? Double ?: 0.0,
                                map["longitude"] as? Double ?: 0.0,
                            )
                        )
                    }
                }
            }

            val firstSDIInfoModel = if (firstSDIInfo == null) null
            else TmapDriveGuideSDIModel(
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
            )

            val secondSDIInfoModel = if (secondSDIInfo == null) null
            else TmapDriveGuideSDIModel(
                SDIType.from(secondSDIInfo?.get("nSdiType") as? Int ?: -1),
                secondSDIInfo?.get("nSdiDist") as? Int ?: 0,
                secondSDIInfo?.get("nSdiSpeedLimit") as? Int ?: 0,
                secondSDIInfo?.get("bSdiBlockSection") as? Boolean ?: false,
                secondSDIInfo?.get("nSdiBlockDist") as? Int ?: 0,
                secondSDIInfo?.get("nSdiBlockSpeed") as? Int ?: 0,
                secondSDIInfo?.get("nSdiBlockAverageSpeed") as? Int ?: 0,
                secondSDIInfo?.get("nSdiBlockTime") as? Int ?: 0,
                secondSDIInfo?.get("bIsChangeableSpeedType") as? Boolean ?: false,
                secondSDIInfo?.get("bIsLimitSpeedSignChanged") as? Boolean ?: false,
                secondSDIInfo?.get("nTruckLimit") as? String ?: "",
            )

            val firstTBTInfoModel = if (firstTBTInfo == null) null
            else TmapDriveGuideTBTModel(
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
            )

            val secondTBTInfoModel = if (secondTBTInfo == null) null
            else TmapDriveGuideTBTModel(
                secondTBTInfo?.get("nTBTDist") as? Int ?: 0,
                secondTBTInfo?.get("nTBTTime") as? Int ?: 0,
                TBTTurnType.from(secondTBTInfo?.get("nTBTTurnType") as? Int ?: 0),
                secondTBTInfo?.get("nTollFee") as? Int ?: 0,
                secondTBTInfo?.get("szRoadName") as? String ?: "",
                secondTBTInfo?.get("szCrossName") as? String ?: "",
                secondTBTInfo?.get("szNearDirName") as? String ?: "",
                secondTBTInfo?.get("szMidDirName") as? String ?: "",
                secondTBTInfo?.get("szFarDirName") as? String ?: "",
                secondTBTInfo?.get("szTBTMainText") as? String ?: "",
                ComplexIntersectionVoiceType.from(secondTBTInfo?.get("nExtcVoiceCode") as? Int ?: 0),
            )

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
                firstSDIInfoModel,
                secondSDIInfoModel,
                bundle.getBoolean("hasTbtInfo"),
                firstTBTInfoModel,
                secondTBTInfoModel,
                bundle.getInt("remainDistanceToDestinationInMeter"),
                bundle.getInt("remainTimeToDestinationInSec"),
                bundle.getInt("remainViaPointSize"),
                bundle.getInt("remainDistanceToGoPositionInMeter"),
                bundle.getInt("remainTimeToGoPositionInSec"),
                remainViaPoint,
                matchedLatitude,
                matchedLongitude,
                destinationLatitude,
                destinationLongitude,
                planningOption
            )
        }
    }
}

inline fun <reified T : Serializable> Bundle.serializable(key: String): T? = when {
    Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU -> getSerializable(key, T::class.java)
    else -> @Suppress("DEPRECATION") getSerializable(key) as? T
}

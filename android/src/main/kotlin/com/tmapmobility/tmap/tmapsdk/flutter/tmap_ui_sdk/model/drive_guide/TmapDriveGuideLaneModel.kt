package android.src.main.kotlin.com.tmapmobility.tmap.tmapsdk.flutter.tmap_ui_sdk.model.drive_guide

import com.google.gson.annotations.SerializedName

/// 회전정보 - 1:유턴, 2:좌회전, 4:좌측, 8:직진, 16:우측, 32:우회전
enum class LaneTurnType(val value: Int) {
    @SerializedName("uTurn")
    UTurn(1),
    @SerializedName("left")
    Left(2),
    @SerializedName("leftside")
    LeftSide(4),
    @SerializedName("strait")
    Strait(8),
    @SerializedName("rightside")
    RightSide(16),
    @SerializedName("right")
    Right(32);

    companion object {
        infix fun from(value: Int): LaneTurnType =
            LaneTurnType.values().firstOrNull { it.value == value } ?: LaneTurnType.UTurn
    }
}

/// 기타정보 - 1:좌포켓, 2:우포켓, 4:고가, 8:지하, 16:로타리, 32:P턴, 64:버스, 0x80: 권장 차선
enum class LaneEtcType(val value: Int) {
    @SerializedName("leftPocket")
    LeftPocket(0x01),
    @SerializedName("rightPocket")
    RightPocket(0x02),
    @SerializedName("sky")
    Sky(0x04),
    @SerializedName("underpass")
    Underpass(0x08),
    @SerializedName("rotary")
    Rotary(0x10),
    @SerializedName("pTurn")
    PTurn(0x20),
    @SerializedName("bus")
    Bus(0x40),
    @SerializedName("suggestedLane")
    SuggestedLane(0x80);

    companion object {
        infix fun from(value: Int): LaneEtcType =
            LaneEtcType.values().firstOrNull { it.value == value } ?: LaneEtcType.LeftPocket
    }
}

data class TmapDriveGuideLaneModel(
    @SerializedName("show_lane") var showLane: Boolean = false,
    @SerializedName("lane_count") var laneCount: Int = 0,
    @SerializedName("lane_distance") var laneDistance: Int = 0,
    @SerializedName("lane_turn_info") var nLaneTurnInfo: ArrayList<ArrayList<LaneTurnType>>? = null,
    @SerializedName("lane_etc_info") var nLaneEtcInfo: ArrayList<ArrayList<LaneEtcType>>? = null,
    @SerializedName("available_turn") var availableTurn: LaneTurnType = LaneTurnType.Strait,
    @SerializedName("hipass_lane_info") var hipassLaneInfo: ArrayList<Int>? = null,
) {
    companion object {
        fun getNLaneTurnInfo(intArray: IntArray?): ArrayList<ArrayList<LaneTurnType>>? {
            if (intArray == null) return null
            val result = ArrayList<ArrayList<LaneTurnType>>()
            val turnTypeArray = ArrayList<LaneTurnType>()
            for (i in intArray) {
                turnTypeArray.add(LaneTurnType.from(i))
            }
            result.add(turnTypeArray)
            return result
        }

        fun getNLaneEtcInfo(intArray: IntArray?): ArrayList<ArrayList<LaneEtcType>>? {
            if (intArray == null) return null
            val result = ArrayList<ArrayList<LaneEtcType>>()
            val etcTypeArray = ArrayList<LaneEtcType>()
            for (i in intArray) {
                etcTypeArray.add(LaneEtcType.from(i))
            }
            result.add(etcTypeArray)
            return result
        }

        fun getAvailableTurn(intArray: IntArray?): LaneTurnType {
            if (intArray == null) return LaneTurnType.Strait
            return LaneTurnType.from(intArray.first())
        }

        fun getHipassLaneInfo(intArray: IntArray?): ArrayList<Int>? {
            if (intArray == null) return null
            return intArray.toCollection(ArrayList())
        }
    }
}

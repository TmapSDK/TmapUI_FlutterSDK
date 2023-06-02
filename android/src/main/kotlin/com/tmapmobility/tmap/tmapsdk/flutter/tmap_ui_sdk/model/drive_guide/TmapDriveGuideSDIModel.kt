package android.src.main.kotlin.com.tmapmobility.tmap.tmapsdk.flutter.tmap_ui_sdk.model.drive_guide

import com.google.gson.annotations.SerializedName

enum class SDIType(val value: Int){
    @SerializedName("speedAccidentPos")
    speedAccidentPos(0),
    @SerializedName("speedLimitPos")
    speedLimitPos(1),
    @SerializedName("speedBlockStartPos")
    speedBlockStartPos(2),
    @SerializedName("speedBlockEndPos")
    speedBlockEndPos(3),
    @SerializedName("speedBlockMidPos")
    speedBlockMidPos(4),
    @SerializedName("tail")
    tail(5),
    @SerializedName("signalAccidentPos")
    signalAccidentPos(6),
    @SerializedName("speedLimitDangerousArea")
    speedLimitDangerousArea(7),
    @SerializedName("boxSpeedLimitPos")
    boxSpeedLimitPos(8),
    @SerializedName("busLane")
    busLane(9),
    @SerializedName("changeroadPos")
    changeroadPos(10),
    @SerializedName("roadControlPos")
    roadControlPos(11),
    @SerializedName("intruderArea")
    intruderArea(12),
    @SerializedName("trafficinfoCollectPos")
    trafficinfoCollectPos(13),
    @SerializedName("cctvArea")
    cctvArea(14),
    @SerializedName("overloadDangerousArea")
    overloadDangerousArea(15),
    @SerializedName("loadBadControlPos")
    loadBadControlPos(16),
    @SerializedName("parkingControlPos")
    parkingControlPos(17),
    @SerializedName("oneWayArea")
    oneWayArea(18),
    @SerializedName("railwayCrossing")
    railwayCrossing(19),
    @SerializedName("schoolZoneStart")
    schoolZoneStart(20),
    @SerializedName("schoolZoneEnd")
    schoolZoneEnd(21),
    @SerializedName("speedbump")
    speedbump(22),
    @SerializedName("lpgStation")
    lpgStation(23),
    @SerializedName("tunnelArea")
    tunnelArea(24),
    @SerializedName("serviceArea")
    serviceArea(25),
    @SerializedName("tollgate")
    tollgate(26),
    @SerializedName("fogArea")
    fogArea(27),
    @SerializedName("hazardousArea")
    hazardousArea(28),
    @SerializedName("accidentArea")
    accidentArea(29),
    @SerializedName("sharpCurveArea")
    sharpCurveArea(30),
    @SerializedName("newCurveArea")
    newCurveArea(31),
    @SerializedName("slopeArea")
    slopeArea(32),
    @SerializedName("roadKillArea")
    roadKillArea(33),
    @SerializedName("visualRightArea")
    visualRightArea(34),
    @SerializedName("visualFrontArea")
    visualFrontArea(35),
    @SerializedName("visualLeftArea")
    visualLeftArea(36),
    @SerializedName("signalViolationArea")
    signalViolationArea(37),
    @SerializedName("speedDrivingArea")
    speedDrivingArea(38),
    @SerializedName("trafficCongestArea")
    trafficCongestArea(39),
    @SerializedName("directionLane")
    directionLane(40),
    @SerializedName("walkCrossArea")
    walkCrossArea(41),
    @SerializedName("roadAccidentArea")
    roadAccidentArea(42),
    @SerializedName("speedAccidentArea")
    speedAccidentArea(43),
    @SerializedName("sleepAccidentArea")
    sleepAccidentArea(44),
    @SerializedName("accidentPos")
    accidentPos(45),
    @SerializedName("pedestrianAccidentPos")
    pedestrianAccidentPos(46),
    @SerializedName("vehicleBurglaryPos")
    vehicleBurglaryPos(47),
    @SerializedName("fallingArea")
    fallingArea(48),
    @SerializedName("freezingArea")
    freezingArea(49),
    @SerializedName("bottleneckPoint")
    bottleneckPoint(50),
    @SerializedName("mergePoint")
    mergePoint(51),
    @SerializedName("crashArea")
    crashArea(52),
    @SerializedName("undergroundArea")
    undergroundArea(53),
    @SerializedName("trafficCalmingArea")
    trafficCalmingArea(54),
    @SerializedName("interchange")
    interchange(55),
    @SerializedName("junction")
    junction(56),
    @SerializedName("serviceAreaLpg")
    serviceAreaLpg(57),
    @SerializedName("bridge")
    bridge(58),
    @SerializedName("hwa03")
    hwa03(59),
    @SerializedName("hwa06")
    hwa06(60),
    @SerializedName("hwa09")
    hwa09(61),
    @SerializedName("goalOpposite")
    goalOpposite(62),
    @SerializedName("restPlace")
    restPlace(63),
    @SerializedName("sdiExhaustGasGrade")
    sdiExhaustGasGrade(64),
    @SerializedName("sdiTunnelChangeLanePos")
    sdiTunnelChangeLanePos(65),
    @SerializedName("unknown")
    unknown(66);

    companion object {
        infix fun from(value: Int): SDIType =
            SDIType.values().firstOrNull { it.value == value } ?: SDIType.unknown
    }
}

data class TmapDriveGuideSDIModel(
    @SerializedName("sdi_type") var sdiType: SDIType = SDIType.unknown,
    @SerializedName("sdi_distance") var sdiDistance: Int = -1,
    @SerializedName("sdi_speedlimit") var sdiSpeedLimit: Int = -1,
    @SerializedName("sdi_is_block_section") var sdiIsBlockSection: Boolean = false,
    @SerializedName("sdi_block_distance") var sdiBlockDistance: Int = -1,
    @SerializedName("sdi_block_speed") var sdiBlockSpeed: Int = -1,
    @SerializedName("sdi_block_average_speed") var sdiBlockAverageSpeed: Int = -1,
    @SerializedName("sdi_block_time") var sdiBlockTime: Int = -1,
    @SerializedName("is_changable_speed_type") var isChangableSpeedType: Boolean = false,
    @SerializedName("is_limit_speed_sign_changed") var isLimitSpeedSignChanged: Boolean = false,
)

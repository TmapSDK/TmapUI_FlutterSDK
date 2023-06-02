package android.src.main.kotlin.com.tmapmobility.tmap.tmapsdk.flutter.tmap_ui_sdk.model.drive_guide

import com.google.gson.annotations.SerializedName

enum class TBTTurnType(val value: Int) {
    @SerializedName("turnPtMap")
    turnPtMap(1),
    @SerializedName("turnPtTile")
    turnPtTile(2),
    @SerializedName("turnNotSerExp")
    turnNotSerExp(3),
    @SerializedName("turnNotSerNormal")
    turnNotSerNormal(4),
    @SerializedName("turnNotSerSpec")
    turnNotSerSpec(5),
    @SerializedName("strRight")
    strRight(6),
    @SerializedName("strLeft")
    strLeft(7),
    @SerializedName("turnStr")
    turnStr(11),
    @SerializedName("turnLeft")
    turnLeft(12),
    @SerializedName("turnRight")
    turnRight(13),
    @SerializedName("turnUturn")
    turnUturn(14),
    @SerializedName("turnPturn")
    turnPturn(15),
    @SerializedName("turnLeft8")
    turnLeft8(16),
    @SerializedName("turnLeft10")
    turnLeft10(17),
    @SerializedName("turnRignt2")
    turnRignt2(18),
    @SerializedName("turnRignt4")
    turnRignt4(19),
    @SerializedName("turnDir1")
    turnDir1(31),
    @SerializedName("turnDir2")
    turnDir2(32),
    @SerializedName("turnDir3")
    turnDir3(33),
    @SerializedName("turnDir4")
    turnDir4(34),
    @SerializedName("turnDir5")
    turnDir5(35),
    @SerializedName("turnDir6")
    turnDir6(36),
    @SerializedName("turnDir7")
    turnDir7(37),
    @SerializedName("turnDir8")
    turnDir8(38),
    @SerializedName("turnDir9")
    turnDir9(39),
    @SerializedName("turnDir10")
    turnDir10(40),
    @SerializedName("turnDir11")
    turnDir11(41),
    @SerializedName("turnDir12")
    turnDir12(42),
    @SerializedName("turnStrRight")
    turnStrRight(43),
    @SerializedName("turnStrLeft")
    turnStrLeft(44),
    @SerializedName("laneStr")
    laneStr(51),
    @SerializedName("laneLeft")
    laneLeft(52),
    @SerializedName("laneRight")
    laneRight(53),
    @SerializedName("lane1")
    lane1(54),
    @SerializedName("lane2")
    lane2(55),
    @SerializedName("lane3")
    lane3(56),
    @SerializedName("lane4")
    lane4(57),
    @SerializedName("lane5")
    lane5(58),
    @SerializedName("lane6")
    lane6(59),
    @SerializedName("lane7")
    lane7(60),
    @SerializedName("lane8")
    lane8(61),
    @SerializedName("lane9")
    lane9(62),
    @SerializedName("lane10")
    lane10(63),
    @SerializedName("firstExit")
    firstExit(71),
    @SerializedName("secExit")
    secExit(72),
    @SerializedName("firstLaneRight")
    firstLaneRight(73),
    @SerializedName("secLaneRight")
    secLaneRight(74),
    @SerializedName("firstLaneLeft")
    firstLaneLeft(75),
    @SerializedName("secLaneLeft")
    secLaneLeft(76),
    @SerializedName("hipassLeft")
    hipassLeft(80),
    @SerializedName("hipassRight")
    hipassRight(81),
    @SerializedName("hipassCenter")
    hipassCenter(82),
    @SerializedName("expInRight")
    expInRight(101),
    @SerializedName("expInLeft")
    expInLeft(102),
    @SerializedName("expInStr")
    expInStr(103),
    @SerializedName("expOutRight")
    expOutRight(104),
    @SerializedName("expOutLeft")
    expOutLeft(105),
    @SerializedName("expOutStr")
    expOutStr(106),
    @SerializedName("saexpInRight")
    saexpInRight(111),
    @SerializedName("saexpInLeft")
    saexpInLeft(112),
    @SerializedName("saexpInStr")
    saexpInStr(113),
    @SerializedName("saexpOutRight")
    saexpOutRight(114),
    @SerializedName("saexpOutLeft")
    saexpOutLeft(115),
    @SerializedName("saexpOutStr")
    saexpOutStr(116),
    @SerializedName("roadRight")
    roadRight(117),
    @SerializedName("roadLeft")
    roadLeft(118),
    @SerializedName("underIn")
    underIn(119),
    @SerializedName("overIn")
    overIn(120),
    @SerializedName("tunnelIn")
    tunnelIn(121),
    @SerializedName("bridge")
    bridge(122),
    @SerializedName("underOut")
    underOut(123),
    @SerializedName("overOut")
    overOut(124),
    @SerializedName("dir1")
    dir1(131),
    @SerializedName("dir2")
    dir2(132),
    @SerializedName("dir3")
    dir3(133),
    @SerializedName("dir4")
    dir4(134),
    @SerializedName("dir5")
    dir5(135),
    @SerializedName("dir6")
    dir6(136),
    @SerializedName("dir7")
    dir7(137),
    @SerializedName("dir8")
    dir8(138),
    @SerializedName("dir9")
    dir9(139),
    @SerializedName("dir10")
    dir10(140),
    @SerializedName("dir11")
    dir11(141),
    @SerializedName("dir12")
    dir12(142),
    @SerializedName("sa")
    sa(151),
    @SerializedName("saIn")
    saIn(152),
    @SerializedName("tolExp")
    tolExp(153),
    @SerializedName("tolNormal")
    tolNormal(154),
    @SerializedName("ferryIn")
    ferryIn(155),
    @SerializedName("ferryOut")
    ferryOut(156),
    @SerializedName("startdir1")
    startdir1(161),
    @SerializedName("startdir2")
    startdir2(162),
    @SerializedName("startdir3")
    startdir3(163),
    @SerializedName("startdir4")
    startdir4(164),
    @SerializedName("startdir5")
    startdir5(165),
    @SerializedName("startdir6")
    startdir6(166),
    @SerializedName("startdir7")
    startdir7(167),
    @SerializedName("startdir8")
    startdir8(168),
    @SerializedName("startdir9")
    startdir9(169),
    @SerializedName("startdir10")
    startdir10(170),
    @SerializedName("startdir11")
    startdir11(171),
    @SerializedName("startdir12")
    startdir12(172),
    @SerializedName("destStr")
    destStr(181),
    @SerializedName("destLeft")
    destLeft(182),
    @SerializedName("destRight")
    destRight(183),
    @SerializedName("posRight")
    posRight(184),
    @SerializedName("via1")
    via1(185),
    @SerializedName("via2")
    via2(186),
    @SerializedName("via3")
    via3(187),
    @SerializedName("via4")
    via4(188),
    @SerializedName("via5")
    via5(189),
    @SerializedName("noticeSpeed")
    noticeSpeed(191),
    @SerializedName("noticeAccident")
    noticeAccident(192),
    @SerializedName("noticeTurn")
    noticeTurn(193),
    @SerializedName("noticeRock")
    noticeRock(194),
    @SerializedName("noticePol")
    noticePol(195),
    @SerializedName("noticePol2")
    noticePol2(196),
    @SerializedName("start")
    start(200),
    @SerializedName("goal")
    goal(201),
    @SerializedName("goStraight")
    goStraight(202),
    @SerializedName("acrossFromDestination")
    acrossFromDestination(203),
    @SerializedName("inRoute")
    inRoute(210),
    @SerializedName("inExp")
    inExp(220),
    @SerializedName("inSaexp")
    inSaexp(221),
    @SerializedName("inSky")
    inSky(222),
    @SerializedName("inUnder")
    inUnder(223),
    @SerializedName("rdir1")
    rdir1(231),
    @SerializedName("rdir2")
    rdir2(232),
    @SerializedName("rdir3")
    rdir3(233),
    @SerializedName("rdir4")
    rdir4(234),
    @SerializedName("rdir5")
    rdir5(235),
    @SerializedName("rdir6")
    rdir6(236),
    @SerializedName("rdir7")
    rdir7(237),
    @SerializedName("rdir8")
    rdir8(238),
    @SerializedName("rdir9")
    rdir9(239),
    @SerializedName("rdir10")
    rdir10(240),
    @SerializedName("rdir11")
    rdir11(241),
    @SerializedName("rdir12")
    rdir12(242),
    @SerializedName("temp")
    temp(248),
    @SerializedName("tollgate")
    tollgate(249),
    @SerializedName("end")
    end(250),
    @SerializedName("na")
    na(0);

    companion object {
        infix fun from(value: Int): TBTTurnType =
            TBTTurnType.values().firstOrNull { it.value == value } ?: TBTTurnType.na
    }
}

enum class ComplexIntersectionVoiceType(val value: Int) {
    @SerializedName("strait")
    strait(51),

    @SerializedName("leftLane")
    leftLane(52),

    @SerializedName("rightLane")
    rightLane(53),

    @SerializedName("lane1")
    lane1(54),

    @SerializedName("lane2")
    lane2(55),

    @SerializedName("lane3")
    lane3(56),

    @SerializedName("lane4")
    lane4(57),

    @SerializedName("lane5")
    lane5(58),

    @SerializedName("lane6")
    lane6(59),

    @SerializedName("lane7")
    lane7(60),

    @SerializedName("lane8")
    lane8(61),

    @SerializedName("lane9")
    lane9(62),

    @SerializedName("lane10")
    lane10(63),

    @SerializedName("laneGreen")
    laneGreen(65),

    @SerializedName("lanePink")
    lanePink(66),

    @SerializedName("laneBlue")
    laneBlue(67),

    @SerializedName("laneYellow")
    laneYellow(68),

    @SerializedName("leftRoad")
    leftRoad(69),

    @SerializedName("rightRoad")
    rightRoad(70),

    @SerializedName("firstExit")
    firstExit(71),

    @SerializedName("secondExit")
    secondExit(72),

    @SerializedName("firstRightRoad")
    firstRightRoad(73),

    @SerializedName("secondRightRoad")
    secondRightRoad(74),

    @SerializedName("firstLeftRoad")
    firstLeftRoad(75),

    @SerializedName("secondLeftRoad")
    secondLeftRoad(76),

    @SerializedName("leftExit")
    leftExit(77),

    @SerializedName("rightExit")
    rightExit(78),

    @SerializedName("left1stLane")
    left1stLane(85),

    @SerializedName("left2ndLane")
    left2ndLane(86),

    @SerializedName("left3rdLane")
    left3rdLane(87),

    @SerializedName("left4thLane")
    left4thLane(88),

    @SerializedName("right1stLane")
    right1stLane(89),

    @SerializedName("right2ndLane")
    right2ndLane(90),

    @SerializedName("right3rdLane")
    right3rdLane(91),

    @SerializedName("right4thLane")
    right4thLane(92),

    @SerializedName("left1Lane")
    left1Lane(93),

    @SerializedName("left2Lane")
    left2Lane(94),

    @SerializedName("left3Lane")
    left3Lane(95),

    @SerializedName("left4Lane")
    left4Lane(96),

    @SerializedName("right1Lane")
    right1Lane(97),

    @SerializedName("right2Lane")
    right2Lane(98),

    @SerializedName("right3Lane")
    right3Lane(99),

    @SerializedName("right4Lane")
    right4Lane(100);

    companion object {
        infix fun from(value: Int): ComplexIntersectionVoiceType =
            ComplexIntersectionVoiceType.values().firstOrNull { it.value == value }
                ?: ComplexIntersectionVoiceType.strait
    }
}

data class TmapDriveGuideTBTModel(
    @SerializedName("tbt_distance") var tbtDistance: Int = -1,
    @SerializedName("tbt_time") var tbtTime: Int = -1,
    @SerializedName("tbt_turn_type") var tbtTurnType: TBTTurnType = TBTTurnType.na,
    @SerializedName("tollfee") var tollfee: Int = -1,
    @SerializedName("road_name") var roadName: String = "",
    @SerializedName("cross_name") var crossName: String = "",
    @SerializedName("near_direction_name") var nearDirectionName: String = "",
    @SerializedName("mid_direction_name") var midDirectionName: String = "",
    @SerializedName("far_direction_name") var farDirectionName: String = "",
    @SerializedName("main_text") var mainText: String = "",
    @SerializedName("complex_intersection_voice_type") var complexIntersectionVoiceType: ComplexIntersectionVoiceType = ComplexIntersectionVoiceType.strait,
)

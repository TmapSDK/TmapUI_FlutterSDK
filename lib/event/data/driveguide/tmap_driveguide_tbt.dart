import 'dart:convert';
import 'dart:core';
import 'package:json_annotation/json_annotation.dart';

// json serialize를 위해 자동 생성된 file
part 'tmap_driveguide_tbt.g.dart';

enum TBTTurnType {
  @JsonValue("turnPtMap") turnPtMap('turnPtMap'),
  @JsonValue("turnPtTile") turnPtTile('turnPtTile'),
  @JsonValue("turnNotSerExp") turnNotSerExp('turnNotSerExp'),
  @JsonValue("turnNotSerNormal") turnNotSerNormal('turnNotSerNormal'),
  @JsonValue("turnNotSerSpec") turnNotSerSpec('turnNotSerSpec'),
  @JsonValue("strRight") strRight('strRight'),
  @JsonValue("strLeft") strLeft('strLeft'),
  @JsonValue("turnStr") turnStr('turnStr'),
  @JsonValue("turnLeft") turnLeft('turnLeft'),
  @JsonValue("turnRight") turnRight('turnRight'),
  @JsonValue("turnUturn") turnUturn('turnUturn'),
  @JsonValue("turnPturn") turnPturn('turnPturn'),
  @JsonValue("turnLeft8") turnLeft8('turnLeft8'),
  @JsonValue("turnLeft10") turnLeft10('turnLeft10'),
  @JsonValue("turnRignt2") turnRignt2('turnRignt2'),
  @JsonValue("turnRignt4") turnRignt4('turnRignt4'),
  @JsonValue("turnDir1") turnDir1('turnDir1'),
  @JsonValue("turnDir2") turnDir2('turnDir2'),
  @JsonValue("turnDir3") turnDir3('turnDir3'),
  @JsonValue("turnDir4") turnDir4('turnDir4'),
  @JsonValue("turnDir5") turnDir5('turnDir5'),
  @JsonValue("turnDir6") turnDir6('turnDir6'),
  @JsonValue("turnDir7") turnDir7('turnDir7'),
  @JsonValue("turnDir8") turnDir8('turnDir8'),
  @JsonValue("turnDir9") turnDir9('turnDir9'),
  @JsonValue("turnDir10") turnDir10('turnDir10'),
  @JsonValue("turnDir11") turnDir11('turnDir11'),
  @JsonValue("turnDir12") turnDir12('turnDir12'),
  @JsonValue("turnStrRight") turnStrRight('turnStrRight'),
  @JsonValue("turnStrLeft") turnStrLeft('turnStrLeft'),
  @JsonValue("laneStr") laneStr('laneStr'),
  @JsonValue("laneLeft") laneLeft('laneLeft'),
  @JsonValue("laneRight") laneRight('laneRight'),
  @JsonValue("lane1") lane1('lane1'),
  @JsonValue("lane2") lane2('lane2'),
  @JsonValue("lane3") lane3('lane3'),
  @JsonValue("lane4") lane4('lane4'),
  @JsonValue("lane5") lane5('lane5'),
  @JsonValue("lane6") lane6('lane6'),
  @JsonValue("lane7") lane7('lane7'),
  @JsonValue("lane8") lane8('lane8'),
  @JsonValue("lane9") lane9('lane9'),
  @JsonValue("lane10") lane10('lane10'),
  @JsonValue("firstExit") firstExit('firstExit'),
  @JsonValue("secExit") secExit('secExit'),
  @JsonValue("firstLaneRight") firstLaneRight('firstLaneRight'),
  @JsonValue("secLaneRight") secLaneRight('secLaneRight'),
  @JsonValue("firstLaneLeft") firstLaneLeft('firstLaneLeft'),
  @JsonValue("secLaneLeft") secLaneLeft('secLaneLeft'),
  @JsonValue("hipassLeft") hipassLeft('hipassLeft'),
  @JsonValue("hipassRight") hipassRight('hipassRight'),
  @JsonValue("hipassCenter") hipassCenter('hipassCenter'),
  @JsonValue("expInRight") expInRight('expInRight'),
  @JsonValue("expInLeft") expInLeft('expInLeft'),
  @JsonValue("expInStr") expInStr('expInStr'),
  @JsonValue("expOutRight") expOutRight('expOutRight'),
  @JsonValue("expOutLeft") expOutLeft('expOutLeft'),
  @JsonValue("expOutStr") expOutStr('expOutStr'),
  @JsonValue("saexpInRight") saexpInRight('saexpInRight'),
  @JsonValue("saexpInLeft") saexpInLeft('saexpInLeft'),
  @JsonValue("saexpInStr") saexpInStr('saexpInStr'),
  @JsonValue("saexpOutRight") saexpOutRight('saexpOutRight'),
  @JsonValue("saexpOutLeft") saexpOutLeft('saexpOutLeft'),
  @JsonValue("saexpOutStr") saexpOutStr('saexpOutStr'),
  @JsonValue("roadRight") roadRight('roadRight'),
  @JsonValue("roadLeft") roadLeft('roadLeft'),
  @JsonValue("underIn") underIn('underIn'),
  @JsonValue("overIn") overIn('overIn'),
  @JsonValue("tunnelIn") tunnelIn('tunnelIn'),
  @JsonValue("bridge") bridge('bridge'),
  @JsonValue("underOut") underOut('underOut'),
  @JsonValue("overOut") overOut('overOut'),
  @JsonValue("dir1") dir1('dir1'),
  @JsonValue("dir2") dir2('dir2'),
  @JsonValue("dir3") dir3('dir3'),
  @JsonValue("dir4") dir4('dir4'),
  @JsonValue("dir5") dir5('dir5'),
  @JsonValue("dir6") dir6('dir6'),
  @JsonValue("dir7") dir7('dir7'),
  @JsonValue("dir8") dir8('dir8'),
  @JsonValue("dir9") dir9('dir9'),
  @JsonValue("dir10") dir10('dir10'),
  @JsonValue("dir11") dir11('dir11'),
  @JsonValue("dir12") dir12('dir12'),
  @JsonValue("sa") sa('sa'),
  @JsonValue("saIn") saIn('saIn'),
  @JsonValue("tolExp") tolExp('tolExp'),
  @JsonValue("tolNormal") tolNormal('tolNormal'),
  @JsonValue("ferryIn") ferryIn('ferryIn'),
  @JsonValue("ferryOut") ferryOut('ferryOut'),
  @JsonValue("startdir1") startdir1('startdir1'),
  @JsonValue("startdir2") startdir2('startdir2'),
  @JsonValue("startdir3") startdir3('startdir3'),
  @JsonValue("startdir4") startdir4('startdir4'),
  @JsonValue("startdir5") startdir5('startdir5'),
  @JsonValue("startdir6") startdir6('startdir6'),
  @JsonValue("startdir7") startdir7('startdir7'),
  @JsonValue("startdir8") startdir8('startdir8'),
  @JsonValue("startdir9") startdir9('startdir9'),
  @JsonValue("startdir10") startdir10('startdir10'),
  @JsonValue("startdir11") startdir11('startdir11'),
  @JsonValue("startdir12") startdir12('startdir12'),
  @JsonValue("destStr") destStr('destStr'),
  @JsonValue("destLeft") destLeft('destLeft'),
  @JsonValue("destRight") destRight('destRight'),
  @JsonValue("posRight") posRight('posRight'),
  @JsonValue("via1") via1('via1'),
  @JsonValue("via2") via2('via2'),
  @JsonValue("via3") via3('via3'),
  @JsonValue("via4") via4('via4'),
  @JsonValue("via5") via5('via5'),
  @JsonValue("noticeSpeed") noticeSpeed('noticeSpeed'),
  @JsonValue("noticeAccident") noticeAccident('noticeAccident'),
  @JsonValue("noticeTurn") noticeTurn('noticeTurn'),
  @JsonValue("noticeRock") noticeRock('noticeRock'),
  @JsonValue("noticePol") noticePol('noticePol'),
  @JsonValue("noticePol2") noticePol2('noticePol2'),
  @JsonValue("start") start('start'),
  @JsonValue("goal") goal('goal'),
  @JsonValue("goStraight") goStraight('goStraight'),
  @JsonValue("acrossFromDestination") acrossFromDestination('acrossFromDestination'),
  @JsonValue("inRoute") inRoute('inRoute'),
  @JsonValue("inExp") inExp('inExp'),
  @JsonValue("inSaexp") inSaexp('inSaexp'),
  @JsonValue("inSky") inSky('inSky'),
  @JsonValue("inUnder") inUnder('inUnder'),
  @JsonValue("rdir1") rdir1('rdir1'),
  @JsonValue("rdir2") rdir2('rdir2'),
  @JsonValue("rdir3") rdir3('rdir3'),
  @JsonValue("rdir4") rdir4('rdir4'),
  @JsonValue("rdir5") rdir5('rdir5'),
  @JsonValue("rdir6") rdir6('rdir6'),
  @JsonValue("rdir7") rdir7('rdir7'),
  @JsonValue("rdir8") rdir8('rdir8'),
  @JsonValue("rdir9") rdir9('rdir9'),
  @JsonValue("rdir10") rdir10('rdir10'),
  @JsonValue("rdir11") rdir11('rdir11'),
  @JsonValue("rdir12") rdir12('rdir12'),
  @JsonValue("temp") temp('temp'),
  @JsonValue("tollgate") tollgate('tollgate'),
  @JsonValue("end") end('end'),
  @JsonValue("na") na('na'),
  ;
  final String text;
  const TBTTurnType(this.text);

  factory TBTTurnType.getByText(String text){
    return TBTTurnType.values.firstWhere((value) => value.text == text,
        orElse: () => TBTTurnType.na);
  }
}

enum ComplexIntersectionVoiceType {
  @JsonValue("strait") strait('strait'),
  @JsonValue("leftLane") leftLane('leftLane'),
  @JsonValue("rightLane") rightLane('rightLane'),
  @JsonValue("lane1") lane1('lane1'),
  @JsonValue("lane2") lane2('lane2'),
  @JsonValue("lane3") lane3('lane3'),
  @JsonValue("lane4") lane4('lane4'),
  @JsonValue("lane5") lane5('lane5'),
  @JsonValue("lane6") lane6('lane6'),
  @JsonValue("lane7") lane7('lane7'),
  @JsonValue("lane8") lane8('lane8'),
  @JsonValue("lane9") lane9('lane9'),
  @JsonValue("lane10") lane10('lane10'),
  @JsonValue("laneGreen") laneGreen('laneGreen'),
  @JsonValue("lanePink") lanePink('lanePink'),
  @JsonValue("laneBlue") laneBlue('laneBlue'),
  @JsonValue("laneYellow") laneYellow('laneYellow'),
  @JsonValue("leftRoad") leftRoad('leftRoad'),
  @JsonValue("rightRoad") rightRoad('rightRoad'),
  @JsonValue("firstExit") firstExit('firstExit'),
  @JsonValue("secondExit") secondExit('secondExit'),
  @JsonValue("firstRightRoad") firstRightRoad('firstRightRoad'),
  @JsonValue("secondRightRoad") secondRightRoad('secondRightRoad'),
  @JsonValue("firstLeftRoad") firstLeftRoad('firstLeftRoad'),
  @JsonValue("secondLeftRoad") secondLeftRoad('secondLeftRoad'),
  @JsonValue("leftExit") leftExit('leftExit'),
  @JsonValue("rightExit") rightExit('rightExit'),
  @JsonValue("left1stLane") left1stLane('left1stLane'),
  @JsonValue("left2ndLane") left2ndLane('left2ndLane'),
  @JsonValue("left3rdLane") left3rdLane('left3rdLane'),
  @JsonValue("left4thLane") left4thLane('left4thLane'),
  @JsonValue("right1stLane") right1stLane('right1stLane'),
  @JsonValue("right2ndLane") right2ndLane('right2ndLane'),
  @JsonValue("right3rdLane") right3rdLane('right3rdLane'),
  @JsonValue("right4thLane") right4thLane('right4thLane'),
  @JsonValue("left1Lane") left1Lane('left1Lane'),
  @JsonValue("left2Lane") left2Lane('left2Lane'),
  @JsonValue("left3Lane") left3Lane('left3Lane'),
  @JsonValue("left4Lane") left4Lane('left4Lane'),
  @JsonValue("right1Lane") right1Lane('right1Lane'),
  @JsonValue("right2Lane") right2Lane('right2Lane'),
  @JsonValue("right3Lane") right3Lane('right3Lane'),
  @JsonValue("right4Lane") right4Lane('right4Lane'),
  ;
  final String text;
  const ComplexIntersectionVoiceType(this.text);

  factory ComplexIntersectionVoiceType.getByText(String text){
    return ComplexIntersectionVoiceType.values.firstWhere((value) => value.text == text,
        orElse: () => ComplexIntersectionVoiceType.strait);
  }
}

// NOTE. if this class is changed, please run below command in project root folder.
// $ flutter pub run build_runner build
@JsonSerializable()
class TmapDriveGuideTBT {
  /// Tbt까지의 거리를 나타냅니다.
  @JsonKey(name: 'tbt_distance')
  int tbtDistance = -1;
  /// TBT까지의 남은 시간을 나타냅니다. (초)
  @JsonKey(name: 'tbt_time')
  int tbtTime = -1;
  /// TBT의 종류를 나타냅니다.
  @JsonKey(name: 'tbt_turn_type')
  TBTTurnType tbtTurnType = TBTTurnType.na;
  /// tollgate의 요금을 나타냅니다. (단위 : 원)
  @JsonKey(name: 'tollfee')
  int tollfee = -1;
  /// 현재 주행중인 도로의 이름을 나타냅니다.
  @JsonKey(name: 'road_name')
  String roadName = "";
  /// 교차로의 이름을 나타냅니다.
  @JsonKey(name: 'cross_name')
  String crossName = "";
  /// 가장 가까운 방향의 이름을 나타냅니다.
  @JsonKey(name: 'near_direction_name')
  String nearDirectionName = "";
  /// 근거리 방향의 이름을 나타냅니다.
  @JsonKey(name: 'mid_direction_name')
  String midDirectionName = "";
  /// 원거리 방향의 이름을 나타냅니다.
  @JsonKey(name: 'far_direction_name')
  String farDirectionName = "";
  /// TBT의 main 이름을 나타냅니다.
  @JsonKey(name: 'main_text')
  String mainText = "";
  /// 음성안내 코드를 나타냅니다.
  @JsonKey(name: 'complex_intersection_voice_type')
  ComplexIntersectionVoiceType complexIntersectionVoiceType = ComplexIntersectionVoiceType.strait;

  TmapDriveGuideTBT({this.tbtDistance = -1,
    this.tbtTime = -1,
    this.tbtTurnType = TBTTurnType.na,
    this.tollfee = -1,
    this.roadName = "",
    this.crossName = "",
    this.nearDirectionName = "",
    this.midDirectionName = "",
    this.farDirectionName = "",
    this.mainText = "",
    this.complexIntersectionVoiceType = ComplexIntersectionVoiceType.strait});

  // ref : https://flutter-ko.dev/docs/development/data-and-backend/json
  factory TmapDriveGuideTBT.fromJson(Map<String, dynamic> json) => _$TmapDriveGuideTBTFromJson(json);
  Map<String, dynamic> toJson() => _$TmapDriveGuideTBTToJson(this);

  String toJsonString() => jsonEncode(this.toJson());
  factory TmapDriveGuideTBT.fromJsonString(String json) => TmapDriveGuideTBT.fromJson(jsonDecode(json));
}
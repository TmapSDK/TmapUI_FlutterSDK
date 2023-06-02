import 'dart:convert';
import 'dart:core';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmap_ui_sdk/config/marker/uisdk_marker_point.dart';

// json serialize를 위해 자동 생성된 file
part 'uisdk_marker.g.dart';

enum MarkerType {
  @JsonValue("point")            point('point'),
  @JsonValue("line")             line('line'),
  ;
  final String text;
  const MarkerType(this.text);

  factory MarkerType.getByText(String text){
    return MarkerType.values.firstWhere((value) => value.text == text,
        orElse: () => MarkerType.point);
  }
}

// NOTE. if this class is changed, please run below command in project root folder.
// $ flutter pub run build_runner build
@JsonSerializable()
class UISDKMarker {
  /// Marker를 표시할 좌표 (WGS84)
  /// line일 경우는 시작좌표와 끝 좌표를 넣어야 합니다.
  @JsonKey(name: 'marker_point')
  List<UISDKMarkerPoint>? markerPoint;

  /// marker의 고유 ID
  /// marker가 선택된 경우 event channel을 통하여 이 ID가 전달됩니다.
  @JsonKey(name: 'marker_id')
  String markerId = "";

  /// marker에 표현할 image가 저장된 절대 경로
  /// SDK에서는 절대경로에 접근하여 marker관련 이미지를 load하므로
  /// 접근가능한 folder에 file이 존재해야 합니다.
  @JsonKey(name: 'image_name')
  String imageName = "";

  /// marker의 type을 나타냅니다.
  @JsonKey(name: 'marker_type')
  MarkerType markerType = MarkerType.point;

  UISDKMarker({this.markerPoint,
    this.markerId = "",
    this.imageName = "",
    this.markerType = MarkerType.point});

  // ref : https://flutter-ko.dev/docs/development/data-and-backend/json
  factory UISDKMarker.fromJson(Map<String, dynamic> json) => _$UISDKMarkerFromJson(json);
  Map<String, dynamic> toJson() => _$UISDKMarkerToJson(this);

  String toJsonString() => jsonEncode(this.toJson());
  factory UISDKMarker.fromJsonString(String json) => UISDKMarker.fromJson(jsonDecode(json));
}
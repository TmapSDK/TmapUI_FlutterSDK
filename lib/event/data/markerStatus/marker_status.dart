import 'dart:core';
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

// json serialize를 위해 자동 생성된 file
part 'marker_status.g.dart';

enum SelectedMarkerType {
  @JsonValue("point")            point('point'),
  @JsonValue("callout")          callout('callout'),
  ;
  final String text;
  const SelectedMarkerType(this.text);

  factory SelectedMarkerType.getByText(String text){
    return SelectedMarkerType.values.firstWhere((value) => value.text == text,
        orElse: () => SelectedMarkerType.point);
  }
}

// NOTE. if this class is changed, please run below command in project root folder.
// $ flutter pub run build_runner build
@JsonSerializable()
class MarkerStatus {
  /// 선택된 marker의 ID를 타나냅니다.
  @JsonKey(name: 'selected_marker_id')
  String markerId = "";

  /// 선택된 marker의 type을 타나냅니다.
  @JsonKey(name: 'selected_marker_type')
  SelectedMarkerType markerType = SelectedMarkerType.point;

  MarkerStatus({this.markerId = "",
    this.markerType = SelectedMarkerType.point,
  });

  // ref : https://flutter-ko.dev/docs/development/data-and-backend/json
  factory MarkerStatus.fromJson(Map<String, dynamic> json) => _$MarkerStatusFromJson(json);
  Map<String, dynamic> toJson() => _$MarkerStatusToJson(this);

  String toJsonString() => jsonEncode(this.toJson());
  factory MarkerStatus.fromJsonString(String json) => MarkerStatus.fromJson(jsonDecode(json));
}
import 'package:json_annotation/json_annotation.dart';

enum PlanningOption {
  @JsonValue("Traffic_Recommend")         recommend('Traffic_Recommend'),
  @JsonValue("Traffic_MinTime")           minTime('Traffic_MinTime'),
  @JsonValue("Traffic_Free")              free('Traffic_Free'),
  @JsonValue("Shortest_ChargedAndFree")   shortest('Shortest_ChargedAndFree'),
  @JsonValue("Traffic_Highway")           highway('Traffic_Highway'),
  @JsonValue("Traffic_FirstTime")         firstTime('Traffic_FirstTime'),
  @JsonValue("Traffic_GeneralRoad")       generalRoad('Traffic_GeneralRoad'),
  @JsonValue("Traffic_Truck")             truck('Traffic_Truck'),
  @JsonValue("Traffic_AvoidSchoolZone")   avoidSchoolZone('Traffic_AvoidSchoolZone'),
  ;
  final String text;
  const PlanningOption(this.text);

  factory PlanningOption.getByText(String text){
    return PlanningOption.values.firstWhere((value) => value.text == text,
        orElse: () => PlanningOption.recommend);
  }
}
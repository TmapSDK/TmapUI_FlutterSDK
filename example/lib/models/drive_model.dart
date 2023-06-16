import 'package:tmap_ui_sdk/route/data/planning_option.dart';
import 'package:tmap_ui_sdk/route/data/route_point.dart';
import 'package:tmap_ui_sdk/route/data/route_request_data.dart';

class DriveModel {
  static bool safeDriving = false;

  RouteRequestData get routeRequestData =>
      getRouteRequestData(safeDriving: safeDriving);

  RouteRequestData getRouteRequestData({bool safeDriving = false}) {
    if (safeDriving) {
      return RouteRequestData(safeDriving: true);
    }

    List<PlanningOption> options = [
      PlanningOption.recommend,
      PlanningOption.shortest
    ];

    return RouteRequestData(
        source: RoutePoint(
            latitude: 37.564995, longitude: 126.987025, name: "TMOBI"),
        destination: RoutePoint(
            latitude: 37.566491, longitude: 126.985146, name: "SKT Tower"),
        routeOption: options,
    );
  }
}

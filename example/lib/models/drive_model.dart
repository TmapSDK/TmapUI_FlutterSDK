import 'package:tmap_ui_sdk/route/data/planning_option.dart';
import 'package:tmap_ui_sdk/route/data/route_point.dart';
import 'package:tmap_ui_sdk/route/data/route_request_data.dart';

class DriveModel {
  static bool safeDriving = false;
  static bool continueDriving = false;

  RouteRequestData get routeRequestData =>
      getRouteRequestData(safeDriving: safeDriving, continueDriving: continueDriving);

  RouteRequestData getRouteRequestData({bool safeDriving = false, bool continueDriving = false}) {
    if (safeDriving || continueDriving) {
      return RouteRequestData(safeDriving: safeDriving, continueDriving: continueDriving);
    }

    List<PlanningOption> options = [
      PlanningOption.recommend,
      PlanningOption.shortest
    ];

    List<RoutePoint> wayPoints = [
      RoutePoint(latitude: 37.563343, longitude: 126.987702, name: "명동성당"),
      RoutePoint(latitude: 37.575672, longitude: 126.977039, name: "광화문"),
    ];

    return RouteRequestData(
        source: RoutePoint(
            latitude: 37.564995, longitude: 126.987025, name: "TMOBI"),
        destination: RoutePoint(
            latitude: 37.566491, longitude: 126.985146, name: "SKT Tower"),
        wayPoints: wayPoints,
        routeOption: options,
    );
  }
}

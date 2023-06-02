import 'package:permission_handler/permission_handler.dart';

class LocationUtils {
  static Future<bool> requestLocationPermission() async {
    var locationStatus = await Permission.locationWhenInUse.status;
    if (locationStatus.isDenied) {
      locationStatus = await Permission.locationWhenInUse.request();
    }
    return locationStatus.isGranted;
  }
}

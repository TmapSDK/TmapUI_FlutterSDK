import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tmap_ui_sdk_example/widgets/simple_dialog.dart';

class LocationUtils {
  static Future<void> requestLocationPermission(BuildContext context,
      {required void Function() onGranted}) async {
    final ps = await _requestLocationPermission();
    if (ps != true) {
      if (context.mounted) {
        simpleDialog(
          context: context,
          titleText: '위치 권한이 필요 합니다.',
          rightButtonText: '권한 설정 하기',
          onRightBtnPressed: () async {
            final ps = await _requestLocationPermission();
            if (ps != true) {
              openAppSettings();
            } else {
              if (context.mounted) {
                onGranted();
                Navigator.pop(context);
              }
            }
          },
          shouldDismissOnTouchOutside: false,
        );
      }
    } else {
      onGranted();
    }
  }

  static Future<bool> _requestLocationPermission() async {
    var locationStatus = await Permission.locationWhenInUse.status;
    if (locationStatus.isDenied) {
      locationStatus = await Permission.locationWhenInUse.request();
    }
    return locationStatus.isGranted;
  }
}

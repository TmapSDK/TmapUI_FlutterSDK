import 'package:flutter/material.dart';
import 'package:tmap_ui_sdk_example/widgets/simple_dialog.dart';

class ContinueDriveUtil {
  static Future<void> askContinueDrive(BuildContext context,
      {required String destination, required void Function() onGranted, required void Function() onNotGranted}) async {
    if (context.mounted) {
      simpleDialog(
        context: context,
        titleText: '$destination (으)로 경로 안내를 이어서 안내 받으시겠습니까?',
        rightButtonText: '네',
        leftButtonText: '아니오',
        onRightBtnPressed: () async {
          onGranted();
          Navigator.pop(context);
        },
        onLeftBtnPressed: () async {
          onNotGranted();
          Navigator.pop(context);
        },
        shouldDismissOnTouchOutside: false,
      );
    }
  }
  static Future<void> alertContinueDrive(BuildContext context,
      {required String destination, required void Function() onGranted}) async {
    if (context.mounted) {
      simpleDialog(
        context: context,
        titleText: '저장된 경로정보가 없습니다.',
        rightButtonText: '네',
        onRightBtnPressed: () async {
          onGranted();
          Navigator.pop(context);
        },
        shouldDismissOnTouchOutside: false,
      );
    }
  }
}

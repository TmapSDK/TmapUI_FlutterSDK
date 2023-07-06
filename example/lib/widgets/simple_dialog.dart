import 'package:flutter/material.dart';

Future<T> simpleDialog<T>({
  required BuildContext context,
  String? titleText,
  String? bodyText,
  String? rightButtonText,
  String? leftButtonText,
  VoidCallback? onRightBtnPressed,
  VoidCallback? onLeftBtnPressed,
  bool shouldDismissOnTouchOutside = true,
}) async {
  return await showDialog(
    context: context,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async {
          return shouldDismissOnTouchOutside;
        },
        child: Container(
          margin: const EdgeInsets.all(24),
          alignment: Alignment.center,
          child: Card(
            clipBehavior: Clip.hardEdge,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 5,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (titleText != null) ...[
                  Container(
                    padding: EdgeInsets.only(
                      top: bodyText != null ? 32 : 48,
                      bottom: bodyText != null ? 12 : 48,
                      right: 20,
                      left: 20,
                    ),
                    child: Text(
                      titleText,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Color(0xFF171819),
                          fontSize: 18,
                          height: 24 / 18),
                    ),
                  ),
                ],
                if (bodyText != null) ...[
                  Container(
                    padding: EdgeInsets.only(
                      top: titleText != null ? 12 : 48,
                      bottom: titleText != null ? 32 : 48,
                      left: 20,
                      right: 20,
                    ),
                    child: Text(
                      bodyText,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Color(0xFF8C9299),
                          fontSize: 14,
                          height: 20 / 14),
                    ),
                  ),
                ],
                Row(
                  children: [
                    if (leftButtonText != null) ...[
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            onLeftBtnPressed?.call();
                            if (shouldDismissOnTouchOutside) {
                              Navigator.pop(context);
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            height: 52,
                            color: const Color(0xFFEEF0F3),
                            alignment: Alignment.center,
                            child: Text(
                              leftButtonText,
                              style: const TextStyle(
                                color: Color(0xFF171819),
                                fontSize: 16,
                                height: 22 / 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                    if (rightButtonText != null) ...[
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            onRightBtnPressed?.call();
                            if (shouldDismissOnTouchOutside) {
                              Navigator.pop(context);
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            height: 52,
                            color: const Color(0xFF0064FF),
                            alignment: Alignment.center,
                            child: Text(
                              rightButtonText,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                height: 22 / 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

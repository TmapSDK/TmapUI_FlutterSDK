import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tmap_ui_sdk/event/data/driveStatus/tmap_drivestatus.dart';
import 'package:tmap_ui_sdk/event/data/driveguide/tmap_driveguide.dart';
import 'package:tmap_ui_sdk/event/data/markerStatus/marker_status.dart';
import 'package:tmap_ui_sdk/event/data/sdkStatus/tmap_sdk_status.dart';
import 'package:tmap_ui_sdk/tmap_ui_sdk_manager.dart';
import 'package:tmap_ui_sdk/widget/tmap_view_widget.dart';
import 'package:tmap_ui_sdk_example/models/drive_model.dart';
import 'package:tmap_ui_sdk_example/common/app_routes.dart';
import 'package:tmap_ui_sdk_example/utils/continue_drive_utils.dart';

// Tmap의 UI와 함께 주행
class DrivePage extends StatefulWidget {
  const DrivePage({super.key});

  @override
  State<DrivePage> createState() => _DrivePageState();
}

class _DrivePageState extends State<DrivePage> {

  @override
  void initState() {
    super.initState();
    TmapUISDKManager().startTmapSDKStatusStream(_onEvent);
    TmapUISDKManager().startMarkerStatusStream(_onMarkerEvent);
    TmapUISDKManager().startTmapDriveStatusStream(_onDriveStatus);
    TmapUISDKManager().startTmapDriveGuideStream(_onDriveGuide);
  }

  void _onDriveStatus(TmapDriveStatus status) {
    if (status == TmapDriveStatus.onArrivedDestination) {
      debugPrint('[onDriveStatus] - onArrived');
    }
  }

  void _onDriveGuide(TmapDriveGuide guide) {
    debugPrint('[onDriveGuide] - matched Location(${guide.matchedLatitude},${guide.matchedLongitude}) ${guide.currentCourseAngle}');
    debugPrint('[onDriveGuide] - firstSDIInfo: ${guide.firstSDIInfo?.toJsonString()}');
    debugPrint('[onDriveGuide] - secondSDIInfo: ${guide.secondSDIInfo?.toJsonString()}');
    debugPrint('[onDriveGuide] - secondTBTInfo: ${guide.secondTBTInfo?.toJsonString()}');
    debugPrint('[onDriveGuide] - remainViaPointSize: ${guide.remainViaPointSize}');
  }

  void _onEvent(TmapSDKStatusMsg sdkStatus) {
    switch (sdkStatus.sdkStatus) {
      case TmapSDKStatus.dismissReq:
      // SDK가 종료 되었으니 현재의 widget을 닫는다.
        if (context.mounted) {
          if (context.mounted) {
            context.go(AppRoutes.rootPage);
          }
        }
        break;
      case TmapSDKStatus.continueDriveRequestedButNoSavedDriveInfo:
      // 이어가기 요청을 하였으나 저장된 경로 정보가 없다. 현재의 widget을 닫는다.
        ContinueDriveUtil.alertContinueDrive(
          context,
          destination: sdkStatus.extraData,
          onGranted: () {
            if (context.mounted) {
              context.go(AppRoutes.rootPage);
            }
          },
        );
        break;
      default:
        break;
    }
  }

  void _onMarkerEvent(MarkerStatus selectedMarker) {
    var selectedMarkerId = selectedMarker.markerId;
    var selectedMarkerType = selectedMarker.markerType;
    debugPrint('MarkerSelected -  ID:$selectedMarkerId type:$selectedMarkerType');
  }

  @override
  void dispose() {
    TmapUISDKManager().stopTmapSDKStatusStream();
    TmapUISDKManager().stopMarkerStatusStream();
    super.dispose();
  }

  Future<bool?> stopDriving() async {
    return await TmapUISDKManager().stopDriving();
  }

  Future<bool?> toNextViaPointRequest() async {
    return await TmapUISDKManager().toNextViaPointRequest();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        stopDriving();
        return true;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SafeArea(
          bottom: false,
          child: Container(
            color: Colors.white,
            child: Consumer<DriveModel>(
              builder: (context, drive, child) =>
                  TmapViewWidget(data: drive.routeRequestData),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // widget(native view)를 닫는다.
            // SDK가 종료되면 event channel로 현재의 widget을 닫아달라는 요청이 전달될 것이므로, 여기서 Navigator.pop(context);을 수행하진 않는다.
            stopDriving();
          },
          child: const Icon(Icons.close),
        ),
      ),
    );
  }
}

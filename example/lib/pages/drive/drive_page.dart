import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmap_ui_sdk/event/data/markerStatus/marker_status.dart';
import 'package:tmap_ui_sdk/event/data/sdkStatus/tmap_sdk_status.dart';
import 'package:tmap_ui_sdk/tmap_ui_sdk_manager.dart';
import 'package:tmap_ui_sdk/widget/tmap_view_widget.dart';
import 'package:tmap_ui_sdk_example/models/drive_model.dart';

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
  }

  void _onEvent(TmapSDKStatus sdkStatus) {
    switch (sdkStatus) {
      case TmapSDKStatus.dismissReq:
      // SDK가 종료 되었으니 현재의 widget을 닫는다.
        if (context.mounted) {
          Navigator.of(context).popUntil((route){
            // 주행화면을 닫는다.
            // example에서는 root page 바로 다음이 주행 화면이므로, root page를 만날때 까지 닫는다..
            return route.settings.name == '/';
          });
        }
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

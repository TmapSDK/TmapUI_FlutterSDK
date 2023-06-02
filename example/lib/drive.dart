import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:tmap_ui_sdk/event/channel/markerStatus/marker_status_event_channel.dart';
import 'package:tmap_ui_sdk/event/data/markerStatus/marker_status.dart';
import 'package:tmap_ui_sdk/route/data/route_request_data.dart';
import 'package:tmap_ui_sdk/event/data/driveguide/tmap_driveguide.dart';
import 'package:tmap_ui_sdk/event/channel/driveguide/driveguide_event_channel.dart';
import 'package:tmap_ui_sdk/event/data/driveStatus/tmap_drivestatus.dart';
import 'package:tmap_ui_sdk/event/channel/driveStatus/drivestatus_event_channel.dart';
import 'package:tmap_ui_sdk/event/data/sdkStatus/tmap_sdk_status.dart';
import 'package:tmap_ui_sdk/event/channel/sdkStatus/tmap_sdk_status_event_channel.dart';
import 'package:tmap_ui_sdk/tmap_ui_sdk_manager.dart';

import 'package:tmap_ui_sdk/widget/tmap_view_widget.dart';

// Tmap의 UI와 함께 주행
class TmapRoute extends StatefulWidget {
  final RouteRequestData data;
  const TmapRoute({ Key? key, required this.data }) : super(key: key);

  @override
  State<TmapRoute> createState() => _TmapRouteState();
}

class _TmapRouteState extends State<TmapRoute> {
  static const EventChannel sdkStatusEventChannel = EventChannel(TmapSDKStatusEvent.CHANNEL_NAME);
  static const EventChannel markerEventChannel = EventChannel(UISDKMarkerStatusEvent.CHANNEL_NAME);
  Future<bool?> stopDriving() async {
    return await TmapUISDKManager().stopDriving();
  }

  void _onEvent(Object? event) {
    var sdkStatus = TmapSDKStatus.getByText(event as String);
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

  void _onError(Object error) {
  }

  void _onMarkerEvent(Object? event) {
    var selectedMarker = MarkerStatus.fromJsonString(event as String);
    var selctedMarkerId = selectedMarker.markerId;
    var selectedMarkerType = selectedMarker.markerType;
    debugPrint('MarkerSelected -  ID:$selctedMarkerId type:$selectedMarkerType');
  }

  void _onMarkerError(Object error) {
  }

  @override
  Widget build(BuildContext context) {
    sdkStatusEventChannel.receiveBroadcastStream().listen(_onEvent, onError: _onError);
    markerEventChannel.receiveBroadcastStream().listen(_onMarkerEvent, onError: _onMarkerError);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Center(
        child:
        TmapViewWidget(data: widget.data),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // widget(native view)를 닫는다.
          // SDK가 종료되면 event channel로 현재의 widget을 닫아달라는 요청이 전달될 것이므로, 여기서 Navigator.pop(context);을 수행하진 않는다.
          stopDriving();
        },
        child: const Icon(Icons.close),
      ),
    );
  }
}

// 화면없이 주행상태만 전달받음
class TmapRouteWithoutPreview extends StatelessWidget {
  final RouteRequestData data;
  const TmapRouteWithoutPreview({ Key? key, required this.data }) : super(key: key);

  Future<bool?> stopDriving() async {
    return await TmapUISDKManager().stopDriving();
  }

  @override
  Widget build(BuildContext context) {
    // 화면이 나오는 경우는 widget을 통하여 경로요청 parameter가 전달되어 실행되는데
    // 이 화면에서는 화면 없이 주행중 데이터만 받아 처리를 하므로, method channel을 통하여 경로 요청을 직접 수행한다.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Center(
          child:
          Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                StreamBuilder<TmapDriveStatus>(
                  stream: TmapDriveStatusEvent.readings,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text((snapshot.error as PlatformException).message!);
                    } else if (snapshot.hasData) {
                      var status = snapshot.data as TmapDriveStatus;
                      return Text('Incoming - $status');
                    }
                    return const Text('TmapDriveStatus: No Data Available');
                  },
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: StreamBuilder<TmapDriveGuide>(
                      stream: TmapDriveGuideEvent.readings,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text((snapshot.error as PlatformException).message!);
                        } else if (snapshot.hasData) {
                          var guide = snapshot.data as TmapDriveGuide;
                          var json = guide.toJson();
                          JsonEncoder encoder = const JsonEncoder.withIndent('  ');
                          String prettyprint = encoder.convert(json);
                          return Text(prettyprint,
                            style: const TextStyle(
                              fontSize: 10,
                            ),
                          );
                        }
                        return const Text('TmapDriveGuide: No Data Available');
                      },
                    ),
                  ),
                ),
              ]
          )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // widget(native view)를 닫고
          stopDriving();
          // 현재 화면을 닫는다.
          Navigator.pop(context);
        },
        child: const Icon(Icons.close),
      ),
    );
  }
}
import 'package:flutter/services.dart';

import '/event/data/markerStatus/marker_status.dart';

class UISDKMarkerStatusEvent {
  static const String CHANNEL_NAME = 'com.tmapmobility.tmap.tmapsdk.flutter.tmapuisdk/event.markerStatus';
  static const _eventChannel = EventChannel(CHANNEL_NAME);

  static Stream<MarkerStatus> get readings {
    return _eventChannel.receiveBroadcastStream().map(
          (dynamic event) => MarkerStatus.fromJsonString(event as String)
    );
  }
}

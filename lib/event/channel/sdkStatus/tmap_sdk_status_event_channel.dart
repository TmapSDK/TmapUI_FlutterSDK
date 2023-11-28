import 'package:flutter/services.dart';

import '/event/data/sdkStatus/tmap_sdk_status.dart';

class TmapSDKStatusEvent {
  static const String CHANNEL_NAME = 'com.tmapmobility.tmap.tmapsdk.flutter.tmapuisdk/event.sdkStatus';
  static const _eventChannel = EventChannel(CHANNEL_NAME);

  static Stream<TmapSDKStatusMsg> get readings {
    return _eventChannel.receiveBroadcastStream().map(
          (dynamic event) => TmapSDKStatusMsg.fromJsonString(event as String)
    );
  }
}

import 'package:flutter/services.dart';

import '/event/data/sdkStatus/tmap_sdk_status.dart';

class TmapSDKStatusEvent {
  static const String CHANNEL_NAME = 'com.tmapmobility.tmap.tmapsdk.flutter.tmapuisdk/event.sdkStatus';
  static const _eventChannel = EventChannel(CHANNEL_NAME);

  static Stream<TmapSDKStatus> get readings {
    return _eventChannel.receiveBroadcastStream().map(
          (dynamic event) => TmapSDKStatus.getByText(event as String)
    );
  }
}

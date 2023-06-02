import 'package:flutter/services.dart';

import '/event/data/driveguide/tmap_driveguide.dart';

class TmapDriveGuideEvent {
  static const String CHANNEL_NAME = 'com.tmapmobility.tmap.tmapsdk.flutter.tmapuisdk/event.driveGuide';
  static const _eventChannel = EventChannel(CHANNEL_NAME);

  static Stream<TmapDriveGuide> get readings {
    return _eventChannel.receiveBroadcastStream().map(
          (dynamic event) => TmapDriveGuide.fromJsonString(event as String)
    );
  }
}

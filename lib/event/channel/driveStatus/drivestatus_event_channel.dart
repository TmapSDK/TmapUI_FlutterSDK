import 'package:flutter/services.dart';

import '/event/data/driveStatus/tmap_drivestatus.dart';

class TmapDriveStatusEvent {
  static const String CHANNEL_NAME = 'com.tmapmobility.tmap.tmapsdk.flutter.tmapuisdk/event.driveStatus';
  static const _eventChannel = EventChannel(CHANNEL_NAME);

  static Stream<TmapDriveStatus> get readings {
    return _eventChannel.receiveBroadcastStream().map(
          (dynamic event) => TmapDriveStatus.getByText(event as String)
    );
  }
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';

import '../route/data/route_request_data.dart';

const String viewType = 'tmapView';

// ref : https://docs.nabla.com/docs/wrap-viewcontroller-fragment-flutter

// AOS의 경우 flutter 3.x이상에서 map화면이 dart의 layout과 상관없이 화면 상단에 붙는 현상이 있음.
// mapbox, google map에서 다수 발생했던 현상. 확인 필요
// ref : https://github.com/flutter/flutter/issues/103630
// Virtual Display
// https://docs.flutter.dev/development/platform-integration/android/platform-views#putting-it-together
// Hybrid composition을 사용해야 함.
Widget _buildAndroid(BuildContext context, Map<String, dynamic> params) {
  return AndroidView(
    viewType: viewType,
    layoutDirection: TextDirection.ltr,
    creationParams: params,
    creationParamsCodec: const StandardMessageCodec(),
  );
}

// Hybrid Composition
// https://docs.flutter.dev/development/platform-integration/android/platform-views#putting-it-together
Widget _buildAndroid2(BuildContext context, Map<String, dynamic> creationParams) {
  return PlatformViewLink(
    viewType: viewType,
    surfaceFactory: (context, controller) {
      return AndroidViewSurface(
        controller: controller as AndroidViewController,
        gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
        hitTestBehavior: PlatformViewHitTestBehavior.opaque,
      );
    },
    onCreatePlatformView: (params) {
      // ref : https://github.com/flutter/flutter/issues/103630
      // ref : https://github.com/flutter-mapbox-gl/maps/issues/1041
      //return PlatformViewsService.initSurfaceAndroidView(
      return PlatformViewsService.initExpensiveAndroidView(
        id: params.id,
        viewType: params.viewType,
        layoutDirection: TextDirection.ltr,
        creationParams: creationParams,
        creationParamsCodec: const StandardMessageCodec(),
        onFocus: () {
          params.onFocusChanged(true);
        },
      )
        ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
        ..create();
    },
  );
}

Widget _buildIoS(BuildContext context, Map<String, dynamic> params) {
  return UiKitView(
    viewType: viewType,
    layoutDirection: TextDirection.ltr,
    creationParams: params,
    creationParamsCodec: const StandardMessageCodec(),
  );
}

class TmapViewWidget extends StatelessWidget {
  final RouteRequestData data;
  // const TmapViewWidget({
  //   Key? key, required this.data
  // }) : super(key: key);
  TmapViewWidget({required this.data});

  @override
  Widget build(BuildContext context) {
    // Pass parameters to the platform side.
    final Map<String, dynamic> params = <String, dynamic>{};
    params.putIfAbsent("args", () => data.toJsonString());

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return _buildAndroid2(context, params);
      case TargetPlatform.iOS:
        return _buildIoS(context, params);
      default:
        throw UnsupportedError('Unsupported platform view');
    }
  }
}
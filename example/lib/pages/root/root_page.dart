import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:tmap_ui_sdk/auth/data/auth_data.dart';
import 'package:tmap_ui_sdk/auth/data/init_result.dart';
import 'package:tmap_ui_sdk/config/marker/uisdk_marker.dart';
import 'package:tmap_ui_sdk/config/marker/uisdk_marker_config.dart';
import 'package:tmap_ui_sdk/config/marker/uisdk_marker_point.dart';
import 'package:tmap_ui_sdk/event/data/sdkStatus/tmap_sdk_status.dart';
import 'package:tmap_ui_sdk/tmap_ui_sdk.dart';
import 'package:tmap_ui_sdk/tmap_ui_sdk_manager.dart';
import 'package:tmap_ui_sdk_example/common/app_routes.dart';
import 'package:tmap_ui_sdk_example/models/car_config_model.dart';
import 'package:tmap_ui_sdk_example/models/drive_model.dart';
import 'package:tmap_ui_sdk_example/utils/location_utils.dart';
import 'package:tmap_ui_sdk_example/widgets/common_toast.dart';

import 'package:tmap_ui_sdk_example/utils/continue_drive_utils.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  String _platformVersion = 'Unknown';
  String _initStatus = "Unknown";
  final _tmapUiSdkPlugin = TmapUiSdk();
  InitResult tmapUISDKInitResult = InitResult.notGranted;

  @override
  void initState() {
    super.initState();
    TmapUISDKManager().startTmapSDKStatusStream(_onEvent);
    LocationUtils.requestLocationPermission(
        context,
        onGranted: () {
          initPlatformState();
        }
    );
  }

  void _onEvent(TmapSDKStatusMsg sdkStatus) {
    switch (sdkStatus.sdkStatus) {
      case TmapSDKStatus.savedDriveInfo:
      // 이전 주행정보가 있다. 사용자에게 물어본다.
        ContinueDriveUtil.askContinueDrive(
            context,
            destination: sdkStatus.extraData,
            onGranted: () {
              DriveModel.safeDriving = false;
              DriveModel.continueDriving = true;
              if (context.mounted) {
                context.go(AppRoutes.drivePage);
              }
            },
            onNotGranted: () {
              TmapUISDKManager().clearContinueDriveInfo();
            }
        );
        break;
      default:
        break;
    }
  }

  bool isInitWorking = false;
  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    if (isInitWorking) {
      CommonToast.show('TmapUISDK 초기화 진행 중 입니다.');
      return;
    }
    isInitWorking = true;
    String platformVersion;
    String initStatus = InitResult.notGranted.text;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await _tmapUiSdkPlugin.getPlatformVersion() ?? 'Unknown platform version';
      var manager = TmapUISDKManager();
      AuthData authInfo = AuthData(
          clientServiceName: "",
          clientAppVersion: "",
          clientID: "",
          clientApiKey: [발급받은 api key],
          clientApCode: "",
          userKey: [발급받은 user key 또는 빈문자열],
          deviceKey: [발급받은 device key 또는 빈문자열],
          clientDeviceId: "",
          isAvailableInBackground: true
      );
      InitResult result = await manager.initSDK(authInfo) ?? InitResult.notGranted;
      tmapUISDKInitResult = result;
      initStatus = result.text;
      CommonToast.show('TmapUISDK $initStatus');
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
      _initStatus = initStatus;
    });
    isInitWorking = false;
  }

  Future<bool?> finalizeSDK() async {
    var manager = TmapUISDKManager();
    bool? result = await manager.finalizeSDK();
    // app은 종료하도록 한다.
    // Platform별로 종료 코드가 다름에 주의.
    // https://stackoverflow.com/questions/45109557/flutter-how-to-programmatically-exit-the-app/57534684#57534684
    if (Platform.isIOS) {
      exit(0);
    } else {
      SystemNavigator.pop();
    }
    return result;
  }

  Future<bool?> setTruckConfig() async {
    var manager = TmapUISDKManager();
    CarConfigModel model = context.read<CarConfigModel>();
    bool? result = await manager.setConfigSDK(model.truckConfig);
    CommonToast.show(result == true ? "setTruckConfig success" : "setTruckConfig fail");

    return result;
  }

  Future<bool?> setCarConfig() async {
    var manager = TmapUISDKManager();
    CarConfigModel model = context.read<CarConfigModel>();
    bool? result = await manager.setConfigSDK(model.normalConfig);
    CommonToast.show(result == true ? "setCarConfig success" : "setCarConfig fail");

    return result;
  }

  Future<bool?> stopDriving() async {
    var manager = TmapUISDKManager();
    return await manager.stopDriving();
  }

  Future<bool?> setMarker() async {
    var manager = TmapUISDKManager();

    var pointMarkerImage = await getImageFileFromAssets("images/marker/detail_ico_place.png");
    var lineMarkerImage = await getImageFileFromAssets("images/marker/map_blue_dot_small.png");

    // point marker
    var pointMarker = UISDKMarker(
        markerPoint: [UISDKMarkerPoint(latitude: 37.564995, longitude: 126.987025)],
        markerId: "CustomMarkerPoint#1",
        imageName: pointMarkerImage,
        markerType: MarkerType.point);

    // line marker
    var lineMarker = UISDKMarker(
        markerPoint: [
          UISDKMarkerPoint(latitude: 37.564995, longitude: 126.987025), // from
          UISDKMarkerPoint(latitude: 37.566421, longitude: 126.985162) // to
        ],
        markerId: "CustomMarkerLine#1",
        imageName: lineMarkerImage,
        markerType: MarkerType.line);

    var markerInfo = UISDKMarkerConfig(markers: [
      pointMarker,
      lineMarker
    ]);

    bool? result = await manager.configMarker(markerInfo);
    CommonToast.show(result == true ? "setMarker success" : "setMarker fail");

    return result;
  }

  // asset의 file을 temp folder에 복사하여 file 생성
  Future<String> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.create(recursive: true);
    await file.writeAsBytes(byteData.buffer.asUint8List(
        byteData.offsetInBytes, byteData.lengthInBytes));

    return file.path;
  }

  Future<bool> checkTmapUISDK() async {
    if (tmapUISDKInitResult == InitResult.notGranted) {
      await initPlatformState();
    }
    return tmapUISDKInitResult == InitResult.granted;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Running on: $_platformVersion\n'),
                Text('Init Status: $_initStatus\n'),
                TextButton(
                  style: ButtonStyle(foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),),
                  onPressed: () {
                    setCarConfig();
                  },
                  child: const Text('Normal Car Config'),
                ),
                TextButton(
                  style: ButtonStyle(foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),),
                  onPressed: () {
                    setTruckConfig();
                  },
                  child: const Text('Truck Config'),
                ),
                TextButton(
                  style: ButtonStyle(foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),),
                  onPressed: () {
                    setMarker();
                  },
                  child: const Text('Set Custom Marker'),
                ),
                TextButton(
                  style: ButtonStyle(foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),),
                  onPressed: () async {
                    if (!(await checkTmapUISDK())) return;

                    DriveModel.safeDriving = false;
                    DriveModel.continueDriving = false;
                    if (context.mounted) {
                      context.go(AppRoutes.drivePage);
                    }
                  },
                  child: const Text('DriveTest'),
                ),
                TextButton(
                  style: ButtonStyle(foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),),
                  onPressed: () async {
                    if (!(await checkTmapUISDK())) return;

                    DriveModel.safeDriving = true;
                    DriveModel.continueDriving = false;
                    if (context.mounted) {
                      context.go(AppRoutes.drivePage);
                    }
                  },
                  child: const Text('SafeDrive'),
                ),
                TextButton(
                  style: ButtonStyle(foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),),
                  onPressed: () async {
                    if (!(await checkTmapUISDK())) return;

                    DriveModel.safeDriving = false;
                    DriveModel.continueDriving = true;
                    if (context.mounted) {
                      context.go(AppRoutes.drivePage);
                    }
                  },
                  child: const Text('ContinueDrive'),
                ),
                TextButton(
                  style: ButtonStyle(foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),),
                  onPressed: () {
                    finalizeSDK();
                  },
                  child: const Text('FinalizeSDK'),
                ),
              ]
          )
      ),
    );
  }
}

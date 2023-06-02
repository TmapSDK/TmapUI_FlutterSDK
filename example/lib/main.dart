import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tmap_ui_sdk/auth/data/auth_data.dart';
import 'package:tmap_ui_sdk/auth/data/init_result.dart';
import 'package:tmap_ui_sdk/config/marker/uisdk_marker.dart';
import 'package:tmap_ui_sdk/config/marker/uisdk_marker_config.dart';
import 'package:tmap_ui_sdk/config/marker/uisdk_marker_point.dart';
import 'package:tmap_ui_sdk/config/sdk_config.dart';
import 'package:tmap_ui_sdk/config/uisdk_truck_option.dart';
import 'package:tmap_ui_sdk/route/data/planning_option.dart';
import 'package:tmap_ui_sdk/route/data/route_point.dart';
import 'package:tmap_ui_sdk/route/data/route_request_data.dart';
import 'package:tmap_ui_sdk/tmap_ui_sdk.dart';
import 'package:tmap_ui_sdk/tmap_ui_sdk_manager.dart';
import 'package:tmap_ui_sdk_example/utils/location_utils.dart';
import 'package:tmap_ui_sdk_example/widget/common_toast.dart';
import 'package:tmap_ui_sdk_example/widget/simple_dialog.dart';

import 'drive.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tmap UI SDK Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const TmapExamplePage(),
    );
  }
}

class TmapExamplePage extends StatefulWidget {
  const TmapExamplePage({super.key});

  @override
  State<TmapExamplePage> createState() => _TmapExamplePageState();
}

class _TmapExamplePageState extends State<TmapExamplePage> {
  String _platformVersion = 'Unknown';
  String _initStatus = "Unknown";
  final _tmapUiSdkPlugin = TmapUiSdk();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
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
          userKey: [발급받은 user key],
          clientDeviceId: ""
      );
      InitResult result = await manager.initSDK(authInfo) ?? InitResult.notGranted;
      initStatus = result.text;
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
  }

  Future<bool?> setTruckConfig() async {
    UISDKTruckOption truckOption = UISDKTruckOption(
        truckHeight: 300, // cm
        truckLength: 0,
        truckLoadingWeight: 25000, // kg
        truckType: TruckType.constructionTruck,
        truckWidth: 0
    );
    SDKConfig config = SDKConfig(
        carType: UISDKCarModel.truck,
        truckOption: truckOption,
        fuelType: UISDKFuel.diesel,
        showTrafficAccident: true,
        mapTextSize: UISDKMapFontSize.large,
        nightMode: UISDKAutoNightModeType.auto,
        isUseSpeedReactMapScale: true,
        isShowTrafficInRoute: true);
    var manager = TmapUISDKManager();

    bool? result = await manager.setConfigSDK(config);
    CommonToast.show(result == true ? "setTruckConfig success" : "setTruckConfig fail");

    return result;
  }

  Future<bool?> setCarConfig() async {
    SDKConfig config = SDKConfig(
        carType: UISDKCarModel.normal,
        fuelType: UISDKFuel.diesel,
        showTrafficAccident: true,
        mapTextSize: UISDKMapFontSize.large,
        nightMode: UISDKAutoNightModeType.auto,
        isUseSpeedReactMapScale: true,
        isShowTrafficInRoute: true);
    var manager = TmapUISDKManager();

    bool? result = await manager.setConfigSDK(config);
    CommonToast.show(result == true ? "setCarConfig success" : "setCarConfig fail");

    return result;
  }

  RouteRequestData testRouteData({bool withoutPreview = false}) {
    List<PlanningOption> options = [
      PlanningOption.recommend,
      PlanningOption.shortest
    ];

    RouteRequestData requestData = RouteRequestData(
        source: RoutePoint(latitude: 37.564995, longitude: 126.987025, name: "TMOBI"),
        destination: RoutePoint(latitude: 37.566491, longitude: 126.985146, name: "SKT Tower"),
        routeOption: options,
        guideWithoutPreview: withoutPreview
    );
    return requestData;
  }

  RouteRequestData testSafeDriveData({bool withoutPreview = false}) {
    RouteRequestData requestData = RouteRequestData(safeDriving: true);
    return requestData;
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

  Future<bool> _onBackPressed() {
    // appbar의 backbutton은 눌렀을때
    stopDriving();
    return Future.value(true);
  }

  Future<void> requestLocationPermission({required void Function() onGranted}) async {
    final ps = await LocationUtils.requestLocationPermission();
    if (ps != true) {
      if (context.mounted) {
        simpleDialog(
          context: context,
          titleText: '위치 권한이 필요 합니다.',
          leftButtonText: '나중에',
          rightButtonText: '권한 설정 하기',
          onRightBtnPressed: () {
            openAppSettings();
          },
        );
      }
    } else {
      onGranted();
    }
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
                  onPressed: () {
                    if (_initStatus != InitResult.granted.text) return;

                    requestLocationPermission(
                        onGranted: () {
                          Navigator.of(context).push<void>(
                            MaterialPageRoute<void>(
                                builder: (_) => WillPopScope(
                                  onWillPop: _onBackPressed,
                                  child: TmapRoute(data: testRouteData()),
                                )),
                          );
                        }
                    );
                  },
                  child: const Text('DriveTest'),
                ),
                TextButton(
                  style: ButtonStyle(foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),),
                  onPressed: () {
                    requestLocationPermission(
                        onGranted: () {
                          Navigator.of(context).push<void>(
                            MaterialPageRoute<void>(
                                builder: (_) => WillPopScope(
                                  onWillPop: _onBackPressed,
                                  child: TmapRoute(data: testSafeDriveData()),
                                )),
                          );
                        }
                    );
                  },
                  child: const Text('SafeDrive'),
                ),
                TextButton(
                  style: ButtonStyle(foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),),
                  onPressed: () {
                    requestLocationPermission(
                      onGranted: () {
                        Navigator.of(context).push<void>(
                          MaterialPageRoute<void>(
                              builder: (_) => WillPopScope(
                                onWillPop: _onBackPressed,
                                child: TmapRouteWithoutPreview(
                                    data: testRouteData(withoutPreview: true)),
                              )),
                        );
                      }
                    );
                  },
                  child: const Text('DriveTestWithoutPreview'),
                ),
              ]
          )
      ),
    );
  }
}

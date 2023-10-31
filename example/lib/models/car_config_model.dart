import 'package:tmap_ui_sdk/config/sdk_config.dart';
import 'package:tmap_ui_sdk/config/uisdk_truck_option.dart';

class CarConfigModel {
  SDKConfig get normalConfig => SDKConfig(
      carType: UISDKCarModel.normal,
      fuelType: UISDKFuel.diesel,
      showTrafficAccident: true,
      mapTextSize: UISDKMapFontSize.small,
      nightMode: UISDKAutoNightModeType.auto,
      isUseSpeedReactMapScale: true,
      isShowTrafficInRoute: true,
      isShowExitPopupWhenStopDriving: true,
      useRealTimeAutoReroute: true);

  SDKConfig get truckConfig => SDKConfig(
      carType: UISDKCarModel.truck,
      truckOption: _truckOption,
      fuelType: UISDKFuel.diesel,
      showTrafficAccident: true,
      mapTextSize: UISDKMapFontSize.large,
      nightMode: UISDKAutoNightModeType.auto,
      isUseSpeedReactMapScale: true,
      isShowTrafficInRoute: true,
      isShowExitPopupWhenStopDriving: false,
      useRealTimeAutoReroute: false);

  UISDKTruckOption get _truckOption => UISDKTruckOption(
      truckHeight: 300, // cm
      truckLength: 0,
      truckLoadingWeight: 25000, // kg
      truckType: TruckType.constructionTruck,
      truckWidth: 0
  );
}

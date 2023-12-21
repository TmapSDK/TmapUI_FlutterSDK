package android.src.main.kotlin.com.tmapmobility.tmap.tmapsdk.flutter.tmap_ui_sdk

import android.content.Context
import android.content.ContextWrapper
import android.graphics.BitmapFactory
import android.os.Bundle
import android.view.View
import android.view.ViewGroup
import android.widget.LinearLayout
import androidx.fragment.app.FragmentActivity
import androidx.fragment.app.FragmentContainerView
import androidx.fragment.app.FragmentManager
import androidx.lifecycle.findViewTreeLifecycleOwner
import com.skt.tmap.engine.navigation.network.ndds.NddsDataType
import com.skt.tmap.engine.navigation.route.RoutePlanType
import com.skt.tmap.vsm.data.VSMMapPoint
import com.skt.tmap.vsm.map.MapEngine
import com.skt.tmap.vsm.map.marker.MarkerImage
import com.skt.tmap.vsm.map.marker.VSMMarkerBase
import com.skt.tmap.vsm.map.marker.VSMMarkerPoint
import com.skt.tmap.vsm.map.marker.VSMMarkerPolyline
import android.src.main.kotlin.com.tmapmobility.tmap.tmapsdk.flutter.tmap_ui_sdk.event.DriveGuideStreamer
import android.src.main.kotlin.com.tmapmobility.tmap.tmapsdk.flutter.tmap_ui_sdk.event.DriveStatusStreamer
import android.src.main.kotlin.com.tmapmobility.tmap.tmapsdk.flutter.tmap_ui_sdk.event.MarkerStreamer
import android.src.main.kotlin.com.tmapmobility.tmap.tmapsdk.flutter.tmap_ui_sdk.event.SDKStatusStreamer
import android.src.main.kotlin.com.tmapmobility.tmap.tmapsdk.flutter.tmap_ui_sdk.model.*
import android.src.main.kotlin.com.tmapmobility.tmap.tmapsdk.flutter.tmap_ui_sdk.model.drive_guide.TmapDriveGuideModel
import android.src.main.kotlin.com.tmapmobility.tmap.tmapsdk.flutter.tmap_ui_sdk.utils.PreferenceUtils
import android.util.Log
import android.widget.Toast
import com.tmapmobility.tmap.tmapsdk.ui.data.CarOption
import com.tmapmobility.tmap.tmapsdk.ui.data.MapSetting
import com.tmapmobility.tmap.tmapsdk.ui.fragment.NavigationFragment
import com.tmapmobility.tmap.tmapsdk.ui.util.TmapUISDK
import io.flutter.embedding.android.FlutterView
import io.flutter.embedding.engine.mutatorsstack.FlutterMutatorView
import io.flutter.plugin.platform.PlatformView
import org.json.JSONObject
import java.lang.ref.WeakReference
import java.util.*

class FlutterDrivingStatusCallback(activity: FragmentActivity?): TmapUISDK.DrivingStatusCallback {
  private val _activity: WeakReference<FragmentActivity>?

  init {
    _activity = WeakReference(activity)
  }

  // 주의. EventChannel.StreamHandler를 이용하여 데이터를 전달하는 경우 uithread에서 해당 내용을 실행하지 않으면 java.lang.RuntimeException이 발생함.
  override fun onStartNavigation() {
    _activity?.get()?.runOnUiThread {
      SDKStatusStreamer.success(TmapSDKStatusMsgModel(TmapSDKStatus.MAP_INITIALIZING,""))
    }
  }

  override fun onStartNavigationInfo(totalDistanceInMeter: Int, totalTimeInSec: Int, tollFee: Int) {
    //TODO. 주행시작 정보 전달루틴 채워야 함.
  }

  override fun onStopNavigation() {
    _activity?.get()?.runOnUiThread {
      SDKStatusStreamer.success(TmapSDKStatusMsgModel(TmapSDKStatus.DISMISS_REQ,""))
    }
  }

  override fun onPermissionDenied(errorCode: Int, errorMsg: String?) {
    _activity?.get()?.runOnUiThread {
      SDKStatusStreamer.success(TmapSDKStatusMsgModel(TmapSDKStatus.DISMISS_N_REQUEST_PERMISSION,""))
    }
  }

  override fun onArrivedDestination(destination: String, drivingTime: Int, drivingDistance: Int) {
    //TODO. 주행종료 정보 전달루틴 채워야 함.
    _activity?.get()?.runOnUiThread {
      DriveStatusStreamer.success(TmapDriveStatusModel.OnArrivedDestination)
    }
  }

  override fun onBreakawayFromRouteEvent() {
    _activity?.get()?.runOnUiThread {
      DriveStatusStreamer.success(TmapDriveStatusModel.OnBreakawayFromRouteEvent)
    }
  }

  override fun onApproachingAlternativeRoute() {
    _activity?.get()?.runOnUiThread {
      DriveStatusStreamer.success(TmapDriveStatusModel.OnApproachingAlternativeRoute)
    }
  }

  override fun onPassedAlternativeRouteJunction() {
    _activity?.get()?.runOnUiThread {
      DriveStatusStreamer.success(TmapDriveStatusModel.OnPassedAlternativeRouteJunction)
    }
  }

  override fun onPeriodicReroute() {
    _activity?.get()?.runOnUiThread {
      DriveStatusStreamer.success(TmapDriveStatusModel.OnPeriodicReroute)
    }
  }

  override fun onRouteChanged(index: Int) {
    _activity?.get()?.runOnUiThread {
      DriveStatusStreamer.success(TmapDriveStatusModel.OnRouteChanged)
    }
  }

  override fun onForceReroute(periodicType: NddsDataType.DestSearchFlag) {
    _activity?.get()?.runOnUiThread {
      DriveStatusStreamer.success(TmapDriveStatusModel.OnForceReroute)
    }
  }

  override fun onNoLocationSignal(noLocationSignal: Boolean) {
    _activity?.get()?.runOnUiThread {
      DriveStatusStreamer.success(TmapDriveStatusModel.OnNoLocationSignal)
    }
  }

  override fun onApproachingViaPoint() {
    _activity?.get()?.runOnUiThread {
      DriveStatusStreamer.success(TmapDriveStatusModel.OnApproachingViaPoint)
    }
  }

  override fun onPassedViaPoint() {
    _activity?.get()?.runOnUiThread {
      DriveStatusStreamer.success(TmapDriveStatusModel.OnPassedViaPoint)
    }
  }

  override fun onChangeRouteOptionComplete(routePlanType: RoutePlanType) {
    _activity?.get()?.runOnUiThread {
      DriveStatusStreamer.success(TmapDriveStatusModel.OnChangeRouteOptionComplete)
    }
  }

  override fun onBreakAwayRequestComplete() {
    _activity?.get()?.runOnUiThread {
      DriveStatusStreamer.success(TmapDriveStatusModel.OnBreakAwayRequestComplete)
    }
  }

  override fun onPeriodicRerouteComplete() {
    _activity?.get()?.runOnUiThread {
      DriveStatusStreamer.success(TmapDriveStatusModel.OnPeriodicRerouteComplete)
    }
  }

  override fun onUserRerouteComplete() {
    _activity?.get()?.runOnUiThread {
      DriveStatusStreamer.success(TmapDriveStatusModel.OnUserRerouteComplete)
    }
  }

  override fun onDestinationDirResearchComplete() {
    _activity?.get()?.runOnUiThread {
      DriveStatusStreamer.success(TmapDriveStatusModel.OnDestinationDirResearchComplete)
    }
  }

  override fun onDoNotRerouteToDestinationComplete() {}

  override fun onFailRouteRequest(errorCode: String, errorMessage: String) {
    _activity?.get()?.runOnUiThread {
      DriveStatusStreamer.success(TmapDriveStatusModel.OnFailRouteRequest)
    }
  }

  override fun onPassedTollgate(fee: Int) {
    _activity?.get()?.runOnUiThread {
      DriveStatusStreamer.success(TmapDriveStatusModel.OnPassedTollgate)
    }
  }

  override fun onLocationChanged() {}

}

class TmapUiSdkView(
  context: Context,
  creationParams: Map<*, *>?,
) : PlatformView {
  private val TAG = "TmapUiSdkView"
  private val _context: Context
  private val navigationFragment: NavigationFragment
  private val fragmentContainer: FragmentContainerView
  private val viewId: Int
  private val navigationRequestModel: NavigationRequestModel?
  private var routeRequested: Boolean = false
  private var getViewCalledCount = 0

  private var driveStatusChangedListener : FlutterDrivingStatusCallback? = null
  init {
    _context = context
    viewId = View.generateViewId()
    val json = creationParams?.let { JSONObject(it) }
    navigationRequestModel = json?.let { RouteRequestData.create(it.getString("args")) }
    val vParams: ViewGroup.LayoutParams = LinearLayout.LayoutParams(
      ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT
    )
    /*
     1. FragmentContainerView를 특정 ID로 일단 activity에 붙인다음
        이걸 하지 않으면 fragment manager로 view를 replace할때 id를 이용하여 view를 찾는데 못찾는다는 exception이 발생
     2. fragment manager로 해당 id를 fragment로 replace하고
     3. PlatformView.getView에서 일단 FragmentContainerView를 반환하고
        이때는 fragment의 view가 생성되지 않은 시점이다.
     4. 이후 fragment의 view가 생성이 되면 (onCreateView까지 호출되고)
     5. 다시 PlatformView.getView를 받아갈때 FragmentContainerView의 parent가 FlutterMutatorView가 아니면 parent를 삭제
     6. 이렇게 되면 flutter 내부에서 받아간 PlatformView의 parent로 FlutterMutatorView를 붙인다.
     */

    fragmentContainer = FragmentContainerView(context)
    fragmentContainer.layoutParams = vParams
    fragmentContainer.id = viewId

    val activity = _context.getFragmentActivity()
    activity?.addContentView(
      fragmentContainer,
      vParams
    )
    navigationFragment = TmapUISDK.getFragment()
    activity?.let {
      driveStatusChangedListener = FlutterDrivingStatusCallback(activity)
      navigationFragment.drivingStatusCallback = driveStatusChangedListener
    }
    subscribeEDCData()
    val carOption: CarOption? = PreferenceUtils.carOption
    if (carOption != null) {
      navigationFragment.carOption = carOption
    }
    val fm: FragmentManager? = activity?.supportFragmentManager
    fm?.beginTransaction()
      ?.replace(viewId, navigationFragment)
      ?.commitAllowingStateLoss()
  }

  private fun subscribeEDCData() {
    fragmentContainer.findViewTreeLifecycleOwner()?.let {
      TmapUISDK.observableEDCData.observe(it) { edcData ->
        if (edcData != null) {
          val tmapDriveGuideModel = TmapDriveGuideModel.create(edcData)
          DriveGuideStreamer.success(tmapDriveGuideModel)
        }
      }
    }
  }

  override fun getView(): View {
    synchronized(this) {
      getViewCalledCount += 1
      Log.d(TAG,"getView() start -----------")
      val viewInFragment = navigationFragment.view
      val myParentView = fragmentContainer.parent
      val myGrandParentView = myParentView?.parent

      val isFragmentHasView = (viewInFragment != null)
      // flutter 내부에서 전달한 view에 parent로 FlutterMutatorView를 붙이는데
      // 이미 parent가 있으면 exception이 발생한다.
      val isNotMyParentFromFlutter = (myParentView != null && myParentView !is FlutterMutatorView)

      val isFlutterDisplaying = (myGrandParentView != null && myGrandParentView is FlutterView)

      /*
        문제의 exception "The Android view returned from PlatformView#getView() was already added to a parent view."은 flutter 내부의 initializePlatformViewIfNeeded 함수에서 벌어짐

        call stack
          getView:251, TmapUiSdkView (android.src.main.kotlin.com.tmapmobility.tmap.tmapsdk.flutter.tmap_ui_sdk)
          initializePlatformViewIfNeeded:1051, PlatformViewsController (io.flutter.plugin.platform)
          onDisplayPlatformView:1115, PlatformViewsController (io.flutter.plugin.platform)
          onDisplayPlatformView:1398, FlutterJNI (io.flutter.embedding.engine)
          nativePollOnce:-1, MessageQueue (android.os)
          next:335, MessageQueue (android.os)
          loopOnce:186, Looper (android.os)
          loop:313, Looper (android.os)
          main:8751, ActivityThread (android.app)

        문제의 코드 (flutter 내부)
          final View embeddedView = platformView.getView();
          if (embeddedView == null) {
            throw new IllegalStateException(
                "PlatformView#getView() returned null, but an Android view reference was expected.");
          }
          if (embeddedView.getParent() != null) {
            throw new IllegalStateException(
                "The Android view returned from PlatformView#getView() was already added to a parent view."); <-- 이부분
          }

        문제의 상황은 instance가 생성되고 나서 두번째의 getView가 호출되는 시점이다.
       */

      // release mode build를 할 경우는 progurad로 인하여 method의 이름이 변경되므로 아래의 루틴이 동작하지 않음. (debug mode일떄만 정상동작함)
      val exceptionOccurMethod = "initializePlatformViewIfNeeded"
      val callStack = Thread.currentThread().stackTrace
      val callFromInitializePlatformViewIfNeeded = callStack.map { it.methodName }.any { it == exceptionOccurMethod }

      // 문제의 상황은 두번째 call부분이다.
      // TODO. 추후 flutter 내부의 로직이 변경될 경우 오동작을 일으킬 수도 있으므로 주의해야 한다.
      val possibleExceptionOccurMethodCall = (getViewCalledCount == 2)

      // view가 생성되고 flutter에서 모든 작업이 완료되어 출력하고 있는 상태가 아니라면..
      var parentRemoved = false
      if ((isFragmentHasView && !isFlutterDisplaying && isNotMyParentFromFlutter) ||
          callFromInitializePlatformViewIfNeeded || // 타이밍에 따라 view가 생성되기 전 문제의 코드가 호출되면서 parent를 검사할 때가 있다.
          possibleExceptionOccurMethodCall) { // exception을 발생시키는 call은 두번째 이다.
        (fragmentContainer.parent as ViewGroup).removeView(fragmentContainer as ViewGroup)
        parentRemoved = true
      }
      Log.d(TAG,"getViewCalledCount:$getViewCalledCount callFromInitializePlatformViewIfNeeded:$callFromInitializePlatformViewIfNeeded isFragmentHasView:$isFragmentHasView isFlutterDisplaying:$isFlutterDisplaying isNotMyParentFromFlutter:$isNotMyParentFromFlutter parentRemoved:$parentRemoved myParentView:$myParentView")

      // 요청은 한번만
      if (isFlutterDisplaying && !routeRequested) {
        routeRequested = true
        Log.d(TAG,"request to Navigate!")
        val mapSetting: MapSetting? = PreferenceUtils.mapSetting
        if (mapSetting != null) {
          navigationFragment.setSettings(mapSetting)
        }

        if (navigationRequestModel != null) {
          if (navigationRequestModel.safeDriving) {
            navigationFragment.startSafeDrive()
          } else if (navigationRequestModel.continueDriving) {
            val ret = navigationFragment.continueDrive()
            if (!ret) {
              SDKStatusStreamer.success(
                TmapSDKStatusMsgModel(
                  TmapSDKStatus.CONTINUE_DRIVE_REQUESTED_NO_SAVED_DRIVE_INFO,
                  ""
                )
              )
            }
          } else {
            navigationFragment.requestRoute(
              navigationRequestModel.departure,
              navigationRequestModel.wayPoints,
              navigationRequestModel.destination,
              navigationRequestModel.withoutPreview,
              object : TmapUISDK.RouteRequestListener {
                override fun onSuccess() {}
                override fun onFail(errorCode: Int, errorMsg: String?) {
                  val errorMessage = "error: $errorCode Msg:${errorMsg ?: "NA"}"
                  Log.e(TAG,"requestRoute - onFail() $errorCode $errorMsg")
                  navigationFragment.activity?.let {
                    it.runOnUiThread {
                      Toast.makeText(it.applicationContext, errorMessage, Toast.LENGTH_SHORT).show()
                    }
                  }
                  // 경로 요청에 실패하였으므로 widget을 닫아 달라고 요청한다.
                  // 요청 실패에 대한 정보를 extraData로 담아서 전달한다.
                  SDKStatusStreamer.success(TmapSDKStatusMsgModel(TmapSDKStatus.DISMISS_REQ, "$errorCode"))
                }
              },
              navigationRequestModel.routePlans
            )
          }
        }
        setMarker()
      }
      Log.d(TAG,"getView() Ends -----------")
    }
    return fragmentContainer
  }

  override fun dispose() {
    // 붙어있던 fragment를 삭제한다.
    val activity = _context.getFragmentActivity()
    val fm: FragmentManager? = activity?.supportFragmentManager
    fm?.beginTransaction()
      ?.remove(navigationFragment)
      ?.commitAllowingStateLoss()
  }

  private fun Context.getFragmentActivity(): FragmentActivity? {
    if (this is FragmentActivity) {
      return this
    }

    var currentContext = this
    while (currentContext is ContextWrapper) {
      if (currentContext is FragmentActivity) {
        return currentContext
      }
      currentContext = currentContext.baseContext
    }

    return null
  }

  private fun setMarker() {
    val makerManager = navigationFragment.getMapView()?.markerManager
    val configMarker: ConfigMarkerModel? = ConfigMarkerModel.model
    if (makerManager != null && configMarker != null) {
      val markers = configMarker.markers
      if (markers != null && markers.isNotEmpty()) {
        for (marker in markers) {
          val customRID = marker.markerId
          val filePath = marker.imageName
          val markIcon = BitmapFactory.decodeFile(filePath)
          if (marker.markerType == MarkerType.POINT) {
            val pointMarker = VSMMarkerPoint(customRID)
            pointMarker.icon = MarkerImage.fromBitmap(markIcon)
            val vsmPosition = VSMMapPoint(
              if (marker.markerPoint != null && marker.markerPoint!!.size > 0)
                marker.markerPoint!![0].longitude else 0.0,
              if (marker.markerPoint != null && marker.markerPoint!!.size > 0)
                marker.markerPoint!![0].latitude else 0.0
            )
            pointMarker.position = vsmPosition
            makerManager.addMarker(pointMarker)
          } else {
            val lineMarker = VSMMarkerPolyline(customRID)
            lineMarker.icon = MarkerImage.fromBitmap(markIcon)
            val vsmPositions: ArrayList<VSMMapPoint> = ArrayList()
            if (marker.markerPoint != null && marker.markerPoint!!.isNotEmpty()) {
              for (point in marker.markerPoint!!) {
                vsmPositions.add(
                  VSMMapPoint(
                    point.longitude, point.latitude,
                  )
                )
              }
              lineMarker.points = vsmPositions
            }
            makerManager.addMarker(lineMarker)
          }
        }
      }
      ConfigMarkerModel.model = null
      navigationFragment.setHitEventListener(onHitObjectListener, null)
    }
  }

  private val onHitObjectListener = object : MapEngine.OnHitObjectListener {
    override fun OnHitObjectPOI(poiName: String?, poiID: Int, vsmPoint: VSMMapPoint?, extras: Bundle?): Boolean {
      return false
    }

    override fun OnHitObjectMarker(vsmMarkerBase: VSMMarkerBase?, extra: Bundle?): Boolean {
      val markerStatus = MarkerStatusModel(
        vsmMarkerBase?.id ?: "",
        if (vsmMarkerBase is VSMMarkerPoint) SelectedMarkerType.POINT else SelectedMarkerType.CALL_OUT,
      )
      MarkerStreamer.success(markerStatus)
      return false
    }

    override fun OnHitObjectOilInfo(name: String, id: Int, point: VSMMapPoint): Boolean {
      return false
    }

    override fun OnHitObjectTraffic(name: String, trafficID: Int, contents: String, iconPath: String, infoSource: String, point: VSMMapPoint): Boolean {
      return false
    }

    override fun OnHitObjectCctv(name: String?, cctvId: Int, point: VSMMapPoint, extras: Bundle?): Boolean {
      return false
    }

    override fun OnHitObjectAlternativeRoute(name: String?, point: VSMMapPoint?): Boolean {
      return false
    }

    override fun OnHitObjectRouteFlag(name: String?, routeFlagID: Int, point: VSMMapPoint?): Boolean {
      return false
    }

    override fun OnHitObjectRouteLine(name: String?, routeLineId: Int, point: VSMMapPoint?): Boolean {
      return false
    }

    override fun OnHitObjectNone(vsmMapPoint: VSMMapPoint?): Boolean {
      return false
    }
  }
}

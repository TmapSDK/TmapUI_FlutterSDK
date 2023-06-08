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
import com.tmapmobility.tmap.tmapsdk.ui.data.CarOption
import com.tmapmobility.tmap.tmapsdk.ui.data.MapSetting
import com.tmapmobility.tmap.tmapsdk.ui.fragment.NavigationFragment
import com.tmapmobility.tmap.tmapsdk.ui.util.TmapUISDK
import io.flutter.embedding.engine.mutatorsstack.FlutterMutatorView
import io.flutter.plugin.platform.PlatformView
import org.json.JSONObject
import java.util.*

class TmapUiSdkView(
  context: Context,
  creationParams: Map<*, *>?,
) : PlatformView {
  private val _context: Context
  private val navigationFragment: NavigationFragment
  private val fragmentContainer: FragmentContainerView
  private val viewId: Int
  private val navigationRequestModel: NavigationRequestModel?

  private val driveStatusChangedListener = object : TmapUISDK.DrivingStatusCallback {
    override fun onStartNavigation() {
      SDKStatusStreamer.success(TmapSDKStatusModel.MAP_INITIALIZING)
    }

    override fun onStopNavigation() {
      SDKStatusStreamer.success(TmapSDKStatusModel.DISMISS_REQ)
    }

    override fun onPermissionDenied(errorCode: Int, errorMsg: String?) {
      SDKStatusStreamer.success(TmapSDKStatusModel.DISMISS_N_REQUEST_PERMISSION)
    }

    override fun onArrivedDestination(destination: String, drivingTime: Int, drivingDistance: Int) {
      DriveStatusStreamer.success(TmapDriveStatusModel.OnArrivedDestination)
    }

    override fun onBreakawayFromRouteEvent() {
      DriveStatusStreamer.success(TmapDriveStatusModel.OnBreakawayFromRouteEvent)
    }

    override fun onApproachingAlternativeRoute() {
      DriveStatusStreamer.success(TmapDriveStatusModel.OnApproachingAlternativeRoute)
    }

    override fun onPassedAlternativeRouteJunction() {
      DriveStatusStreamer.success(TmapDriveStatusModel.OnPassedAlternativeRouteJunction)
    }

    override fun onPeriodicReroute() {
      DriveStatusStreamer.success(TmapDriveStatusModel.OnPeriodicReroute)
    }

    override fun onRouteChanged(index: Int) {
      DriveStatusStreamer.success(TmapDriveStatusModel.OnRouteChanged)
    }

    override fun onForceReroute(periodicType: NddsDataType.DestSearchFlag) {
      DriveStatusStreamer.success(TmapDriveStatusModel.OnForceReroute)
    }

    override fun onNoLocationSignal(noLocationSignal: Boolean) {
      DriveStatusStreamer.success(TmapDriveStatusModel.OnNoLocationSignal)
    }

    override fun onApproachingViaPoint() {
      DriveStatusStreamer.success(TmapDriveStatusModel.OnApproachingViaPoint)
    }

    override fun onPassedViaPoint() {
      DriveStatusStreamer.success(TmapDriveStatusModel.OnPassedViaPoint)
    }

    override fun onChangeRouteOptionComplete(routePlanType: RoutePlanType) {
      DriveStatusStreamer.success(TmapDriveStatusModel.OnChangeRouteOptionComplete)
    }

    override fun onBreakAwayRequestComplete() {
      DriveStatusStreamer.success(TmapDriveStatusModel.OnBreakAwayRequestComplete)
    }

    override fun onPeriodicRerouteComplete() {
      DriveStatusStreamer.success(TmapDriveStatusModel.OnPeriodicRerouteComplete)
    }

    override fun onUserRerouteComplete() {
      DriveStatusStreamer.success(TmapDriveStatusModel.OnUserRerouteComplete)
    }

    override fun onDestinationDirResearchComplete() {
      DriveStatusStreamer.success(TmapDriveStatusModel.OnDestinationDirResearchComplete)
    }

    override fun onDoNotRerouteToDestinationComplete() {}

    override fun onFailRouteRequest(errorCode: String, errorMessage: String) {
      DriveStatusStreamer.success(TmapDriveStatusModel.OnFailRouteRequest)
    }

    override fun onPassedTollgate(fee: Int) {
      DriveStatusStreamer.success(TmapDriveStatusModel.OnPassedTollgate)
    }

    override fun onLocationChanged() {}
  }

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
    navigationFragment.drivingStatusCallback = driveStatusChangedListener
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
    val viewInFragment = navigationFragment.view
    val myParentView = fragmentContainer.parent

    val isFragmentHasView = (viewInFragment != null)
    // flutter 내부에서 전달한 view에 parent로 FlutterMutatorView를 붙이는데
    // 이미 parent가 있으면 exception이 발생한다.
    val isNotMyParentFromFlutter = (myParentView != null && myParentView !is FlutterMutatorView)
    if (isFragmentHasView && // fragment에 view가 생성된 시점에
      isNotMyParentFromFlutter // parent가 flutter에서 붙인 view가 아니라면 parent를 삭제
    ) {
      (fragmentContainer.parent as ViewGroup).removeView(fragmentContainer as ViewGroup)

      val mapSetting: MapSetting? = PreferenceUtils.mapSetting
      if (mapSetting != null) {
        navigationFragment.setSettings(mapSetting)
      }

      if (navigationRequestModel != null) {
        if (navigationRequestModel.safeDriving) {
          navigationFragment.startSafeDrive()
        } else {
          navigationFragment.requestRoute(
            navigationRequestModel.departure,
            navigationRequestModel.wayPoints,
            navigationRequestModel.destination,
            navigationRequestModel.withoutPreview,
            object : TmapUISDK.RouteRequestListener {
              override fun onSuccess() {}
              override fun onFail(errorCode: Int, errorMsg: String?) {}
            }
          )
        }
      }
      setMarker()
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

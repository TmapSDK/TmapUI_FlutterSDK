package com.tmapmobility.tmap.tmapsdk.flutter.tmap_ui_sdk

import android.app.Activity
import android.src.main.kotlin.com.tmapmobility.tmap.tmapsdk.flutter.tmap_ui_sdk.event.DriveGuideStreamer
import android.src.main.kotlin.com.tmapmobility.tmap.tmapsdk.flutter.tmap_ui_sdk.event.DriveStatusStreamer
import android.src.main.kotlin.com.tmapmobility.tmap.tmapsdk.flutter.tmap_ui_sdk.event.MarkerStreamer
import android.src.main.kotlin.com.tmapmobility.tmap.tmapsdk.flutter.tmap_ui_sdk.event.SDKStatusStreamer
import android.src.main.kotlin.com.tmapmobility.tmap.tmapsdk.flutter.tmap_ui_sdk.model.CarOptionModel
import android.src.main.kotlin.com.tmapmobility.tmap.tmapsdk.flutter.tmap_ui_sdk.model.ConfigMarkerModel
import android.src.main.kotlin.com.tmapmobility.tmap.tmapsdk.flutter.tmap_ui_sdk.utils.PreferenceUtils
import com.tmapmobility.tmap.tmapsdk.ui.data.CarOption
import com.tmapmobility.tmap.tmapsdk.ui.util.TmapUISDK
import android.src.main.kotlin.com.tmapmobility.tmap.tmapsdk.flutter.tmap_ui_sdk.TmapUiSdkFactory
import com.tmapmobility.tmap.tmapsdk.ui.data.MapSetting
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import org.json.JSONObject

/** TmapUiSdkPlugin */
class TmapUiSdkPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  companion object {
    private const val CHANNEL_NAME = "com.tmapmobility.tmap.tmapsdk.flutter.tmapuisdk"
    private const val EVENT_CHANNEL_NAME = "$CHANNEL_NAME/event."
  }
  private lateinit var channel : MethodChannel
  private lateinit var marKerEventChannel: EventChannel
  private lateinit var sdkStatusEventChannel: EventChannel
  private lateinit var driveGuideEventChannel: EventChannel
  private lateinit var driveStatusEventChannel: EventChannel
  private lateinit var flutterPluginBinding: FlutterPlugin.FlutterPluginBinding
  private lateinit var activity: Activity

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, CHANNEL_NAME)
    channel.setMethodCallHandler(this)
    marKerEventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "${EVENT_CHANNEL_NAME}markerStatus")
    marKerEventChannel.setStreamHandler(MarkerStreamer())
    sdkStatusEventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "${EVENT_CHANNEL_NAME}sdkStatus")
    sdkStatusEventChannel.setStreamHandler(SDKStatusStreamer())
    driveGuideEventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "${EVENT_CHANNEL_NAME}driveGuide")
    driveGuideEventChannel.setStreamHandler(DriveGuideStreamer())
    driveStatusEventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "${EVENT_CHANNEL_NAME}driveStatus")
    driveStatusEventChannel.setStreamHandler(DriveStatusStreamer())
    this.flutterPluginBinding = flutterPluginBinding
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      "getPlatformVersion" -> {
        result.success("Android ${android.os.Build.VERSION.RELEASE}")
      }
      "initSDK" -> {
        val json = call.argument<String>("args")?.let { JSONObject(it) }
        val clientID = json?.getString("client_id") ?: ""
        val clientApiKey = json?.getString("client_api_key") ?: ""
        val userKey = json?.getString("user_key") ?: ""
        val deviceKey = json?.getString("device_key") ?: ""
        initializeSDK(clientID, clientApiKey, userKey, deviceKey, result)
      }
      "configSDK" -> {
        val carOption: CarOption? =
          call.argument<String>("args")?.let { CarOptionModel.create(it) }
        val mapSetting: MapSetting? =
          call.argument<String>("args")?.let { CarOptionModel.createMapSetting(it) }
        if (carOption == null || mapSetting == null) {
          result.success("false")
        } else {
          PreferenceUtils.carOption = carOption
          PreferenceUtils.mapSetting = mapSetting
          result.success("true")
        }
      }
      "stopDriving" -> {
        TmapUISDK.getFragment().stopDrive()
        result.success("true")
      }
      "toNextViaPointRequest" -> {
        if (TmapUISDK.getFragment().toNextViaPointRequest()) {
          result.success("true")
        } else {
          result.success("false")
        }
      }
      "configMarker" -> {
        call.argument<String>("args")?.let { ConfigMarkerModel.create(it) }
        if (ConfigMarkerModel.model == null) {
          result.success("false")
        } else {
          result.success("true")
        }
      }
      else -> {
        result.notImplemented()
      }
    }
  }

  private fun initializeSDK(clientID: String, clientApiKey: String, userKey: String, deviceKey: String, result: Result) {
    TmapUISDK.initialize(activity, clientID, clientApiKey, userKey, deviceKey,
      object : TmapUISDK.InitializeListener {
        override fun onSuccess() {
          result.success("granted")
        }
        override fun onFail(errorCode: Int, errorMsg: String?) {
          result.success("notGranted")
        }
      })
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
    PreferenceUtils.init(activity)
    flutterPluginBinding
      .platformViewRegistry
      .registerViewFactory(
        "tmapView",
        TmapUiSdkFactory())
  }

  override fun onDetachedFromActivity() {
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    onAttachedToActivity(binding)
  }

  override fun onDetachedFromActivityForConfigChanges() {
    onDetachedFromActivity()
  }
}

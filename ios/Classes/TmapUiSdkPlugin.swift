import Flutter
import UIKit
import Combine
import TmapUISDK
import TmapNaviSDK

enum PluginMethod: String {
    case getVersion = "getPlatformVersion"
    case initSDK = "initSDK"
    case finalizeSDK = "finalizeSDK"
    case configSDK = "configSDK"
    case stopDriving = "stopDriving"
    case toNextViaPointRequest = "toNextViaPointRequest"
    case configMarker = "configMarker"
    case clearContinueDriveInfo = "clearContinueDriveInfo"
}

enum PluginInitType: String {
    case granted = "granted"
    case notGranted = "notGranted"
}

struct TmapUiSdkPluginConstant {
    static public let kMethodChannel = "com.tmapmobility.tmap.tmapsdk.flutter.tmapuisdk"
    static public let kArgs = "args"
}

enum EventChannelName {
    static let driveGuide = "com.tmapmobility.tmap.tmapsdk.flutter.tmapuisdk/event.driveGuide"
    static let driveStatus = "com.tmapmobility.tmap.tmapsdk.flutter.tmapuisdk/event.driveStatus"
    static let sdkStatus = "com.tmapmobility.tmap.tmapsdk.flutter.tmapuisdk/event.sdkStatus"
    static let markerStatus = "com.tmapmobility.tmap.tmapsdk.flutter.tmapuisdk/event.markerStatus"
}

public class TmapUiSdkPlugin: NSObject, FlutterPlugin {
    var authCancelable: Set<AnyCancellable> = []
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: TmapUiSdkPluginConstant.kMethodChannel,
                                         binaryMessenger: registrar.messenger())
        let instance = TmapUiSdkPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
        
        // register platform view
        let factory = TmapViewFactory(messenger: registrar.messenger())
        registrar.register(
          factory,
          withId: "tmapView"
        )
        
        // register event channel
        addPluginEventChannel(with: registrar)
        
    }
    
    public static func addPluginEventChannel(with registrar: FlutterPluginRegistrar) {
        // for event channel - driveGuide
        let driveGuideChannel = FlutterEventChannel(name: EventChannelName.driveGuide,
                                                  binaryMessenger: registrar.messenger())
        driveGuideChannel.setStreamHandler(DriveGuideStreamer.shared)
        
        // for event channel - driveStatus
        let driveStatusChannel = FlutterEventChannel(name: EventChannelName.driveStatus,
                                                  binaryMessenger: registrar.messenger())
        driveStatusChannel.setStreamHandler(DriveStatusStreamer.shared)

        // for event channel - sdkStatus
        let sdkStatusChannel = FlutterEventChannel(name: EventChannelName.sdkStatus,
                                                  binaryMessenger: registrar.messenger())
        sdkStatusChannel.setStreamHandler(SDKStatusStreamer.shared)

        // for event channel - markerStatus
        let markerStatusChannel = FlutterEventChannel(name: EventChannelName.markerStatus,
                                                  binaryMessenger: registrar.messenger())
        markerStatusChannel.setStreamHandler(MarkerStreamer.shared)

    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let methodType = PluginMethod(rawValue: call.method)
        switch methodType {
            case .getVersion:
                result("iOS " + UIDevice.current.systemVersion)
            case .initSDK:
                if let arguments = call.arguments as? [String:Any?],
                   let initJsonString = arguments[TmapUiSdkPluginConstant.kArgs] as? String {
                    initSDK(initParam: initJsonString, result: result)
                } else {
                    result(PluginInitType.notGranted.rawValue)
                }
            case .finalizeSDK:
                finalizeSDK(result: result)
            case .configSDK:
                if let arguments = call.arguments as? [String:Any?],
                   let configJsonString = arguments[TmapUiSdkPluginConstant.kArgs] as? String {
                    configSDK(configParam: configJsonString, result: result)
                } else {
                    result(String(false))
                }
            case .stopDriving:
                stopDriving(result: result)
            case .toNextViaPointRequest:
                toNextViaPointRequest(result: result)
            case .clearContinueDriveInfo:
                clearContinueDriveInfo(result: result)
            case .configMarker:
                if let arguments = call.arguments as? [String:Any?],
                   let configJsonString = arguments[TmapUiSdkPluginConstant.kArgs] as? String {
                    configMarker(configParam: configJsonString, result: result)
                } else {
                    result(String(false))
                }
            default:
                tmapLog("Unknown Method - \(call.method)")
        }
    }
    
    private func initSDK(initParam: String, result: @escaping FlutterResult) {
        let decoder = JSONDecoder()
        guard var initOption = try? decoder.decode(UISDKInitOption.self, from: Data(initParam.utf8)) else {
            result(PluginInitType.notGranted.rawValue)
            return
        }
        initOption.update(uiWindow: UIApplication.shared.windows.first)
        authCancelable.cancelAll()
        
        TmapUISDKManager.shared.stateSubject
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {state in
                switch state {
                case .completed:
                    result(PluginInitType.granted.rawValue)
                case .vsmError, .authError:
                    result(PluginInitType.notGranted.rawValue)
                default:
                    tmapLog("InitSDK....\(state)")
                }
            }).store(in: &authCancelable)
        
        TmapUISDKManager.shared.initSDK(initOption: initOption)
    }
    
    private func finalizeSDK(result: @escaping FlutterResult) {
        authCancelable.cancelAll()
        TmapUISDKManager.shared.finalizeSDK()
        result(String(true))
    }
    
    private func configSDK(configParam: String, result: @escaping FlutterResult) {
        let decoder = JSONDecoder()
        guard var sdkConfig = try? decoder.decode(UISDKConfigOption.self, from: Data(configParam.utf8)) else {
            result(String(false))
            return
        }
        
        sdkConfig.updateMapViewDelegate(delegate: MarkerStreamer.shared)
        MarkerStreamer.shared.setMarkerInfo(config: nil)
        
        TmapUISDKManager.shared.setConfig(config: sdkConfig)
        result(String(true))
    }
    
    private func stopDriving(result: @escaping FlutterResult) {
        TmapUISDKManager.shared.requestStop()
        MarkerStreamer.shared.setMarkerInfo(config: nil)
        result(String(true))
    }
    
    private func clearContinueDriveInfo(result: @escaping FlutterResult) {
        TmapUISDKManager.shared.clearContinueDriveInfo()
        result(String(true))
    }
    
    private func toNextViaPointRequest(result: @escaping FlutterResult) {
        if (TmapUISDKManager.shared.toNextViaPointRequest()) {
            result(String(true))
        } else {
            result(String(false))
        }
    }
    
    private func configMarker(configParam: String, result: @escaping FlutterResult) {
        let decoder = JSONDecoder()
        guard var markerConfig = try? decoder.decode(MarkerConfig.self, from: Data(configParam.utf8)) else {
            result(String(false))
            return
        }
        
        MarkerStreamer.shared.setMarkerInfo(config: markerConfig)
        var sdkConfig = TmapUISDKManager.shared.getConfig()
        sdkConfig.updateMapViewDelegate(delegate: MarkerStreamer.shared)
        TmapUISDKManager.shared.setConfig(config: sdkConfig)
        result(String(true))
    }
}

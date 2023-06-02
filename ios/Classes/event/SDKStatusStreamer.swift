//
//  SDKStatusStreamer.swift
//  tmap_ui_sdk
//
//  Created by 김종일/서비스클라이언트개발 on 2023/04/14.
//


import Foundation
import Flutter
import Combine
import TmapUISDK
import TmapNaviSDK

enum SDKStatusErrorCode {
  static let unavailable = "UNAVAILABLE"
}

@objc public class SDKStatusStreamer: NSObject, FlutterStreamHandler {
    public static let shared = SDKStatusStreamer()

    var sdkStatusCancellable: Set<AnyCancellable> = []

    private var eventSink: FlutterEventSink?
    private var lastStatus: UISDKState? = nil

    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = events
        UIDevice.current.isBatteryMonitoringEnabled = true
        TmapUISDKManager.shared.stateSubject
            .receive(on: DispatchQueue.main, options: nil)
            .sink(receiveValue: { [weak self] (status) in
                self?.sendSDKStatus(sdkStatus: status)
        }).store(in: &sdkStatusCancellable)

        return nil
    }
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        sdkStatusCancellable.cancelAll()
        eventSink = nil
        return nil
    }
    
    private func sendSDKStatus(sdkStatus: UISDKState) {
        guard let eventSink = eventSink else {
            return
        }
        
        switch sdkStatus {
        case .dismissReq, .dismissNRequestPermission:
            // SDK의 종료시 설정되었던 marker들은 초기화한다.
            MarkerStreamer.shared.setMarkerInfo(config: nil)
        default:
            tmapLog("")
        }
        
        // 마지막에 전달한 status와 다른경우만 전달하도록 한다.
        if let lastStatus = self.lastStatus,
           lastStatus != sdkStatus {
            eventSink(sdkStatus.description)
        }
        self.lastStatus = sdkStatus
    }
}

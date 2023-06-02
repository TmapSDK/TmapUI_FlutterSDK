//
//  DriveStatusStreamer.swift
//  tmap_ui_sdk
//
//  Created by 김종일/서비스클라이언트개발 on 2023/04/13.
//

import Foundation
import Flutter
import Combine
import TmapUISDK
import TmapNaviSDK

enum DriveStatusErrorCode {
  static let unavailable = "UNAVAILABLE"
}

@objc public class DriveStatusStreamer: NSObject, FlutterStreamHandler {
    public static let shared = DriveStatusStreamer()

    var driveStatusCancellable: Set<AnyCancellable> = []

    private var eventSink: FlutterEventSink?

    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = events
        UIDevice.current.isBatteryMonitoringEnabled = true
        TmapUISDKManager.shared.driveStatusPublisher
            .receive(on: DispatchQueue.main, options: nil)
            .sink(receiveValue: { [weak self] (status) in
                if let status = status {
                    self?.sendDriveStatus(driveStatus: status)
                }
        }).store(in: &driveStatusCancellable)

        return nil
    }
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        driveStatusCancellable.cancelAll()
        eventSink = nil
        return nil
    }
    
    private func sendDriveStatus(driveStatus: DriveStatus) {
        guard let eventSink = eventSink else {
            return
        }
        
        eventSink(driveStatus.description)
    }
}

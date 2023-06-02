//
//  DriveGuideStreamer.swift
//  tmap_ui_sdk
//
//  Created by 김종일/서비스클라이언트개발 on 2023/04/13.
//

import Foundation
import Flutter
import Combine
import TmapUISDK

enum DriveGuideErrorCode {
  static let unavailable = "UNAVAILABLE"
}

@objc public class DriveGuideStreamer: NSObject, FlutterStreamHandler {
    public static let shared = DriveGuideStreamer()

    var driveGuideCancellable: Set<AnyCancellable> = []

    private var eventSink: FlutterEventSink?

    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = events
        UIDevice.current.isBatteryMonitoringEnabled = true
        TmapUISDKManager.shared.driveGuidePublisher
            .receive(on: DispatchQueue.main, options: nil)
            .sink(receiveValue: { [weak self] (guide) in
                if let guide = guide {
                    self?.sendDriveGuide(driveGuide: guide)
                }
        }).store(in: &driveGuideCancellable)

        return nil
    }
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        driveGuideCancellable.cancelAll()
        eventSink = nil
        return nil
    }
    
    private func sendDriveGuide(driveGuide: TmapDriveGuide) {
        guard let eventSink = eventSink else {
            return
        }
        
        let jsonEncoder = JSONEncoder()
        if let jsonData = try? jsonEncoder.encode(driveGuide) {
            let json = String(data: jsonData, encoding: String.Encoding.utf8)
            eventSink(json)
        } else {
            eventSink(FlutterError(code: DriveGuideErrorCode.unavailable,
                                   message: "Drive Guide unavailable",
                                   details: nil))
        }
    }
}

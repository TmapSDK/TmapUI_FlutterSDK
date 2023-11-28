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

public struct UISDKStateMsg: Encodable {
    /// SDK의 상태를 나타냅니다.
    public var sdkStatus: UISDKState = .none
    /// 상태별 부가 정보를 나타냅니다.
    public var extraData: String = ""
    
    private enum CodingKeys: String, CodingKey {
        case sdkStatus = "sdk_status"
        case extraData = "status_extra_data"
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.sdkStatus.description, forKey: .sdkStatus)
        
        switch self.sdkStatus {
        case let .savedDriveInfo(destinationName):
            try container.encode(destinationName, forKey: .extraData)
        default:
            try container.encode("", forKey: .extraData)
        }
    }
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
            var extraMsg = ""
            switch(sdkStatus) {
            case let .savedDriveInfo(destinationName) :
                extraMsg = destinationName ?? "NA"
            default:
                extraMsg = ""
            }
            
            let sdkStatusMsg = UISDKStateMsg(sdkStatus: sdkStatus, extraData: extraMsg)
            
            let jsonEncoder = JSONEncoder()
            if let jsonData = try? jsonEncoder.encode(sdkStatusMsg) {
                let json = String(data: jsonData, encoding: String.Encoding.utf8)
                eventSink(json)
            } else {
                eventSink(FlutterError(code: SDKStatusErrorCode.unavailable,
                                       message: "SDK Status unavailable",
                                       details: nil))
            }

        }
        
        self.lastStatus = sdkStatus
    }
}

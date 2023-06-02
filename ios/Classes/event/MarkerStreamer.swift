//
//  MarkerStreamer.swift
//  tmap_ui_sdk
//
//  Created by 김종일/서비스클라이언트개발 on 2023/04/17.
//

import Foundation
import Flutter
import Combine
import TmapUISDK
import TmapNaviSDK
import VSMSDK

enum MarkerErrorCode {
  static let unavailable = "UNAVAILABLE"
}

@objc public class MarkerStreamer: NSObject, FlutterStreamHandler {
    public static let shared = MarkerStreamer()

    var sdkStatusCancellable: Set<AnyCancellable> = []

    private var eventSink: FlutterEventSink?
    private var lastStatus: UISDKState? = nil
    private var markerInfo: MarkerConfig? = nil

    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = events

        return nil
    }
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        sdkStatusCancellable.cancelAll()
        eventSink = nil
        return nil
    }
    
    private func markerStatus(sdkStatus: UISDKState) {
        guard let eventSink = eventSink else {
            return
        }
        // 마지막에 전달한 status와 다른경우만 전달하도록 한다.
        if let lastStatus = self.lastStatus,
           lastStatus != sdkStatus {
            eventSink(sdkStatus.description)
        }
        self.lastStatus = sdkStatus
    }
    
    public func setMarkerInfo(config: MarkerConfig?) {
        self.markerInfo = config
    }
}

// MARK: UISDKMapViewDelegate
extension MarkerStreamer: UISDKMapViewDelegate {
    public func viewDidLoad(_ mapView: VSMNavigationView, mapViewType type: MapViewFunctionType) {
        guard let markers = self.markerInfo else {
            tmapLog("MarkerStreamer - Invalid Marker Info. NO custom marker will be set")
            return
        }
        
        self.setMarker(mapView, config: markers)
    }
    
    public func viewWillAppear(_ mapView: VSMNavigationView, mapViewType type: MapViewFunctionType) {
        // do something
    }
    
    public func viewDidAppear(_ mapView: VSMNavigationView, mapViewType type: MapViewFunctionType) {
        // do something
    }
    
    public func viewWillDisappear(_ mapView: VSMNavigationView, mapViewType type: MapViewFunctionType) {
        // do something
    }
    
    public func viewDidDisappear(_ mapView: VSMNavigationView, mapViewType type: MapViewFunctionType) {
        // do something
    }
    
    public func markerSelected(_ marker: VSMMarkerBase, addedMapView mapView: VSMNavigationView, mapViewType type: MapViewFunctionType) -> Bool {
        guard let eventSink = eventSink else {
            return false
        }
        guard let markerId = marker.markerID else { return false }
        guard let targetMarkerId = self.findMarker(with: markerId) else { return false }
        
        sendSelectedMarkerEvent(eventSink: eventSink, markerId: targetMarkerId, markerType: .point)
        
        return true
    }
    
    public func calloutPopupSelected(_ marker: VSMMarkerBase, addedMapView mapView: VSMNavigationView, mapViewType type: MapViewFunctionType) -> Bool {
        guard let eventSink = eventSink else {
            return false
        }
        guard let markerId = marker.markerID else { return false }
        guard let targetMarkerId = self.findMarker(with: markerId) else { return false }

        sendSelectedMarkerEvent(eventSink: eventSink, markerId: targetMarkerId, markerType: .callout)

        return true
    }
    
    private func setMarker(_ mapView: VSMNavigationView, config: MarkerConfig) {
        // point
        let pointMarkers = config.markers.filter( { $0.markerType == .point} )
        self.setPointMarker(mapView, markers: pointMarkers)

        // line
        let lineMarkers = config.markers.filter( { $0.markerType == .line} )
        self.setLineMarker(mapView, markers: lineMarkers)

    }
    
    private func setPointMarker(_ mapView: VSMNavigationView, markers: [Marker]) {
        guard markers.count > 0 else { return }
        for marker in markers {
            if marker.markerType == .point,
               let markerPoint = marker.markerPoint.first,
               let icon = UIImage(contentsOfFile: marker.imageName) {
                let point = VSMMapPoint(longitude: markerPoint.longitude, latitude: markerPoint.latitude)
                let marker = VSMMarkerPoint.customPoiMarker(markerId: marker.markerId, point: point, icon: icon)
                mapView.getMarkerManager().addMarker(marker)
            }
        }
    }
    
    private func setLineMarker(_ mapView: VSMNavigationView, markers: [Marker]) {
        guard markers.count > 0 else { return }
        for marker in markers {
            if marker.markerType == .line,
               marker.markerPoint.count == 2,
               let fromCoord = marker.markerPoint.first,
               let toCoord = marker.markerPoint.last,
               let icon = UIImage(contentsOfFile: marker.imageName) {
                let dash = VSMMarkerPolyline(fromWgs: Coordinate(latitude: fromCoord.latitude, longitude: fromCoord.longitude),
                                             toWgs: Coordinate(latitude: toCoord.latitude, longitude: toCoord.longitude),
                                             image: icon,
                                             markerId: marker.markerId,
                                             renderOrder: .RENDERING_ORDER_BEFORE_POINT_MARKER)
                mapView.getMarkerManager().addMarker(dash)
            }
        }
    }
    
    private func findMarker(with markerId: String) -> String? {
        guard let markers = self.markerInfo?.markers else {
            tmapLog("MarkerStreamer - There is not marker Infos.")
            return nil
        }
        for marker in markers {
            if marker.markerId.compare(markerId) == .orderedSame {
                return marker.markerId
            }
        }
        tmapLog("MarkerStreamer - findMarker - No valid marker Ids (\(markerId))")
        return nil
    }
    
    private func sendSelectedMarkerEvent(eventSink: FlutterEventSink,
                                         markerId: String,
                                         markerType: MarkerType) {
        
        let selectedMarker = SelectedMarker(markerId: markerId, markerType: markerType)
        
        let jsonEncoder = JSONEncoder()
        if let jsonData = try? jsonEncoder.encode(selectedMarker) {
            let json = String(data: jsonData, encoding: String.Encoding.utf8)
            eventSink(json)
        }
    }
}

extension VSMMarkerPoint {
    static func customPoiMarker(markerId: String = "",
                                text: String? = nil,
                                point: VSMMapPoint,
                                icon: UIImage) -> VSMMarkerPoint? {
       let params = VSMMarkerPointParams()
       params.icon = MarkerImage(image: icon)
       params.iconSize = params.icon.image?.size ?? .zero
       params.iconAnchor = CGPoint(x: 0.5, y: 1)
       params.text = text ?? ""
       params.position = point
       params.showPriority = 9999
        return VSMMarkerPoint(id: markerId, params: params)
    }
}

extension VSMMarkerPolyline {
    convenience init?(fromWgs: Coordinate,
                      toWgs: Coordinate,
                      image: UIImage,
                      markerId: String,
                      renderOrder: MarkerRenderOrder = .RENDERING_ORDER_BEFORE_POINT_MARKER) {
        let params = VSMMarkerPolylineParams()
        
        params.icon = MarkerImage(image: image)
        params.points = [VSMMapPoint(longitude: fromWgs.longitude, latitude: fromWgs.latitude), VSMMapPoint(longitude: toWgs.longitude, latitude: toWgs.latitude)]
        params.lineWidth = 3
        params.showPriority = 9999
        params.renderOrder = UInt32(renderOrder.rawValue)
        params.touchable = false
        
        self.init(id: markerId, params: params)
    }
}

//
//  MarkerConfig.swift
//  tmap_ui_sdk
//
//  Created by 김종일/서비스클라이언트개발 on 2023/04/17.
//

import Foundation

public struct MarkerPoint: Decodable {
    public var latitude: Double
    public var longitude: Double
}

public enum MarkerType : String, Codable{
    case point = "point"
    case line = "line"
    case callout = "callout"
}

public struct Marker: Decodable {
    public var markerPoint: [MarkerPoint] = []
    public var markerId: String = ""
    public var imageName: String = ""
    public var markerType: MarkerType = .point
    private enum CodingKeys: String, CodingKey {
        case markerPoint = "marker_point"
        case markerId = "marker_id"
        case imageName = "image_name"
        case markerType = "marker_type"
    }
}

/// Custom Marker설정을 위한 class
public struct MarkerConfig: Decodable {
    public var markers: [Marker] = []
    
    private enum CodingKeys: String, CodingKey {
        case markers = "marker_info"
    }
    public init() {}
}

public struct SelectedMarker: Encodable {
    public var markerId: String = ""
    public var markerType: MarkerType = .point
    private enum CodingKeys: String, CodingKey {
        case markerId = "selected_marker_id"
        case markerType = "selected_marker_type"
    }
}

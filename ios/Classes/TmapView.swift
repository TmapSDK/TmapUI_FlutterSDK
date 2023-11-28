//
//  TmapView.swift
//  tmap_ui_sdk
//
//  Created by 김종일/서비스클라이언트개발 on 2023/04/10.
//

import Flutter
import Foundation
import TmapNaviSDK
import TmapUISDK

extension Point {
    init?(flutterPoint: UISDKRoutePoint?) {
        guard let point = flutterPoint else { return nil }
        self.init(longitude: point.longitude, latitude: point.latitude, name: point.name)
    }
}

public class TmapViewFactory : NSObject, FlutterPlatformViewFactory {
    private let messenger: FlutterBinaryMessenger

    public init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }
    
    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }

    public func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        let tmapView = TmapNativeView(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args,
            binaryMessenger: messenger
        )
        if let nativeView = tmapView,
           let arguments = args as? [String:Any?],
           let initJsonString = arguments[TmapUiSdkPluginConstant.kArgs] as? String {

            let decoder = JSONDecoder()
            if let routeRequestData = try? decoder.decode(UISDKRequestRouteData.self, from: Data(initJsonString.utf8)) {
                if routeRequestData.safeDriving {
                    TmapUISDKManager.shared.requestSafeDrive()
                    return nativeView
                } else if routeRequestData.continueDriving {
                    TmapUISDKManager.shared.continueDrive()
                    return nativeView
                } else if let destination = Point(flutterPoint: routeRequestData.destination) {
                    let origin = Point(flutterPoint: routeRequestData.source)
                    let wayPoints = routeRequestData.wayPoints?.map({ Point(flutterPoint: $0) }).compactMap { $0 } ?? []
                    let options = routeRequestData.options ?? [.recommend, .shortest]
                    
                    TmapUISDKManager.shared.requestRoute(origin: origin,
                                                         destination: destination,
                                                         routeOption: options,
                                                         wayPoints: wayPoints,
                                                         guideWithoutPreview: routeRequestData.guideWithoutPreview)
                    return nativeView
                }
            }

        }
        // blank view
        return BlankView(frame, viewId: viewId, args: args)
    }
}

public class TmapNativeView : NSObject, FlutterPlatformView {
    private var _viewController: UIViewController

    init?(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger
    ) {
        guard let vc = TmapUISDKManager.shared.getViewController() else { return nil }
        _viewController = UIViewController(nibName: nil, bundle: nil)
        super.init()

        _viewController = vc
        _viewController.view.frame = frame
    }

    public func view() -> UIView {
        return _viewController.view
    }
}

public class BlankView: NSObject, FlutterPlatformView {
    let frame: CGRect
    let viewId: Int64
    
    init(_ frame: CGRect, viewId: Int64, args: Any?) {
        self.frame = frame
        self.viewId = viewId
    }
    
    public func view() -> UIView {
        let view = UIView(frame: frame)
        view.backgroundColor = .red
        return view
    }
}

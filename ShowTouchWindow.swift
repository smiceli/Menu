//
//  ShowTouchWindow.swift
//  Menu
//
//  Created by Sean Miceli on 3/6/16.
//  Copyright © 2016 smiceli. All rights reserved.
//

import UIKit


class ShowTouchWindow: UIWindow {

    var touchToLayerMap = [UITouch: CALayer]()

    override func sendEvent(event: UIEvent) {
        super.sendEvent(event)

        if event.type != .Touches {
            return
        }

        guard let touches = event.allTouches() else { return }

        for touch in touches {
            switch touch.phase {
            case .Began:
                let touchLayer = touchImageLayer()
                layer.addSublayer(touchLayer)
                touchLayer.position = touch.locationInView(self)
                touchToLayerMap[touch] = touchLayer

            case .Moved:
                let layer = touchToLayerMap[touch]
                layer?.position = touch.locationInView(self)

            case .Ended, .Cancelled:
                let layer = touchToLayerMap[touch]
                layer?.removeFromSuperlayer()
                touchToLayerMap[touch] = nil

            default:
                break
            }
        }
    }

    private func touchImageLayer() -> CALayer {
        let layer = CALayer()
        layer.backgroundColor = UIColor.grayColor().CGColor
        layer.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        layer.cornerRadius = 22
        layer.borderColor = UIColor.whiteColor().CGColor
        layer.borderWidth = 1.0
        return layer
    }
}

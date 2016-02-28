//
//  MenuView.swift
//  Menu
//
//  Created by Sean Miceli on 2/20/16.
//  Copyright © 2016 smiceli. All rights reserved.
//

import UIKit

class TransparentScrollView: UIScrollView {
    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, withEvent: event)
        if hitView == self {
            return nil
        }
        return hitView
    }
}

class MenuView: UIView, UIScrollViewDelegate {

    var panGestureRecognizer: UIGestureRecognizer {
        get {
            return scrollView.panGestureRecognizer
        }
    }

    private lazy var scrollView: UIScrollView = {
        let scrollView = TransparentScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self
        return scrollView
    }()

    private lazy var menuContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var spacing: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var  rightMarginView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func willMoveToSuperview(newSuperview: UIView?) {
        if newSuperview == nil { return }
        setupSubviews()
    }

    private func setupSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(spacing)
        scrollView.addSubview(menuContentView)
        scrollView.addSubview(rightMarginView)

        menuContentView.backgroundColor = UIColor(hue: CGFloat(drand48()), saturation: 1.0, brightness: 1.0, alpha: 1.0)
        rightMarginView.backgroundColor = menuContentView.backgroundColor
    }

    override func updateConstraints() {
        super.updateConstraints()
        positionScrollView()
        positionSpacingView()
        positionMenuContentView()
        positionRightMarginView()
    }

    private func positionScrollView() {
        scrollView.constrainToSuperview()
    }

    private func positionSpacingView() {
        spacing.constrain(.Top, toView: scrollView)
        spacing.constrain(.Left, toView: scrollView)
        spacing.constrain(.Bottom, toView: scrollView)
        spacing.constrain(.Width, toView: self)
    }
    
    private func positionMenuContentView() {
        menuContentView.constrain(.Top, toView: spacing)
        menuContentView.constrain(.Bottom, toView: spacing)
        menuContentView.constrain(.Right, toView: scrollView)
        menuContentView.constrain(.Height, toView: self)
        menuContentView.constrain(.Width, toView: self, multiplier: 0.3)
        menuContentView.constrain(.Left, toView: spacing, toAttr: .Right)
    }

    private func positionRightMarginView() {
        rightMarginView.constrain(.Top, toView: menuContentView)
        rightMarginView.constrain(.Bottom, toView: menuContentView)
        rightMarginView.constrain(.Left, toView: menuContentView, toAttr: .Right)
        rightMarginView.constrain(.Width, toView: self)
    }

    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let left = abs(targetContentOffset.memory.x)
        let right = abs(targetContentOffset.memory.x - menuContentView.bounds.width)

        if left < right {
            targetContentOffset.memory.x = 0
        }
        else {
            targetContentOffset.memory.x = menuContentView.bounds.width
        }
    }

    override func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
        return false
    }
}

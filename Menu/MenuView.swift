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

    private var isMenuShowing = false
    private lazy var viewTappedRecognizer: UIGestureRecognizer = {
        return UITapGestureRecognizer(target: self, action: Selector("viewTapped"))
    }()

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

    private lazy var dimView: UIView = {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .Dark))
        view.alpha = 0
        return view
    }()

    override func willMoveToSuperview(newSuperview: UIView?) {
        if newSuperview == nil { return }
        setupSubviews()
    }

    private func setupSubviews() {
        addSubview(dimView)
        addSubview(scrollView)
        scrollView.addSubview(spacing)
        scrollView.addSubview(menuContentView)
        scrollView.addSubview(rightMarginView)

        menuContentView.backgroundColor = UIColor(hue: CGFloat(drand48()), saturation: 1.0, brightness: 1.0, alpha: 1.0)
        rightMarginView.backgroundColor = menuContentView.backgroundColor

        addGestureRecognizer(viewTappedRecognizer)
    }

    override func updateConstraints() {
        super.updateConstraints()
        dimView.constrainToSuperview()
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

    func scrollViewDidScroll(scrollView: UIScrollView) {
        var alpha = scrollView.contentOffset.x / menuContentView.bounds.width
        if alpha < 0 { alpha = 0 }
        else if alpha > 1 { alpha = 1 }
        dimView.alpha = alpha

        isMenuShowing = scrollView.contentOffset.x >= menuContentView.bounds.width
        viewTappedRecognizer.enabled = isMenuShowing
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

    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        if scrollView.contentOffset.x < menuContentView.bounds.width {
            scrollView.setContentOffset(CGPoint.zero, animated: true)
        }
        else {
            scrollView.setContentOffset(CGPoint(x: menuContentView.bounds.width, y: 0), animated: true)
        }
    }

    override func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
        return isMenuShowing
    }

    @objc private func viewTapped() {
        scrollView.setContentOffset(CGPoint.zero, animated: true)
    }
}

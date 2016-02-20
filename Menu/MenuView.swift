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
        NSLayoutConstraint.activateConstraints([
            NSLayoutConstraint(item: scrollView, attribute: .Top, relatedBy: .Equal
                , toItem: self, attribute: .Top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: scrollView, attribute: .Bottom, relatedBy: .Equal
                , toItem: self, attribute: .Bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: scrollView, attribute: .Left, relatedBy: .Equal
                , toItem: self, attribute: .Left, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: scrollView, attribute: .Width, relatedBy: .Equal
                , toItem: self, attribute: .Width, multiplier: 1.0, constant: 0),
        ])
    }

    private func positionSpacingView() {
        NSLayoutConstraint.activateConstraints([
            NSLayoutConstraint(item: spacing, attribute: .Top, relatedBy: .Equal
                , toItem: scrollView, attribute: .Top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: spacing, attribute: .Bottom, relatedBy: .Equal
                , toItem: scrollView, attribute: .Bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: spacing, attribute: .Left, relatedBy: .Equal
                , toItem: scrollView, attribute: .Left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: spacing, attribute: .Width, relatedBy: .Equal
                , toItem: self, attribute: .Width, multiplier: 1, constant: 0),
            ])
    }
    
    private func positionMenuContentView() {
        NSLayoutConstraint.activateConstraints([
            NSLayoutConstraint(item: menuContentView, attribute: .Top, relatedBy: .Equal
                , toItem: spacing, attribute: .Top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: menuContentView, attribute: .Bottom, relatedBy: .Equal
                , toItem: spacing, attribute: .Bottom, multiplier: 1, constant: 0),

            NSLayoutConstraint(item: menuContentView, attribute: .Left, relatedBy: .Equal
                , toItem: spacing, attribute: .Right, multiplier: 1, constant: 0),

            NSLayoutConstraint(item: menuContentView, attribute: .Right, relatedBy: .Equal
                , toItem: scrollView, attribute: .Right, multiplier: 1, constant: 0),

            NSLayoutConstraint(item: menuContentView, attribute: .Width, relatedBy: .Equal
                , toItem: self, attribute: .Width, multiplier: 0.3, constant: 0),
            NSLayoutConstraint(item: menuContentView, attribute: .Height, relatedBy: .Equal
                , toItem: self, attribute: .Height, multiplier: 1, constant: 0),
        ])
    }

    private func positionRightMarginView() {
        NSLayoutConstraint.activateConstraints([
            NSLayoutConstraint(item: rightMarginView, attribute: .Top, relatedBy: .Equal
                , toItem: menuContentView, attribute: .Top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: rightMarginView, attribute: .Bottom, relatedBy: .Equal
                , toItem: menuContentView, attribute: .Bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: rightMarginView, attribute: .Left, relatedBy: .Equal
                , toItem: menuContentView, attribute: .Right, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: rightMarginView, attribute: .Width, relatedBy: .Equal
                , toItem: self, attribute: .Width, multiplier: 1, constant: 0),
        ])
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

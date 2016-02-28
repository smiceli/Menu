//
//  UIViewExtension.swift
//  Menu
//
//  Created by Sean Miceli on 2/28/16.
//  Copyright © 2016 smiceli. All rights reserved.
//

import UIKit

extension UIView {

    func constrainToSuperview() {
        constrain(.Top, toView: superview!)
        constrain(.Left, toView: superview!)
        constrain(.Right, toView: superview!)
        constrain(.Bottom, toView: superview!)
    }

    func constrainToSuperviewMargins() {
        constrain(.TopMargin, toView: superview!)
        constrain(.LeftMargin, toView: superview!)
        constrain(.RightMargin, toView: superview!)
        constrain(.BottomMargin, toView: superview!)
    }

    func constrain(attribute: NSLayoutAttribute, toView: UIView, priority: UILayoutPriority = UILayoutPriorityRequired, multiplier: CGFloat = 1.0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        toView.translatesAutoresizingMaskIntoConstraints = false
        let c = NSLayoutConstraint(item: self, attribute: attribute, relatedBy: .Equal, toItem: toView, attribute: attribute, multiplier: multiplier, constant: 0)
        c.priority = priority
        NSLayoutConstraint.activateConstraints([c])
        return c
    }

    func constrain(attribute: NSLayoutAttribute, toView: UIView, toAttr: NSLayoutAttribute, priority: UILayoutPriority = UILayoutPriorityRequired, multiplier: CGFloat = 1.0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        toView.translatesAutoresizingMaskIntoConstraints = false
        let c = NSLayoutConstraint(item: self, attribute: attribute, relatedBy: .Equal, toItem: toView, attribute: toAttr, multiplier: multiplier, constant: 0)
        c.priority = priority
        NSLayoutConstraint.activateConstraints([c])
        return c
    }

    func constrain(attribute: NSLayoutAttribute, _ constant: CGFloat, priority: UILayoutPriority = UILayoutPriorityRequired) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let c = NSLayoutConstraint(item: self, attribute: attribute, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: constant)
        c.priority = priority
        NSLayoutConstraint.activateConstraints([c])
        return c
    }
}

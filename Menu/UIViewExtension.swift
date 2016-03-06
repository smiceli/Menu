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
        constrain(.Top, toView: superview!, toAttr: .TopMargin)
        constrain(.Left, toView: superview!, toAttr: .LeftMargin)
        constrain(.Right, toView: superview!, toAttr: .RightMargin)
        constrain(.Bottom, toView: superview!, toAttr: .BottomMargin)
    }

    func constrain(attribute: NSLayoutAttribute, toView: UIView, priority: UILayoutPriority = UILayoutPriorityRequired, multiplier: CGFloat = 1.0, constant: CGFloat = 0) -> NSLayoutConstraint {
        return constrain(attribute, toView: toView, toAttr: attribute, priority: priority, multiplier: multiplier, constant: constant)
    }

    func constrain(attributes: [NSLayoutAttribute], toView: UIView, priority: UILayoutPriority = UILayoutPriorityRequired, multiplier: CGFloat = 1.0, constant: CGFloat = 0) -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()

        for a in attributes {
            constraints.append(constrain(a, toView: toView, toAttr: a, priority: priority, multiplier: multiplier, constant: constant))
        }

        return constraints
    }

    func constrain(attribute: NSLayoutAttribute, toView: UIView, toAttr: NSLayoutAttribute, priority: UILayoutPriority = UILayoutPriorityRequired, multiplier: CGFloat = 1.0, constant: CGFloat = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        toView.translatesAutoresizingMaskIntoConstraints = false
        let c = NSLayoutConstraint(item: self, attribute: attribute, relatedBy: .Equal, toItem: toView, attribute: toAttr, multiplier: multiplier, constant: constant)
        c.priority = priority
        NSLayoutConstraint.activateConstraints([c])
        return c
    }

    func constrain(attributes: [NSLayoutAttribute], _ constant: CGFloat, priority: UILayoutPriority = UILayoutPriorityRequired) -> [NSLayoutConstraint] {
        var constraints = [NSLayoutConstraint]()

        for a in attributes {
            constraints.append(constrain(a, constant, priority: priority))
        }

        return constraints
    }

    func constrain(attribute: NSLayoutAttribute, _ constant: CGFloat, priority: UILayoutPriority = UILayoutPriorityRequired) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let c = NSLayoutConstraint(item: self, attribute: attribute, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: constant)
        c.priority = priority
        NSLayoutConstraint.activateConstraints([c])
        return c
    }
}

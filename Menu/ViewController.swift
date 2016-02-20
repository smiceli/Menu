//
//  ViewController.swift
//  Menu
//
//  Created by Sean Miceli on 2/20/16.
//  Copyright © 2016 smiceli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private lazy var menuView: MenuView = {
        let menuView = MenuView()
        menuView.translatesAutoresizingMaskIntoConstraints = false
        return menuView
    }()

    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("tap here", forState: .Normal)
        button.setTitleColor(UIColor.blackColor(), forState: .Normal)
        button.addTarget(self, action: Selector("buttonTapped"), forControlEvents: .TouchUpInside)
        button.layer.borderColor = UIColor.blackColor().CGColor
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 8.0
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        view.addSubview(menuView)
        layoutButton()
        layoutMenuView()

        view.addGestureRecognizer(menuView.panGestureRecognizer)
        menuView.panGestureRecognizer.delaysTouchesBegan = true
    }

    private func layoutButton() {
        NSLayoutConstraint.activateConstraints([
            NSLayoutConstraint(item: button, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: button, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .CenterY, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: button, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 100),
            NSLayoutConstraint(item: button, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 50),
        ])
    }

    private func layoutMenuView() {
        NSLayoutConstraint.activateConstraints([
            NSLayoutConstraint(item: menuView, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: menuView, attribute: .Left, relatedBy: .Equal, toItem: view, attribute: .Left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: menuView, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: menuView, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: 1, constant: 0),
        ])
    }

    @objc private func buttonTapped() {
        let alert = UIAlertController(title: "Howdy", message: "The button was pressed", preferredStyle: .Alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))

        presentViewController(alert, animated: true, completion: nil)
    }

}


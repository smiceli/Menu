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
        button.setTitle("tap here", forState: .Normal)
        button.setTitleColor(UIColor.blackColor(), forState: .Normal)
        button.addTarget(self, action: Selector("buttonTapped"), forControlEvents: .TouchUpInside)
        button.layer.borderColor = UIColor.blackColor().CGColor
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 8.0
        button.backgroundColor = UIColor(hue: CGFloat(drand48()), saturation: 1, brightness: 1, alpha: 1)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(button)
        view.addSubview(menuView)
        layoutButton()
        layoutMenuView()

        view.addGestureRecognizer(menuView.panGestureRecognizer)
        menuView.panGestureRecognizer.delaysTouchesBegan = true
    }

    private func layoutButton() {
        button.constrain(.CenterX, toView: view)
        button.constrain(.CenterY, toView: view)
        button.constrain(.Width, 100)
        button.constrain(.Height, 50)
    }

    private func layoutMenuView() {
        menuView.constrainToSuperview()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        button.layer.cornerRadius = button.bounds.height/2.0
    }

    @objc private func buttonTapped() {
        let alert = UIAlertController(title: "Howdy", message: "The button was pressed", preferredStyle: .Alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))

        presentViewController(alert, animated: true, completion: nil)
    }

}


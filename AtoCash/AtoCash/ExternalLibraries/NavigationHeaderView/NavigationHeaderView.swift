//
//  NavigationHeaderView.swift
//  AtoCash
//
//  Created by user on 13/03/21.
//

import Foundation
import UIKit
enum BarButtonItemPosition {
    case right, left
}

enum BarButtonItemType {
    case menu(BarButtonItemPosition)
    case user(BarButtonItemPosition)
    case notification(BarButtonItemPosition)
}

/// Has default implementation on UIViewControllers that conform to BarButtonActions.
protocol BarButtonItemConfiguration: class {

    func addBarButtonItem(ofType type: BarButtonItemType)
    func addBarButtonItem2(ofType type: BarButtonItemType, type1 : BarButtonItemType)
}

/// Hate that we're forced to expose button targets to objc runtime :(
/// but I don't know any other way for the time being, maybe in Swift 6 :)
@objc protocol BarButtonActions {
    @objc func presentLeftMenu(_ sender:AnyObject)
    @objc func dismissController(_ sender:UIBarButtonItem)
    @objc func showNotification(_ sender:AnyObject)
}

extension BarButtonItemConfiguration where Self: UIViewController, Self: BarButtonActions {

    func addBarButtonItem(ofType type: BarButtonItemType) {

        func newButton(imageName: String, position: BarButtonItemPosition, action: Selector?) {
            let button = UIBarButtonItem(image: UIImage(named: imageName), style: .plain, target: self, action: action)
            button.tintColor = UIColor.white
            switch position {
            case .left: self.navigationItem.leftBarButtonItem = button
            case .right: self.navigationItem.rightBarButtonItem = button
            }
        }

        switch type {
        case .menu(let p): newButton(imageName: "Menu", position: p, action: #selector(Self.presentLeftMenu(_:)))
        case .notification(let p): newButton(imageName: "Notification", position: p, action: #selector(Self.showNotification(_:)))
        case .user(let p): newButton(imageName: "logout", position: p, action: #selector(Self.dismissController(_:)))
        }
    }
    
    func addBarButtonItem2(ofType type: BarButtonItemType, type1 : BarButtonItemType) {
        
        var array = [UIBarButtonItem]()
        func newButton(imageName: String, position: BarButtonItemPosition, action: Selector?) {
            let button = UIBarButtonItem(image: UIImage(named: imageName), style: .plain, target: self, action: action)
            button.tintColor = UIColor.white
            array.append(button)
            if array.count == 2{
            switch position {
            case .left: self.navigationItem.leftBarButtonItem = button
            case .right: self.navigationItem.rightBarButtonItems = array
            }
            }
        }

        switch type {
        case .menu(let p): newButton(imageName: "Menu", position: p, action: #selector(Self.presentLeftMenu(_:)))
        case .notification(let p): newButton(imageName: "Notification", position: p, action: #selector(Self.showNotification(_:)))
        case .user(let p): newButton(imageName: "logout", position: p, action: #selector(Self.dismissController(_:)))
        }
        switch type1 {
        case .menu(let p): newButton(imageName: "Menu", position: p, action: #selector(Self.presentLeftMenu(_:)))
        case .notification(let p): newButton(imageName: "Notification", position: p, action: #selector(Self.showNotification(_:)))
        case .user(let p): newButton(imageName: "logout", position: p, action: #selector(Self.dismissController(_:)))
        }
        
    }
}

/// Conform to this in subclasses of UIViewController and implement BarButtonActions (its impl. differs from vc to vc).
protocol BarButtonConfigarable: BarButtonItemConfiguration, BarButtonActions {}

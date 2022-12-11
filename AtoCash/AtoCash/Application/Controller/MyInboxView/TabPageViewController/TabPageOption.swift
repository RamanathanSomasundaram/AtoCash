//
//  TabPageOption.swift
//  TabPageViewController
//
//  Created by EndouMari on 2016/02/24.
//  Copyright © 2016年 EndouMari. All rights reserved.
//

import UIKit

public struct TabPageOption {

    public init() {}

    public var fontSize = UIFont.systemFontSize
    public var currentColor = UIColor.green
    public var currentTextColor = UIColor.white
    public var defaultColor = UIColor.blue
    public var tabHeight: CGFloat = 30.0
    public var tabMargin: CGFloat = 20.0
    public var tabWidth: CGFloat?
    public var currentBarHeight: CGFloat = 0.0 // underline height for  focus
    public var tabBackgroundColor: UIColor = .white
    public var pageBackgoundColor: UIColor = UIColor.white
    public var isTranslucent: Bool = true
    public var hidesTabBarOnSwipe: Bool = false

    internal var tabBarAlpha: CGFloat {
        return isTranslucent ? 1.0 : 1.0
    }
    internal var tabBackgroundImage: UIImage {
        return convertImage()
    }

    fileprivate func convertImage() -> UIImage {
        let rect : CGRect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context : CGContext? = UIGraphicsGetCurrentContext()
        let backgroundColor = tabBackgroundColor.withAlphaComponent(tabBarAlpha).cgColor
        context?.setFillColor(backgroundColor)
        context?.fill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}

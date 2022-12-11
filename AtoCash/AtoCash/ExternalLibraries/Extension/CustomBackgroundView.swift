//
//  CustomBackgroundView.swift
//  vPlay
//
//  Created by user on 12/01/21.
//  Copyright © 2021 user. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore
extension UIView {
    
    @objc enum Direction: Int {
        case topToBottom = 0
        case bottomToTop
        case leftToRight
        case rightToLeft
    }
    
    func applyGradient(colors: [Any]?, locations: [NSNumber]? = [0.0, 1.0], direction: Direction = .leftToRight) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = colors
        gradientLayer.locations = locations
        
        switch direction {
        case .topToBottom:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
            
        case .bottomToTop:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
            
        case .leftToRight:
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
            
        case .rightToLeft:
            gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
        }
        //self.layer.addSublayer(gradientLayer)
        self.layer.insertSublayer(gradientLayer, at: 0)

    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11.0, *) {
            clipsToBounds = true
            layer.cornerRadius = radius
            layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
        } else {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    }
}

extension UIColor{
    // Convert HEX to RGB
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
}
@available(*, unavailable, message: "Only use it at Storybord or Xib.", renamed: "UIImageView")
@IBDesignable class GradientImageBackgroundView: UIImageView {
    
    var direction: Direction = .leftToRight
    
    @IBInspectable var bottomcolor: UIColor {
        get{
            return  UIColor.init(hex: "C91ABA")
        }
        set{
            self.applyGradient(colors: [topcolor.cgColor, newValue.cgColor],
                                            locations: [0.0, 1.0],
                                            direction: direction)
        }
    }
    
    @IBInspectable var topcolor: UIColor {
        get{
            return UIColor.init(hex: "842CEB")
        }
        set{
            self.applyGradient(colors: [newValue.cgColor, bottomcolor.cgColor],
                                            locations: [0.0, 1.0],
                                            direction: direction)
        }
    }
   
    
    @IBInspectable var topToBottom: Bool = false
    @IBInspectable var bottomToTop: Bool = false
    @IBInspectable var leftToRight: Bool = false
    @IBInspectable var rightToLeft: Bool = false
    
    override func layoutSubviews() {

        
        if topToBottom {
            direction = .topToBottom
        }
        else if bottomToTop {
            direction = .bottomToTop
        }
        else if leftToRight {
            direction = .leftToRight
        }
        else if rightToLeft {
            direction = .rightToLeft
        }
        
        self.applyGradient(colors: [topcolor.cgColor, bottomcolor.cgColor],
                                        locations: [0.0, 1.0],
                                        direction: direction)
        self.layer.masksToBounds = true
    }
}

@IBDesignable class GradientBackgroundView: UIView {
    
    var direction: Direction = .leftToRight
    
    @IBInspectable var bottomcolor: UIColor {
        get{
            return  UIColor.init(hex: "C91ABA")
        }
        set{
            self.applyGradient(colors: [topcolor.cgColor, newValue.cgColor],
                                            locations: [0.0, 1.0],
                                            direction: direction)
        }
    }
    
    @IBInspectable var topcolor: UIColor {
        get{
            return UIColor.init(hex: "842CEB")
        }
        set{
            self.applyGradient(colors: [newValue.cgColor, bottomcolor.cgColor],
                                            locations: [0.0, 1.0],
                                            direction: direction)
        }
    }
   
    
    @IBInspectable var topToBottom: Bool = false
    @IBInspectable var bottomToTop: Bool = false
    @IBInspectable var leftToRight: Bool = false
    @IBInspectable var rightToLeft: Bool = false
    
    override func layoutSubviews() {

        
        if topToBottom {
            direction = .topToBottom
        }
        else if bottomToTop {
            direction = .bottomToTop
        }
        else if leftToRight {
            direction = .leftToRight
        }
        else if rightToLeft {
            direction = .rightToLeft
        }
        
        self.applyGradient(colors: [topcolor.cgColor, bottomcolor.cgColor],
                                        locations: [0.0, 1.0],
                                        direction: direction)
        self.layer.masksToBounds = true
    }
}

@IBDesignable class GradientCardView: UIView {
    @IBInspectable var startColor:     UIColor = UIColor.init(hex: "2C3035") { didSet { updateColors() }}
    @IBInspectable var endColor:   UIColor = UIColor.init(hex: "181B1E") { didSet { updateColors() }}
    
    @IBInspectable var startLocation: Double =   0.05 { didSet { updateLocations() }}
    @IBInspectable var endLocation:   Double =   0.95 { didSet { updateLocations() }}
    @IBInspectable var horizontalMode:  Bool =  false { didSet { updatePoints() }}
    @IBInspectable var diagonalMode:    Bool =  false { didSet { updatePoints() }}
    

    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 5
    @IBInspectable var shadowColor: UIColor? = UIColor.white
    @IBInspectable var shadowOpacity: Float = 0.45

    override public func layoutSubviews() {

        layer.cornerRadius = 10
        let shadowPath = UIBezierPath(roundedRect: CGRect(x: -8,
                                                          y: -13,
                                                          width: self.frame.size.width,
                                                          height: self.frame.size.height), cornerRadius: 10)
        layer.masksToBounds = false
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
    }

    override public class var layerClass: AnyClass { CAGradientLayer.self }

    var gradientLayer: CAGradientLayer { layer as! CAGradientLayer }

    func updatePoints() {
        if horizontalMode {
            gradientLayer.startPoint = diagonalMode ? .init(x: 1, y: 0) : .init(x: 0, y: 0.5)
            gradientLayer.endPoint   = diagonalMode ? .init(x: 0, y: 1) : .init(x: 1, y: 0.5)
        } else {
            gradientLayer.startPoint = diagonalMode ? .init(x: 0, y: 0) : .init(x: 0.5, y: 0)
            gradientLayer.endPoint   = diagonalMode ? .init(x: 1, y: 1) : .init(x: 0.5, y: 1)
        }
    }
    func updateLocations() {
        gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
    }
    func updateColors() {
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }
    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updatePoints()
        updateLocations()
        updateColors()
    }
}
////// Story board Extra Feature for create border radius, border width and border Color
//extension UIView {
//    /// corner radius
//    @IBInspectable var borderColor: UIColor? {
//        set {
//            layer.borderColor = newValue!.cgColor
//        }
//        get {
//            if let color = layer.borderColor {
//                return UIColor(cgColor: color)
//            } else {
//                return nil
//            }
//        }
//    }
//    @IBInspectable var borderWidth: CGFloat {
//        set {
//            layer.borderWidth = newValue
//        }
//        get {
//            return layer.borderWidth
//        }
//    }
//    @IBInspectable var cornerRadius: CGFloat {
//        set {
//            layer.cornerRadius = newValue
//            clipsToBounds = newValue > 0
//        }
//        get {
//            return layer.cornerRadius
//        }
//    }
//}

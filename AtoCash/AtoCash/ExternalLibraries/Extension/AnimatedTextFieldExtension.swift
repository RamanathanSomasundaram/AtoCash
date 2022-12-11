//
//  AnimatedTextFieldExtension.swift
//  AtoCash
//
//  Created by user on 06/04/21.
//

import Foundation
import UIKit


class CSCustomView: UIView {
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 2
    @IBInspectable var shadowColor: UIColor? = UIColor.lightGray
    @IBInspectable var shadowOpacity: Float = 01.0
    override func layoutSubviews() {
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        layer.cornerRadius = self.frame.size.height / 2
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.darkGray.withAlphaComponent(0.6).cgColor
        #if os(tvOS)
           layer.shouldRasterize = true
        #endif
    }
}
class CSCustomViewCell: UIView {
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 2
    @IBInspectable var shadowColor: UIColor? = UIColor.lightGray
    @IBInspectable var shadowOpacity: Float = 01.0
    override func layoutSubviews() {
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        layer.cornerRadius = 10
        #if os(tvOS)
           layer.shouldRasterize = true
        #endif
    }
}

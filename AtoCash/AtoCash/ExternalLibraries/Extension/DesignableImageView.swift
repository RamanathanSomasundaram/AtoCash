//
//  DesignableImageView.swift
//  Ejaar
//
//  Created by user on 10/01/21.
//  Copyright © 2021 LKB-L-115. All rights reserved.
//

import Foundation
import UIKit
@available(*, unavailable, message: "Only use it at Storybord or Xib.", renamed: "UIImageView")
@IBDesignable final class DesignableImageView: UIImageView, Roundable, Borderable {

    var cornerRadiusValue : CGFloat = 0
    var corners : UIRectCorner = []

    @IBInspectable public var topLeft : Bool {
            get {
                return corners.contains(.topLeft)
            }
            set {
                setCorner(newValue: newValue, for: .topLeft)
            }
        }

        @IBInspectable public var topRight : Bool {
            get {
                return corners.contains(.topRight)
            }
            set {
                setCorner(newValue: newValue, for: .topRight)
            }
        }

        @IBInspectable public var bottomLeft : Bool {
            get {
                return corners.contains(.bottomLeft)
            }
            set {
                setCorner(newValue: newValue, for: .bottomLeft)
            }
        }

        @IBInspectable public var bottomRight : Bool {
            get {
                return corners.contains(.bottomRight)
            }
            set {
                setCorner(newValue: newValue, for: .bottomRight)
            }
        }

        func setCorner(newValue: Bool, for corner: UIRectCorner) {
            if newValue {
                addRectCorner(corner: corner)
            } else {
                removeRectCorner(corner: corner)
            }
        }

        func addRectCorner(corner: UIRectCorner) {
            corners.insert(corner)
            updateCorners()
        }

        func removeRectCorner(corner: UIRectCorner) {
            if corners.contains(corner) {
                corners.remove(corner)
                updateCorners()
            }
        }

        func updateCorners() {
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: cornerRadiusValue, height: cornerRadiusValue))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
}

@available(*, unavailable, message: "Only use it at Storybord or Xib.", renamed: "UIImageView")
@IBDesignable final class DesignableRoundImageView: UIImageView, Borderable {
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.width / 2
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        layer.cornerRadius = frame.width / 2
    }
}

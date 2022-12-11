//
//  UIView+Extension.swift
//  SpaceNetGameshop
//
//  Created by LKB-L-115 on 15/04/20.
//  Copyright © 2020 LKB-L-115. All rights reserved.
//

import Foundation
import UIKit

extension UISegmentedControl {
@IBInspectable var textSelectedColor: UIColor {
    get {
        return self.textSelectedColor
    }
    set {
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: newValue], for: .selected)
    }
}

@IBInspectable var textNormalColor: UIColor {
    get {
        return self.textNormalColor
    }
    set {
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: newValue], for: .normal)
    }
}}

//shake animation: http://stackoverflow.com/questions/27987048/shake-animation-for-uitextfield-uiview-in-swift
public extension UIView {

    func shake(count : Float? = nil,for duration : TimeInterval? = nil,withTanslation translation : Float? = nil) {
    let animation : CABasicAnimation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: .linear)

    animation.repeatCount = count ?? 2
    animation.duration = (duration ?? 0.5)/TimeInterval(animation.repeatCount)
    animation.autoreverses = true
    animation.byValue = translation ?? -5
    layer.add(animation, forKey: "shake")
    }
}

//rotate: https://www.andrewcbancroft.com/2014/10/15/rotate-animation-in-swift/
extension UIView {
    func rotate360Degrees(duration: CFTimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(.pi * 2.0)
        rotateAnimation.duration = duration
        
        if let delegate: AnyObject = completionDelegate {
            rotateAnimation.delegate = (delegate as! CAAnimationDelegate)
        }
        self.layer.add(rotateAnimation, forKey: nil)
    }
}

//zoom http://stackoverflow.com/questions/31320819/scale-uibutton-animation-swift
extension UIView {

    /**
     Simply zooming in of a view: set view scale to 0 and zoom to Identity on 'duration' time interval.

     - parameter duration: animation duration
     */
    func zoomIn(duration: TimeInterval = 0.2) {
        self.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveLinear], animations: { () -> Void in
            self.transform = .identity
            }) { (animationCompleted: Bool) -> Void in
        }
    }

    /**
     Simply zooming out of a view: set view scale to Identity and zoom out to 0 on 'duration' time interval.

     - parameter duration: animation duration
     */
    func zoomOut(duration: TimeInterval = 0.2) {
        self.transform = .identity
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveLinear], animations: { () -> Void in
            self.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
            }) { (animationCompleted: Bool) -> Void in
        }
    }

    /**
     Zoom in any view with specified offset magnification.

     - parameter duration:     animation duration.
     - parameter easingOffset: easing offset.
     */
    func zoomInWithEasing(duration: TimeInterval = 0.2, easingOffset: CGFloat = 0.2) {
        let easeScale = 1.0 + easingOffset
        let easingDuration = TimeInterval(easingOffset) * duration / TimeInterval(easeScale)
        let scalingDuration = duration - easingDuration
        UIView.animate(withDuration: scalingDuration, delay: 0.0, options: .curveEaseIn, animations: { () -> Void in
            self.transform = CGAffineTransform(scaleX: easeScale, y: easeScale)
            }, completion: { (completed: Bool) -> Void in
                UIView.animate(withDuration: easingDuration, delay: 0.0, options: .curveEaseOut, animations: { () -> Void in
                    self.transform = .identity
                    }, completion: { (completed: Bool) -> Void in
                })
        })
    }

    /**
     Zoom out any view with specified offset magnification.

     - parameter duration:     animation duration.
     - parameter easingOffset: easing offset.
     */
    func zoomOutWithEasing(duration: TimeInterval = 0.2, easingOffset: CGFloat = 0.2) {
        let easeScale = 1.0 + easingOffset
        let easingDuration = TimeInterval(easingOffset) * duration / TimeInterval(easeScale)
        let scalingDuration = duration - easingDuration
        UIView.animate(withDuration: easingDuration, delay: 0.0, options: .curveEaseOut, animations: { () -> Void in
            self.transform = CGAffineTransform(scaleX: easeScale, y: easeScale)
            }, completion: { (completed: Bool) -> Void in
                UIView.animate(withDuration: scalingDuration, delay: 0.0, options: .curveEaseOut, animations: { () -> Void in
                    self.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
                    }, completion: { (completed: Bool) -> Void in
                })
        })
    }

}
extension UITableView {
    func setEmptyView(title: String, message: String) {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = UIColor.darkGray
        titleLabel.font = UIFont.systemFont(ofSize: 17.0)
        messageLabel.textColor = UIColor.lightGray
        messageLabel.font = UIFont.systemFont(ofSize: 15.0)
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
        titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true
        titleLabel.text = title
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        // The only tricky part is here:
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}

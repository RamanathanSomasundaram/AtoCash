//
//  CSLocalizer.swift
//  vPlay
//
//  Created by user on 27/11/18.
//  Copyright © 2018 user. All rights reserved.
//

import Foundation
import UIKit
class CSLocalizer: NSObject {
    /// Do Swizzling
    class func doTheSwizzling() {
        methodSwizzleGivenClassName(
            cls: Bundle.self, originalSelector: #selector(Bundle.localizedString(forKey:value:table:)),
            overrideSelector: #selector(Bundle.specialLocalizedStringForKey(_:value:table:)))
        methodSwizzleGivenClassName(
            cls: UIApplication.self, originalSelector: #selector(getter:
                UIApplication.userInterfaceLayoutDirection),
            overrideSelector: #selector(getter: UIApplication.customUserInterfaceLayoutDirection))
        methodSwizzleGivenClassName(cls: UITextField.self,
                                    originalSelector: #selector(UITextField.layoutSubviews),
                                    overrideSelector: #selector(UITextField.cstmlayoutSubviews))
        methodSwizzleGivenClassName(cls: UILabel.self,
                                    originalSelector: #selector(UILabel.layoutSubviews),
                                    overrideSelector: #selector(UILabel.cstmlayoutSubviews))
    }
}
/// Exchange the implementation of two methods of the same Class
func methodSwizzleGivenClassName(cls: AnyClass, originalSelector: Selector, overrideSelector: Selector) {
    let origMethod: Method = class_getInstanceMethod(cls, originalSelector)!
    let overrideMethod: Method = class_getInstanceMethod(cls, overrideSelector)!
    if class_addMethod(cls, originalSelector, method_getImplementation(overrideMethod),
                       method_getTypeEncoding(overrideMethod)) {
        class_replaceMethod(cls, overrideSelector, method_getImplementation(origMethod), method_getTypeEncoding(origMethod))
    } else {
        method_exchangeImplementations(origMethod, overrideMethod)
    }
}
/// Language Mirror 
extension UIViewController {
    func loopThroughSubViewAndFlipTheImageIfItsAUIImageView(subviews: [UIView]) {
        if subviews.count > 0 {
            for subView in subviews {
                if (subView is UIImageView) && subView.tag < 0 {
                    let toRightArrow = (subView as? UIImageView)!
                    if let image = toRightArrow.image {
                        toRightArrow.image = UIImage(cgImage: image.cgImage!, scale: image.scale,
                                                     orientation: UIImage.Orientation.upMirrored)
                    }
                }
                loopThroughSubViewAndFlipTheImageIfItsAUIImageView(subviews: subView.subviews)
            }
        }
    }
}
// Mirror Label
class MirroringLabel: UILabel {
    override func layoutSubviews() {
        if self.tag < 0 {
            //            if UIApplication.isRTL()  {
            //                if self.textAlignment == .right {
            //                    return
            //                }
            //            } else {
            //                if self.textAlignment == .left {
            //                    return
            //                }
            //            }
        }
        if self.tag < 0 {
            //            if UIApplication.isRTL()  {
            //                self.textAlignment = .right
            //            } else {
            //                self.textAlignment = .left
            //            }
        }
    }
}
// Language Support for Label
extension UILabel {
    @objc public func cstmlayoutSubviews() {
        self.cstmlayoutSubviews()
        if self.isKind(of: NSClassFromString("UITextFieldLabel")!) {
            return // handle special case with uitextfields
        }
        if self.tag <= 0 {
            //            if UIApplication.isRTL()  {
            //                if self.textAlignment == .right {
            //                    return
            //                }
            //            } else {
            //                if self.textAlignment == .left {
            //                    return
            //                }
            //            }
        }
        if self.tag <= 0 {
            //            if UIApplication.isRTL()  {
            //                self.textAlignment = .right
            //            } else {
            //                self.textAlignment = .left
            //            }
        }
    }
}
// Language Support for UITextField
extension UITextField {
    @objc public func cstmlayoutSubviews() {
        self.cstmlayoutSubviews()
        if self.tag <= 0 {
            //            if UIApplication.isRTL()  {
            //                if self.textAlignment == .right { return }
            //                self.textAlignment = .right
            //            } else {
            //                if self.textAlignment == .left { return }
            //                self.textAlignment = .left
            //            }
        }
    }
}
extension UIApplication {
    @objc var customUserInterfaceLayoutDirection: UIUserInterfaceLayoutDirection {
       @inline(__always) get {
            var direction = UIUserInterfaceLayoutDirection.leftToRight
            if CSLanguage.currentAppleLanguage() == "ar" {
                direction = .rightToLeft
            }
            return direction
        }
    }
}

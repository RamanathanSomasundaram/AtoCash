//
//  Bundle+Extension.swift
//  vPlay
//
//  Created by user on 27/11/18.
//  Copyright © 2018 user. All rights reserved.
//

import Foundation
import UIKit
// MARK: - Bundle Extension
extension Bundle {
    @objc func specialLocalizedStringForKey(_ key: String, value: String?, table tableName: String?) -> String {
        var currentLanguage = CSLanguage.currentAppleLanguage()
        if currentLanguage.contains("en") {
            currentLanguage = "en"
        }
        var bundle = Bundle.main
        if let path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj") {
            bundle = Bundle.init(path: path)!
        } else {
            let basePath = Bundle.main.path(forResource: "Base", ofType: "lproj")
            bundle = Bundle.init(path: basePath!)!
        }
        if let name = tableName, name == "CameraUI" {
            let values = NSLocalizedString(key, comment: name)
            return bundle.specialLocalizedStringForKey(key, value: values, table: tableName)
        }
        return bundle.specialLocalizedStringForKey(key, value: value, table: tableName)
    }
}
extension UIViewController {
    
    /// Currrent Language
    func currentLanguage() -> String { return CSLanguage.currentAppleLanguage() }
    //View Updates
    func viewUpdates(){
        if CSLanguage.currentAppleLanguage() == "ar"{
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        }
        else{
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
    }
    // Check Langauge Change
    func islangauge(_ langauge: String) -> Bool {
        if langauge != CSLanguage.currentAppleLanguage() {
            self.reloadViewFromNib()
            return true
        }
        return false
    }
    
    func reloadViewFromNib() {

        
//        let window = UIApplication.shared.windows
//        for win in window{
//            for vw in win.subviews{
//                vw.removeFromSuperview()
//                win.addSubview(vw)
//            }
//        }
//        /*
//         for (UIView *view in window.subviews) {
//                 [view removeFromSuperview];
//                 [window addSubview:view];
//             }
//         **/
//        let parent = view.superview
//        view.removeFromSuperview(); view = nil
//        parent?.addSubview(view) // This line causes the view to be reloaded
        
        /*
         UIView *currentview = self.window.rootViewController.view;
         UIView *superview = currentview.superview;
         [currentview removeFromSuperview];
         [superview addSubview:currentview];
         **/
        let currentView = self.view
        let superView = currentView?.superview
        currentView?.removeFromSuperview()
        superView?.addSubview(currentView!)
    }
}
/*
 func changeLangaugeAction(_ sender: UIButton) {
     CSOptionDropDown.langaugeListingDropdown(
         button: sender,
         completionHandler: { [unowned self] index in
             if index == 0 {
                 CSLanguage.setAppleLAnguageTo(lang: "en")
             }else {
                 CSLanguage.setAppleLAnguageTo(lang: "pa-IN")
             }
             self.refreshNavigation()
     })
 }
 //NSLocalizedString("Auto", comment: "Auto")
 
 **/
private var bundleKey: UInt8 = 0

final class BundleExtension: Bundle {

     override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        return (objc_getAssociatedObject(self, &bundleKey) as? Bundle)?.localizedString(forKey: key, value: value, table: tableName) ?? super.localizedString(forKey: key, value: value, table: tableName)
    }
}

extension Bundle {

    static let once: Void = { object_setClass(Bundle.main, type(of: BundleExtension())) }()

    static func set(language: String) {
        Bundle.once

        let isLanguageRTL = Locale.characterDirection(forLanguage: "ar") == .rightToLeft
        UIView.appearance().semanticContentAttribute = isLanguageRTL == true ? .forceRightToLeft : .forceLeftToRight

        UserDefaults.standard.set(isLanguageRTL,   forKey: "AppleTe  zxtDirection")
        UserDefaults.standard.set(isLanguageRTL,   forKey: "NSForceRightToLeftWritingDirection")
        UserDefaults.standard.set([language], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()

        guard let path = Bundle.main.path(forResource: language, ofType: "lproj") else {
            print( "Failed to get a bundle path.")
            return
        }

        objc_setAssociatedObject(Bundle.main, &bundleKey, Bundle(path: path), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

//
//  CSlangauge.swift
//  vPlay
//
//  Created by user on 27/11/18.
//  Copyright © 2018 user. All rights reserved.
//

import Foundation
// Apple Language Key
let APPLELANGUAGEKEY = "AppleLanguages"
/// CSLanguage
class CSLanguage {
    /// get current Apple language
    class func currentAppleLanguage() -> String {
        let userdef = UserDefaults.standard
        let langArray = userdef.object(forKey: APPLELANGUAGEKEY) as? NSArray
        let current = (langArray?.firstObject as? String)!
        return current
    }
    /// Get Current Apple Language Full List
    class func currentAppleLanguageFull() -> String {
        let userdef = UserDefaults.standard
        let langArray = userdef.object(forKey: APPLELANGUAGEKEY) as? NSArray
        if (langArray?.firstObject as? String)!.contains("en") {
            let current = (langArray?.firstObject as? String)!
            return current
        }
        let current = (langArray?.firstObject as? String)!
        return current
    }
    /// set @lang to be the first in Applelanguages list
    class func setAppleLAnguageTo(lang: String) {
        let userdef = UserDefaults.standard
        userdef.set([lang, currentAppleLanguage()], forKey: APPLELANGUAGEKEY)
        userdef.synchronize()
    }
    class var isRTL: Bool {
        return CSLanguage.currentAppleLanguage() == "ar"
    }
}

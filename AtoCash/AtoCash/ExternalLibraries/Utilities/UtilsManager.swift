//
//  Utils.swift
//  SwiftCodeBase
//
//  Created by Jegathesan on 5/4/17.
//  Copyright © 2017 CodeBase. All rights reserved.
//

import Foundation
import UIKit
import SafariServices
import AVFoundation

class DefaultsManager: UserDefaults {

static let shared = DefaultsManager()
    
    var baseLink: String?{
       set(newAccessToken){
           self.set(newAccessToken, forKey: "BASELINK")
       }
       get{
           return self.object(forKey: "BASELINK") as? String
       }
   }
    var expenseCount: Int?{
       set(newAccessToken){
           self.set(newAccessToken, forKey: "EXPENSECOUNT")
       }
       get{
           return self.object(forKey: "EXPENSECOUNT") as? Int
       }
   }
// MARK: - USER INFO
 var accesstoken: String?{
    set(newAccessToken){
        self.set(newAccessToken, forKey: "ACCESSTOKEN")
    }
    get{
        return self.object(forKey: "ACCESSTOKEN") as? String
    }
}
    var isRemoved: Bool?{
       set(newAccessToken){
           self.set(newAccessToken, forKey: "ISREMOVE")
       }
       get{
           return self.object(forKey: "ISREMOVE") as? Bool
       }
   }
    // MARK: - USER INFO
    var userRole: String?{
        set(newAccessToken){
            self.set(newAccessToken, forKey: "ROLE")
        }
        get{
            return self.object(forKey: "ROLE") as? String
        }
    }
    
    var userRolesList :[String]?{
        set(newAccessToken){
            self.set(newAccessToken, forKey: "ROLELIST")
        }
        get{
            return self.object(forKey: "ROLELIST") as? [String]
        }
    }
    var userEmail: String?{
        set(newAccessToken){
            self.set(newAccessToken, forKey: "EMAIL")
        }
        get{
            return self.object(forKey: "EMAIL") as? String
        }
    }
    var userID: String?{
        set(newAccessToken){
            self.set(newAccessToken, forKey: "USERID")
        }
        get{
            return self.object(forKey: "USERID") as? String
        }
    }
    var currencyId: String?{
        set(newAccessToken){
            self.set(newAccessToken, forKey: "CURRENCYID")
        }
        get{
            return self.object(forKey: "CURRENCYID") as? String
        }
    }
    var currencyType: String?{
        set(newAccessToken){
            self.set(newAccessToken, forKey: "CURRENCYTYPE")
        }
        get{
            return self.object(forKey: "CURRENCYTYPE") as? String
        }
    }
    var fName: String?{
        set(newAccessToken){
            self.set(newAccessToken, forKey: "FIRSTNAME")
        }
        get{
            return self.object(forKey: "FIRSTNAME") as? String
        }
    }
    
    var lName: String?{
        set(newAccessToken){
            self.set(newAccessToken, forKey: "LASTNAME")
        }
        get{
            return self.object(forKey: "LASTNAME") as? String
        }
    }
    
    var fullName: String?{
        set(newAccessToken){
            self.set(newAccessToken, forKey: "FULLNAME")
        }
        get{
            return self.object(forKey: "FULLNAME") as? String
        }
    }
    
    var expenseRequest : [String:[offlineData]]?{
        set(newuser) {
            return self.setObject(object: newuser, forkey: "OFFLINEDATA")
        } get {
            return self.getObject(object: [String:[offlineData]].self, forkey: "OFFLINEDATA")
        }
    }
    // MARK: - Save objects
    
    func setObject<T: Codable>(object: T, forkey: String) {
        if let encodedData = try? JSONEncoder().encode(object) {
            self.set(encodedData, forKey: forkey)
        }
    }
    
    func getObject<T: Codable>(object: T.Type, forkey: String) -> T? {
        if let decoded  = UserDefaults.standard.object(forKey: forkey) as? Data{
        if let loadedPerson = try? JSONDecoder().decode(object, from: decoded) {
            return loadedPerson
        }
        }
        return object as? T
    }
    
}
extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
class UtilsManager: NSObject {
    
    static let shared = UtilsManager()
    
    //Avoid basic init using () instead of sharedManager
    private override init() {
        super.init()
        self.initObjects()
    }
    
    //Initialize the instance variables
    func initObjects() -> Void {
        UtilsManager.monitorNetwork()
    }
    
    // MARK: - Network
    static var networkChangedBlock: ((Bool) -> Void)?
    static var reachability = Reachability()!
    static var isNetworkReached:Bool{
        get{
            if UtilsManager.reachability.currentReachabilityStatus == .notReachable{
                // RequestManager.shared.NetworkNotReached()
                return false
            }
            else{
                return true
            }
        }
    }
    
    func logoutUser(){
        DefaultsManager.shared.baseLink = ""
        DefaultsManager.shared.accesstoken = ""
        DefaultsManager.shared.userRole = ""
        DefaultsManager.shared.isRemoved = false
        AppDelegate.shared.setupRootViewController()
    }
    
    func navigationViewLeftButtonTitle(title : String, selector: Selector, VC: UIViewController) -> UIView
    {
        let widthSize = (title.isEmpty && title == "") ? 40.0 : 120.0
        let view = UIView(frame: CGRect(x: 15, y: 0, width: widthSize, height: 40))
        let button = UIButton(type: .system)
        button.semanticContentAttribute = .forceLeftToRight
        button.setImage(UIImage(named: title == "Account" ? "goBackChats" : "menuHamburger"), for: .normal)
        button.setTitle("   \(title)", for: .normal)
        button.tintColor = UIColor.white
        button.titleLabel?.font = UIFont(name: "ProximaNova-Bold", size: 30.0)
        button.titleLabel?.textColor = UIColor.white
        button.addTarget(VC, action: selector, for: .touchUpInside)
        button.sizeToFit()
        view.addSubview(button)
        return view
    }
    
    func NotificationAlertShow() -> Bool{
        let isRegisteredForRemoteNotifications = UIApplication.shared.isRegisteredForRemoteNotifications
        if isRegisteredForRemoteNotifications {
            // User is registered for notification
            return false
        } else {
            // Show alert user is not registered for notification
            return true
        }
    }
    
    //MARK: - Check Free space
    //To check the avilable space in mobile
    func checkFreeSpace() -> Bool {
        var freeDiskSpaceInBytes:Int64 {
            if #available(iOS 11.0, *) {
                if let space = try? URL(fileURLWithPath: NSHomeDirectory() as String).resourceValues(forKeys: [URLResourceKey.volumeAvailableCapacityForImportantUsageKey]).volumeAvailableCapacityForImportantUsage {
                    return space
                } else {
                    return 0
                }
            } else {
                if let systemAttributes = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory() as String),
                    let freeSpace = (systemAttributes[FileAttributeKey.systemFreeSize] as? NSNumber)?.int64Value {
                    return freeSpace
                } else {
                    return 0
                }
            }
        }
        let str = "200"
        let limit = (((str as NSString).longLongValue) * 1024 * 1024)
        print("Free Disk : \(freeDiskSpaceInBytes)")
        return freeDiskSpaceInBytes>limit
        
    }
    
    
    //MARK:  share link to other apps
    func ShareLinkAction(_ link : String, _ content : String, _ vc : UIViewController){
        let activityViewController = UIActivityViewController(activityItems: [content , link], applicationActivities: nil)
        //referLink
        activityViewController.popoverPresentationController?.sourceView = vc.view
        vc.present(activityViewController, animated: true, completion: nil)
        
    }
    
    //MARK:  webview support
    func WebAction(_ link : String, _ vc : UIViewController){
        if let urlValid = URL(string: link.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? link) {
            let safariVC = SFSafariViewController.init(url: urlValid)
            vc.view.window?.rootViewController?.present(safariVC, animated: true, completion: nil)
        }else{
            print("Invalid link")
        }
    }
    
    static func monitorNetwork() {
        
        reachability.whenReachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
            DispatchQueue.main.async {
                if(UtilsManager.networkChangedBlock != nil){
                    UtilsManager.networkChangedBlock!(true)
                }
            }
        }
        
        reachability.whenUnreachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
            DispatchQueue.main.async {
                if(UtilsManager.networkChangedBlock != nil){
                    UtilsManager.networkChangedBlock!(false)
                }
            }
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    // MARK: - Application
    static var appName: String{
        return Bundle.main.infoDictionary?["CFBundleName"] as! String
    }
    
    static var appVersion:String{
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
    }
    
    static var appBuildVersion:String{
        return Bundle.main.infoDictionary?["CFBundleVersion"] as! String
    }
    
    
    // MARK: - Encryption and Decryptions
    
    static func JsonStringFromDictionary(dictionary: NSDictionary) -> String
    {
        var json: String = ""
        do {
            let data = try JSONSerialization.data(withJSONObject: dictionary, options: JSONSerialization.WritingOptions.prettyPrinted)
            json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)! as String
        } catch {
            print("something went wrong with parsing json")
        }
        return json
    }
    
    static func DictionaryFromJsonString(json: String) -> NSDictionary
    {
        var response: NSDictionary!
        let data = json.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        do {
            response = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
        return response
    }
    
    static func getMediaName(content : String) -> String{
        let splitName = content.components(separatedBy: "/")[2]
        let splitName1 = splitName.components(separatedBy: ".")[0]
        return splitName1
    }
    
    static func isValidEmail(_ email : String) -> Bool {
        
        let regex = try! NSRegularExpression(pattern: "^[!#$%&'*+-/=?^_`{|}~A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9!#$%&'*+-/=?^_`{|}~]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.(?:[A-Za-z]{2}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|asia|arpa|blog|jobs|museum))$", options: .caseInsensitive)
        
        if (regex.firstMatch(in: email, options: [], range: NSRange(location: 0, length: email.count)) == nil)
        {
            return false    // Found validation failed
        }
        else if email.range(of:"..") != nil
        {
            return false    //  Found continuous dots
        }
        else if (email.first == ".")
        {
            return false    //  Found first char as dot
        }
        else
        {
            let namepart = email.components(separatedBy: "@")[0]
            let domainPart = email.components(separatedBy: "@")[1]
            
            if (namepart.last == "."){
                return false    //  Found last char as dot in name
            }
            else if (domainPart.first == "-"){
                return false    //  Found first char as Hyphen in domain
            }
            else if domainPart.range(of:"-.") != nil
            {
                return false    //  Found continuous dots
            }
        }
        
        return true
    }
    //Add childviewController
    static func add(asChildViewController : UIViewController,rootVC : UIViewController, subView : UIView)
    {
        // Add Child View Controller
        rootVC.addChild(asChildViewController)
        
        // Add Child View as Subview
        subView.addSubview(asChildViewController.view)
        
        // Configure Child View
        asChildViewController.view.frame = subView.bounds
        asChildViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        asChildViewController.didMove(toParent: rootVC)
    }
    
    // MARK: - Date and Time
    func ConvertChatTime(_ timeStamp : Int) -> String {
        let date = Date.date(timestamp: timeStamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        return dateFormatter.string(from: date)
    }
    static var currentTimeStamp: NSNumber {
        return NSNumber(value: Int(NSDate().timeIntervalSince1970 * 1000))
        //return "\()"
    }
    
    func currentUTCDateTime(format: String) -> String {
        let formatter:DateFormatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = format
        return formatter.string(from: NSDate() as Date)
    }
    
    func systemDateStringFromUTC(utcDate: String, formatOf: String = "yyyy-MM-dd") -> String{
        if utcDate == "" {
            return ""
        }
        //Convert UTC date string to Date object
        let utcFormatter:DateFormatter = DateFormatter()
        //utcFormatter.timeZone = TimeZone(abbreviation: "UTC")
        utcFormatter.dateFormat = utcDate.contains(".") ? "yyyy-MM-dd'T'HH:mm:ss.SSS" : "yyyy-MM-dd'T'HH:mm:ss"
        let UTCDate = utcFormatter.date(from: utcDate)
        
        //Convert UTC Date to System Date string
        let localFormatter:DateFormatter = DateFormatter()
        localFormatter.timeZone = TimeZone.current
        localFormatter.dateFormat = formatOf
        return localFormatter.string(from: UTCDate!)
        
    }
    
    func systemDatetoString(_ date : Date) -> String{
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        let now = df.string(from: date)
        return now
    }
    func UTCDateFromString2(date: String, format : String = "dd-MMM-yyyy") -> Date{
        let utcDate = date
        //Convert UTC date string to Date object
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let UTCDate = dateFormatter.date(from: utcDate)
        //dateFormatter.dateFormat = format
        //dateFormatter.timeZone = .current
        return UTCDate!
    }
    
    
    
    func localDateFromUTC(utcDate: String) -> String{
        
        var date = utcDate
        if !utcDate.contains(".") {
            date = utcDate.appending(".123")
        }
        
        //Convert UTC date string to Date object
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        let UTCDate:Date = dateFormatter.date(from: date)!
        
        //Convert UTC Date to System Date
        //dateFormatter.dateFormat = "dd/MM/YYYY hh:mm a"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: UTCDate)
    }
    
    func currentDateandTime()-> String {
        let dateFormatter : DateFormatter = DateFormatter()
          dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = Date()
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    func UTCDateFromString(date: String, format : String = "yyyy-MM-dd" ) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.timeZone = .current
        if let dateFromString = dateFormatter.date(from: date) {
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
            dateFormatter.timeZone = .current
            return dateFormatter.string(from: dateFromString)  // 19-08-2015 06:00 AM -0300"
        } else { return "" }
    }
    
    func UTCDateFromString1(date: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        //        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        if let dateFromString = dateFormatter.date(from: date) {
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
            dateFormatter.timeZone = .current
            return dateFormatter.string(from: dateFromString)  // 19-08-2015 06:00 AM -0300"
        } else { return "" }
    }
    
    func getSavedImage(named: String) -> UIImage? {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path)
        }
        return nil
    }
    
    
    func ReadTextFrom(fileName: String) -> String {
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(fileName)
            //reading
            do {
                let text2 = try String(contentsOf: fileURL, encoding: .utf8)
                return text2
            }
            catch {
                /* error handling here */
                
            }
        }
        return ""
    }
    
    func WriteTextTo(fileName: String, content: String) -> Bool{
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let fileURL = dir.appendingPathComponent(fileName)
            
            //writing
            do {
                try content.write(to: fileURL, atomically: false, encoding: .utf8)
            }
            catch {
                return false
            }
            return true
        }
        return false
    }
    static func isMicroPhoneAccessPermission(completionHandler : @escaping (Bool) -> Void)
        
    {
        switch AVCaptureDevice.authorizationStatus(for: .audio) {
            
        case .authorized: // The user has previously granted access to the camera.
            
            completionHandler(true)
            
        case .notDetermined: // The user has not yet been asked for camera access.
            
            AVCaptureDevice.requestAccess(for: .audio) { granted in
                if granted {
                    completionHandler(true)
                }
            }
        case .denied: // The user has previously denied access.
            
            completionHandler(false)
            
        case .restricted: // The user can't grant access due to restrictions.
            
            completionHandler(false)
            
        @unknown default:
            //break
            completionHandler(false)
        }
    }
    
    
}
extension Date {
    
    //---------------------------------------------------------------------------------------------------------------------------------------------
    func timestamp() -> Int64 {
        
        return Int64(self.timeIntervalSince1970 * 1000)
    }
    
    //---------------------------------------------------------------------------------------------------------------------------------------------
    static func date(timestamp: Int) -> Date {
        
        let interval = TimeInterval(TimeInterval(timestamp) / 1000)
        return Date(timeIntervalSince1970: interval)
    }
    
    
    static var yesterday: Date { return Date().dayBefore }
    static var tomorrow:  Date { return Date().dayAfter }
    
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return dayAfter.month != month
    }
}
extension String {
    
    func fromStringBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    func toStringBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
}
extension UIImage {
    func toBase64() -> String? {
        guard let imageData = self.pngData() else { return nil }
        return imageData.base64EncodedString(options: .lineLength64Characters)
    }
}
protocol Utilities {}



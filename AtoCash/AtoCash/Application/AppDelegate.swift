//
//  AppDelegate.swift
//  AtoCash
//
//  Created by user on 29/01/21.
//

import UIKit
import IQKeyboardManagerSwift
import Localize_Swift
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    lazy var myNoInternetViewController = NoInternetViewController()
    lazy var myNoInternet = false
    var internetCompletionHandler:internetHandler?
//    /// Currrent Language
//    var currentLanguage = CSLanguage.currentAppleLanguage()
    //var realm : Realm!
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        Localize.setCurrentLanguage("en")
        //Localize.resetCurrentLanguageToDefault()
        //CSLanguage.setAppleLAnguageTo(lang: "ar")
       
        CSLocalizer.doTheSwizzling()
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        //Realm Migration
       // self.realmMigrate()

        //DefaultsManager.shared.accesstoken = ""
        if DefaultsManager.shared.isRemoved == nil {
            DefaultsManager.shared.isRemoved = false
        }
        // Search bar placeholder text color
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = UIColor.white
        //UISearchBar.appearance().tintColor = UIColor.white

        UINavigationBar.appearance().barTintColor = UIColor(named: "NavBar1")!
        UINavigationBar.appearance().backgroundColor = UIColor(named: "NavBar1")!
          UINavigationBar.appearance().tintColor = .white
          UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
          UINavigationBar.appearance().isTranslucent = false
        return true
    }
    
    
    
    // MARK: - Realm migration methods
//    func realmMigrate() {
//        var config = Realm.Configuration()
//        config.schemaVersion = 1
//        config.migrationBlock = { migration, oldSchemaVersion in
//            print("oldSchemaVersion \(oldSchemaVersion)")
//            if (oldSchemaVersion < 1) {
//                print("schema update \(oldSchemaVersion)")
//            }
//        }
//
//        realm = try! Realm(configuration: config)
//    }
    
    func setupRootViewController(){
        if CSLanguage.currentAppleLanguage() == "ar"{
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        }
        else{
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
        
        //Dashboard
        let home = mainStoryboard.instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
        home.tabBarItem = TextyTabBarItem(title: NSLocalizedString("dashboard", comment: ""), image: UIImage(named: "Home"), tag: 0)
        
        //Expense Request
        let expense = mainStoryboard.instantiateViewController(withIdentifier: "ExpanseViewController") as! ExpanseViewController
        expense.tabBarItem = TextyTabBarItem(title: NSLocalizedString("expense_claim", comment: ""), image: UIImage(named: "Expense"), tag: 1)
        
        //Advance Request
        let advance = mainStoryboard.instantiateViewController(withIdentifier: "AdvanceRequestViewController") as! AdvanceRequestViewController
        advance.tabBarItem = TextyTabBarItem(title: NSLocalizedString("adance_title", comment: ""), image: UIImage(named: "Advance"), tag: 2)//adance_title

        //Travel Request
        let travel = mainStoryboard.instantiateViewController(withIdentifier: "travelRequestViewController") as! travelRequestViewController
        travel.tabBarItem = TextyTabBarItem(title: NSLocalizedString("travel_title", comment: ""), image: UIImage(named: "travelRequest"), tag: 3)//travel_title
        
        //Inbox
        let inbox = mainStoryboard.instantiateViewController(withIdentifier: "IncomeViewController") as! IncomeViewController
        inbox.tabBarItem = TextyTabBarItem(title: NSLocalizedString("inbox_title", comment: ""), image: UIImage(named: "My Inbox"), tag: 4)
        
        //Report
        let report = mainStoryboard.instantiateViewController(withIdentifier: "ReportViewController") as! ReportViewController
        report.isSideMenu = false
        report.isMyReport = false
        report.tabBarItem = TextyTabBarItem(title: NSLocalizedString("report", comment: ""), image: UIImage(named: "Report"), tag: 5)//report

        
        DispatchQueue.main.async {
        if DefaultsManager.shared.accesstoken == "" || DefaultsManager.shared.accesstoken == nil {
           
            let vc = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            AppDelegate.shared.window?.rootViewController = vc
        }
        else{
            SwaggerClientAPI.customHeaders = ["Authorization" : "bearer \(DefaultsManager.shared.accesstoken ?? "")"]

            var nav : UINavigationController!
            
            let tabBarController = TextyTabBarController()
            
            // Define the menu
            SideMenuManager.default.leftMenuNavigationController = mainStoryboard.instantiateViewController(withIdentifier: "SideMenuNavigationController") as? SideMenuNavigationController
            
            if (DefaultsManager.shared.userRole == "Admin") {
                tabBarController.viewControllers = [home, report]
            }
            else if(DefaultsManager.shared.userRole == "Manager" || DefaultsManager.shared.userRole == "FinManager"){
                tabBarController.viewControllers = [home,expense,advance,travel,inbox]
            }
            else{
                tabBarController.viewControllers = [home,expense,advance,travel,report]
            }
            tabBarController.hidesBottomBarWhenPushed = true
            nav = UINavigationController(rootViewController: tabBarController)
            
            AppDelegate.shared.window?.rootViewController = nav
            }
        }
    }
    
    //---------------------------------------------------------------------------------------------------------------------------------------------
    func topViewController() -> UIViewController? {
        
        var viewController = UIApplication.shared.keyWindow?.rootViewController
        while (viewController?.presentedViewController != nil) {
            viewController = viewController?.presentedViewController
        }
        return viewController
    }
    
    func presentNoInternetViewController(_ handler
        : @escaping internetHandler) {
        if myNoInternet == false {
            myNoInternetViewController = NoInternetViewController()
            myNoInternetViewController.completionBlock = { (connection) in
                self.myNoInternet = false
                handler(true)
            }
            let aViewController = AppDelegate.shared.window?.rootViewController?.presentedViewController
            myNoInternetViewController.modalPresentationStyle = .fullScreen
            if aViewController != nil {
                aViewController?.present(myNoInternetViewController, animated: true, completion: {
                    self.myNoInternet = true
                })
            }else {
                AppDelegate.shared.window?.rootViewController?.present(myNoInternetViewController, animated: true, completion: {
                    self.myNoInternet = true
                })
            }
        }
    }
    
    
    func dismissNoInternetViewController() {
        //if myNoInternet == true {
        myNoInternetViewController = NoInternetViewController()
        let aViewController = AppDelegate.shared.window?.rootViewController?.presentedViewController
        if aViewController != nil {
            aViewController?.dismiss(animated: true, completion: {
                self.myNoInternet = false
            })
        }else {
            AppDelegate.shared.window?.rootViewController?.dismiss(animated: true, completion: {
                self.myNoInternet = false
            })
        }
        // }
    }
}

extension AppDelegate {
    static var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    var rootViewController: UIViewController {
        return (AppDelegate.shared.window?.rootViewController)!
    }
}

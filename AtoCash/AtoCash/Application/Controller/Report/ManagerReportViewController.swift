//
//  ManagerReportViewController.swift
//  AtoCash
//
//  Created by User on 07/06/21.
//

import UIKit

class ManagerReportViewController: UIViewController,BarButtonConfigarable {
    
    @IBOutlet weak var allReportBtn: UIButton!
    @IBOutlet weak var myReportBtn: UIButton!
    @IBOutlet weak var navigationHeight: NSLayoutConstraint!
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var pageView: UIView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    var isSideMenu : Bool = false
    
    //PageViewController
    var tabpageVC : TabPageViewController!
    var currentTab : TrackStatusType = .expanse
    
    var currentIndex : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = NSLocalizedString("report", comment: "")
        if(!self.isSideMenu){
            self.navigationHeight.constant = 0.0
            self.navigationView.isHidden = true
        }
        else{
            self.navigationHeight.constant = 0.0
            self.navigationView.isHidden = true
            self.bottomConstraint.constant = 0.0
        }
    }
    
    
    @IBAction func leftMenuAction(_ sender: Any) {
        self.present(SideMenuManager.default.leftMenuNavigationController!, animated: true, completion: nil)
    }
    @IBAction func rightUserAction(_ sender: UIBarButtonItem) {
        let dropDown = DropDown()

        // The view to which the drop down will appear on
        dropDown.anchorView = sender // UIView or UIBarButtonItem

        // The list of items to display. Can be changed dynamically
        dropDown.dataSource = [DefaultsManager.shared.userEmail ?? "" , NSLocalizedString("logout", comment: "")]
        
        // Action triggered on selection
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            if index == 0{
                let vc = mainStoryboard.instantiateViewController(withIdentifier: "UserProfileViewController") as! UserProfileViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else{
                let alert = UIAlertController(title: NSLocalizedString("logout", comment: ""), message: NSLocalizedString("logout_message", comment: ""), preferredStyle: .alert)
                let okAlert = UIAlertAction(title: NSLocalizedString("yes", comment: ""), style: .default) { (action) in
                    UtilsManager.shared.logoutUser()
                }
                let cancelAlert = UIAlertAction(title: NSLocalizedString("no", comment: ""), style: .cancel, handler: nil)
                alert.addAction(okAlert)
                alert.addAction(cancelAlert)
                self.present(alert, animated: true, completion: nil)
            }
        }

        // Will set a custom width instead of the anchor view width
        dropDown.width = 200
        dropDown.show()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.islangauge(self.currentLanguage()) { return}
        self.viewUpdates()
       // if(!self.isSideMenu){
        if DefaultsManager.shared.userRole == "Admin" {
            self.addBarButtonItem(ofType: .menu(.left))
        }
        else{
            if(DefaultsManager.shared.userRole == "Manager" || DefaultsManager.shared.userRole == "FinManager"){
                self.addBarButtonItem(ofType: .menu(.left))
            }
        }
            self.addBarButtonItem(ofType: .user(.right))
    }
    //MARK: - Navigation Menu Functions
    func presentLeftMenu(_ sender: AnyObject) {
        self.present(SideMenuManager.default.leftMenuNavigationController!, animated: true, completion: nil)
    }
    
    func dismissController(_ sender: UIBarButtonItem) {
        let dropDown = DropDown()

        // The view to which the drop down will appear on
        dropDown.anchorView = sender // UIView or UIBarButtonItem

        // The list of items to display. Can be changed dynamically
        dropDown.dataSource = [DefaultsManager.shared.userEmail ?? "" , "Logout"]
        
        // Action triggered on selection
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            if index == 0{
                let vc = mainStoryboard.instantiateViewController(withIdentifier: "UserProfileViewController") as! UserProfileViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else{
                let alert = UIAlertController(title: "Logout", message: "Are you sure? You want logout this account ", preferredStyle: .alert)
                let okAlert = UIAlertAction(title: "Yes", style: .default) { (action) in
                    UtilsManager.shared.logoutUser()
                }
                let cancelAlert = UIAlertAction(title: "No", style: .cancel, handler: nil)
                alert.addAction(okAlert)
                alert.addAction(cancelAlert)
                self.present(alert, animated: true, completion: nil)
            }
        }

        // Will set a custom width instead of the anchor view width
        dropDown.width = 200
        dropDown.show()
        
    }
    func showNotification(_ sender: AnyObject) {
        
    }
    @IBAction func allReportAction(_ sender: Any) {
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "ReportViewController") as! ReportViewController
        vc.isSideMenu = true
        vc.isMyReport = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func MyReportAction(_ sender: Any) {
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "ReportViewController") as! ReportViewController
        vc.isSideMenu = true
        vc.isMyReport = false
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

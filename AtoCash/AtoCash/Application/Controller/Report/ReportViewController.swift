//
//  ReportViewController.swift
//  AtoCash
//
//  Created by user on 03/05/21.
//

import UIKit

class ReportViewController: UIViewController,BarButtonConfigarable {

    @IBOutlet weak var navigationHeight: NSLayoutConstraint!
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var pageView: UIView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    var isSideMenu : Bool = false
    var isMyReport = false
    
    @IBOutlet weak var leftBtn: UIBarButtonItem!
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
            //leftBtn.image = UIImage(named: "Menu")
        }
        else{
            self.navigationHeight.constant = 0.0
            self.navigationView.isHidden = true
            self.bottomConstraint.constant = 0.0
            //leftBtn.image = UIImage(named: "Menu")
        }
       
    }
    
    
    //BAckbutton Action
    @objc func BackButtonTapped(){
        //Pop to home view controller
        self.navigationController?.popViewController(animated: true)
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
                if(!isSideMenu){
                    self.addBarButtonItem(ofType: .menu(.left))
                }
                else{
                    if(DefaultsManager.shared.userRole == "Manager" || DefaultsManager.shared.userRole == "FinManager"){
                        //Navigation Backbar button item
                        let backBtn = UIBarButtonItem(image: UIImage.init(named: "back"), style: .plain, target: self, action: #selector(BackButtonTapped))
                        backBtn.tintColor = .white
                    
                        self.navigationItem.leftBarButtonItem = backBtn
                    }
                }
            }
        }
            self.addBarButtonItem(ofType: .user(.right))
        switch currentTab {
        case .expanse:
            self.loadPageViewController(currentindex: 0)
        case .advance:
            self.loadPageViewController(currentindex: 2)
        case .travel:
            self.loadPageViewController(currentindex: 1)
        }
        
    }
    
    private func setupUI(){
        
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
    
    @IBAction func filterAction(_ sender: Any) {
        
//        let filterVC = mainStoryboard.instantiateViewController(withIdentifier: "CashFIlterViewController") as! CashFIlterViewController
//        filterVC.modalPresentationStyle = .overFullScreen
//        self.present(filterVC, animated: true, completion: nil)
        
    }
    func showNotification(_ sender: AnyObject) {
        
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
extension ReportViewController : TabPageViewControllerDelegate, reportsMoveTracker {
    func loadPageViewController(currentindex : Int) {
        var tabItems:[(viewController: UIViewController, title: String)] = []
       // let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let tabpageView = self.storyboard?.instantiateViewController(withIdentifier: "MyReportsViewController") as! MyReportsViewController
        tabpageView.inboxviewType = .expanse
        tabpageView.incomDelegate = self
        tabpageView.isReportView = isMyReport
         tabItems.append((viewController: tabpageView, title:NSLocalizedString("expense_tab", comment: "")))
        let tabpageView1 = self.storyboard?.instantiateViewController(withIdentifier: "MyReportsViewController") as! MyReportsViewController
        tabpageView1.inboxviewType = .travel
        tabpageView1.incomDelegate = self
        tabpageView1.isReportView = isMyReport
         tabItems.append((viewController: tabpageView1, title:NSLocalizedString("travel_tab", comment: "")))
        let tabpageView2 = self.storyboard?.instantiateViewController(withIdentifier: "MyReportsViewController") as! MyReportsViewController
        tabpageView2.inboxviewType = .advance
        tabpageView2.incomDelegate = self
        tabpageView2.isReportView = isMyReport
         tabItems.append((viewController: tabpageView2, title:NSLocalizedString("cash_tab", comment: "")))
        //Tabview -> Title and Count
        
        var option = TabPageOption()
        option.tabHeight = 40.0
       // option.tabWidth = 120.0
        //option.tabBackgroundColor = UIColor.white
        option.currentColor = UIColor(named: "NavBar")!
        option.defaultColor = UIColor.lightGray
        option.currentTextColor = UIColor.white
       

        //option.tabMargin = 20.0
        
        self.tabpageVC = TabPageViewController.create()
        self.tabpageVC.option = option
        self.tabpageVC.tabItems = tabItems
        self.tabpageVC.view.backgroundColor = UIColor.clear
        self.tabpageVC.isInfinity = false
        self.tabpageVC.displayControllerWithIndex(currentindex, direction: .forward, animated: true)
        self.tabpageVC.currentIndexDelegate = self
        self.pageView.frame = self.tabpageVC.view.frame
        self.tabpageVC.view.frame = self.pageView.bounds
        self.pageView.addSubview(self.tabpageVC.view)
        
    }
    
    func reportsTracker(_ id: Int, reportViewType: TrackStatusType) {
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "TrackViewController") as! TrackViewController
        vc.trackStatusType = reportViewType
        vc.trackerRequestId = id
        self.currentTab = reportViewType
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func expensereportsTracker(_ id: Int) {
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "ExpenseListViewController") as! ExpenseListViewController
        vc.expenseRequestId = id
        self.currentTab = .expanse
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func Tabpageviewcontroller(currentindex: Int, viewcontroller: UIViewController) {
        print("Current index Page : \(currentindex)")
        let currentVC = (viewcontroller as! MyReportsViewController)
        switch currentindex {
        case 0:
            currentVC.inboxviewType = .expanse
            self.currentTab = .expanse
        case 1:
            currentVC.inboxviewType = .travel
            self.currentTab = .travel
        case 2:
            currentVC.inboxviewType = .advance
            self.currentTab = .advance
        default:
            break
        }
        //currentpageIndex = currentindex
        self.didTabWith(index: currentindex)
    }
    
    func didTabWith(index: Int){
        self.currentIndex = index
        print(index)
    }
}

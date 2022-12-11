//
//  IncomeViewController.swift
//  AtoCash
//
//  Created by user on 18/04/21.
//

import UIKit

class IncomeViewController: UIViewController,BarButtonConfigarable {

    @IBOutlet weak var pageView: UIView!
    //PageViewController
    var tabpageVC : TabPageViewController!
    var currentTab : TrackStatusType = .expanse
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = NSLocalizedString("inbox_title", comment: "")
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.islangauge(self.currentLanguage()){ return}
        self.viewUpdates()
        self.setupUI()
        if DefaultsManager.shared.userRole == "Admin" {
            self.addBarButtonItem(ofType: .menu(.left))
        }
        else{
            if(DefaultsManager.shared.userRole == "Manager" || DefaultsManager.shared.userRole == "FinManager"){
                self.addBarButtonItem(ofType: .menu(.left))
            }
            switch currentTab {
            case .expanse:
                self.loadPageViewController(currentindex: 0)
            case .advance:
                self.loadPageViewController(currentindex: 2)
            case .travel:
                self.loadPageViewController(currentindex: 1)
            }
        }
        self.addBarButtonItem(ofType: .user(.right))
       // self.addBarButtonItem2(ofType: .user(.right) , type1:.notification(.right))
    }
    
    private func setupUI(){
        self.title = NSLocalizedString("inbox_title", comment: "")
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension IncomeViewController : TabPageViewControllerDelegate, IncomeboxMoveTracker {
    func loadPageViewController(currentindex : Int) {
        var tabItems:[(viewController: UIViewController, title: String)] = []
       // let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let pageView = self.storyboard?.instantiateViewController(withIdentifier: "MyInboxViewController") as! MyInboxViewController
        pageView.inboxviewType = .expanse
        pageView.incomDelegate = self
         tabItems.append((viewController: pageView, title:NSLocalizedString("expense_tab", comment: "")))
        let pageView1 = self.storyboard?.instantiateViewController(withIdentifier: "MyInboxViewController") as! MyInboxViewController
        pageView1.inboxviewType = .travel
        pageView1.incomDelegate = self
         tabItems.append((viewController: pageView1, title:NSLocalizedString("travel_tab", comment: "")))
        let pageView2 = self.storyboard?.instantiateViewController(withIdentifier: "MyInboxViewController") as! MyInboxViewController
        pageView2.inboxviewType = .advance
        pageView2.incomDelegate = self
         tabItems.append((viewController: pageView2, title:NSLocalizedString("cash_tab", comment: "")))
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
    
    func incomeboxTracker(_ id: Int, incomeviewType: TrackStatusType) {
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "TrackViewController") as! TrackViewController
        vc.trackStatusType = incomeviewType
        vc.trackerRequestId = id
        self.currentTab = incomeviewType
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func expenseTracker(_ id: Int) {
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "ExpenseListViewController") as! ExpenseListViewController
        vc.expenseRequestId = id
        self.currentTab = .expanse
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func updateBadge() {
        DispatchQueue.main.async {
            if let tab = self.tabBarController as? TextyTabBarController{
                    tab.didSelectIndex(sender: tab.buttons[4])
            }
        }
    }
    func Tabpageviewcontroller(currentindex: Int, viewcontroller: UIViewController) {
        print("Current index Page : \(currentindex)")
        let currentVC = (viewcontroller as! MyInboxViewController)
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
        print(index)
    }
}

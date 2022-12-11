//
//  KRTabBar.swift
//  TextyTabBarController
//
//  Created by Kerolles Roshdi on 2/14/20.
//  Copyright © 2020 Kerolles Roshdi. All rights reserved.
//

import UIKit

@available(iOS 11.0, *)
class TextyTabBarController: UITabBarController, UITabBarControllerDelegate,BarButtonConfigarable {
    
    private let isArabic = Locale.preferredLanguages[0] == "ar" ? true : false
    
    private var selectedTab: Int = 0
    
    var buttons = [UIButton]()
    private var buttonsColors = [UIColor]()
    
    private var indexViewWidthAnchor: NSLayoutConstraint!
    private var indexViewCenterXAnchor: NSLayoutConstraint!
    
    private let customTabBarView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.init(named: "NavBar1")!
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let indexView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .orange
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    var count = 0
    override var viewControllers: [UIViewController]? {
        didSet {
            createButtonsStack(viewControllers!)
            autolayout()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.isHidden = true
        addCustomTabBarView()
        tabBar.tintColor = .white
        createButtonsStack(viewControllers)
        autolayout()
    }
    override var prefersStatusBarHidden: Bool{
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if viewControllers == nil {
            return
        }
        customTabBarView.layer.cornerRadius = customTabBarView.frame.size.height / 4.5
        indexView.layer.cornerRadius = indexView.frame.size.height / 2
        indexView.backgroundColor = buttonsColors[selectedTab]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.islangauge(self.currentLanguage()) { return}
        self.viewUpdates()
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
        dropDown.dataSource = [DefaultsManager.shared.userEmail ?? "", NSLocalizedString("language", comment: "") , NSLocalizedString("logout", comment: "")]
        
//        dropDown.backgroundColor = UIColor(named: "NavBar1")!
//        dropDown.textColor = UIColor.white
        
        
        // Action triggered on selection
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            if index == 0{
                let vc = mainStoryboard.instantiateViewController(withIdentifier: "UserProfileViewController") as! UserProfileViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else if index == 1{
                let alert = UIAlertController(title: NSLocalizedString("language", comment: ""), message: "", preferredStyle: .alert)
                let okAlert = UIAlertAction(title: "English", style: .default) { (action) in
                    CSLanguage.setAppleLAnguageTo(lang: "en")
                    AppDelegate.shared.setupRootViewController()
                }
                let arabicAlert = UIAlertAction(title: "Arabic", style: .default) { (action) in
                    CSLanguage.setAppleLAnguageTo(lang: "ar")
                    AppDelegate.shared.setupRootViewController()
                }
                let cancelAlert = UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .cancel, handler: nil)
                alert.addAction(okAlert)
                alert.addAction(arabicAlert)
                alert.addAction(cancelAlert)
                self.present(alert, animated: true, completion: nil)
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
    func showNotification(_ sender: AnyObject) {
        
    }
    
    private func createButtonsStack(_ viewControllers: [UIViewController]?) {
        
        if viewControllers == nil{
            return
        }
        
        let font = UIFont.systemFont(ofSize: 15.0)
        
        // clean :
        buttons.removeAll()
        buttonsColors.removeAll()
        
        stackView.subviews.forEach {
            $0.removeFromSuperview()
        }
        if(DefaultsManager.shared.userRole == "Manager" || DefaultsManager.shared.userRole == "FinManager"){
            self.getExpenseInbox()
        }
        for (index, viewController) in viewControllers!.enumerated() {
            if let tabBarItem = viewController.tabBarItem as? TextyTabBarItem {
                if let color = tabBarItem.color {
                    buttonsColors.append(color)
                }
                else{
                    buttonsColors.append(UIColor.white)
                }
            } else {
                fatalError("set tabBarItem number(\(index + 1)) Class as TextyTabBarItem and set its color, image and title")
            }
            if index == 4{
                let button = SYBadgeButton()
                button.tag = index
                button.addTarget(self, action: #selector(didSelectIndex(sender:)), for: .touchUpInside)
                button.setImage(viewController.tabBarItem.image, for: .normal)
                button.imageView?.tintColor = .white
                button.titleLabel?.font = font
                button.setTitleColor(UIColor.init(named: "NavBar1")!, for: .normal)
                button.titleEdgeInsets = UIEdgeInsets(top: 0, left: isArabic ? 0 : 7.5, bottom: 0, right: isArabic ? 7.5 : 0)
                button.imageEdgeInsets = UIEdgeInsets(top: 0, left: isArabic ? 0 : -7.5, bottom: 0, right: isArabic ? -7.5 : 0)
                if index == 0 {
                    self.title = viewController.tabBarItem.title
                    button.setTitle(viewController.tabBarItem.title, for: .normal)
                    button.setTitleColor(UIColor.init(named: "NavBar1")!, for: .normal)
                    button.imageView?.image?.withRenderingMode(.alwaysTemplate)
                    button.imageView?.tintColor = .black
                }
                button.badgeBackgroundColor = UIColor.clear
                button.badgeTextColor = .clear
                button.badgeValue = "\(count)"
                button.badgeRadius = 10
                button.badgeOffset = CGPoint(x: 0, y: -10)
                button.translatesAutoresizingMaskIntoConstraints = false
                stackView.addArrangedSubview(button)
                buttons.append(button)
            }
            else{
            let button = UIButton()
            button.tag = index
            button.addTarget(self, action: #selector(didSelectIndex(sender:)), for: .touchUpInside)
            button.setImage(viewController.tabBarItem.image, for: .normal)
            button.imageView?.tintColor = .white
            button.titleLabel?.font = font
            button.setTitleColor(UIColor.init(named: "NavBar1")!, for: .normal)
            button.titleEdgeInsets = UIEdgeInsets(top: 0, left: isArabic ? 0 : 7.5, bottom: 0, right: isArabic ? 7.5 : 0)
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: isArabic ? 0 : -7.5, bottom: 0, right: isArabic ? -7.5 : 0)
            if index == 0 {
                self.title = viewController.tabBarItem.title
                button.setTitle(viewController.tabBarItem.title, for: .normal)
                button.setTitleColor(UIColor.init(named: "NavBar1")!, for: .normal)
                button.imageView?.image?.withRenderingMode(.alwaysTemplate)
                button.imageView?.tintColor = .black
            }
            button.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(button)
            buttons.append(button)
            }
        }
        
        view.setNeedsLayout()
    }
    
    private func autolayout() {
        if viewControllers == nil {
            return
        }
        NSLayoutConstraint.activate([
            customTabBarView.widthAnchor.constraint(equalTo: tabBar.widthAnchor),
            customTabBarView.heightAnchor.constraint(equalTo: tabBar.heightAnchor, constant: 20),
            customTabBarView.bottomAnchor.constraint(equalTo: tabBar.bottomAnchor),
            customTabBarView.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: customTabBarView.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: customTabBarView.trailingAnchor, constant: -15),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            stackView.topAnchor.constraint(equalTo: customTabBarView.topAnchor, constant: 10),
            indexView.heightAnchor.constraint(equalToConstant: customTabBarView.bounds.height),
            indexView.centerYAnchor.constraint(equalTo: stackView.centerYAnchor)
         ])
        
        indexViewCenterXAnchor = indexView.centerXAnchor.constraint(equalTo: buttons[selectedTab].centerXAnchor)
        indexViewCenterXAnchor.isActive = true
        
        indexViewWidthAnchor = indexView.widthAnchor.constraint(equalTo: buttons[selectedTab].widthAnchor, constant: -20)
        indexViewWidthAnchor.isActive = true
    }
    
    private func addCustomTabBarView() {
        customTabBarView.frame = tabBar.frame
        indexView.frame = tabBar.frame
        view.addSubview(customTabBarView)
        
        view.bringSubviewToFront(self.tabBar)
        
        customTabBarView.addSubview(indexView)
        customTabBarView.addSubview(stackView)
        
    }
    
    @objc func didSelectIndex(sender: UIButton) {
        
        let index = sender.tag
        if(DefaultsManager.shared.userRole == "Manager" || DefaultsManager.shared.userRole == "FinManager"){
            self.getExpenseInbox()
        }
        if index == self.selectedIndex {
            if let vc = self.viewControllers?[self.selectedIndex] as? UINavigationController {
                vc.popToRootViewController(animated: true)
            }
        } else {
            
            self.selectedIndex = index
            self.selectedTab = index
            
            for (indx, button) in self.buttons.enumerated() {
                if indx != index {
                    button.setTitle(nil, for: .normal)
                    button.imageView?.image?.withRenderingMode(.alwaysTemplate)
                    button.imageView?.tintColor = .white
                    if let badgeBtn = button as? SYBadgeButton{
                        badgeBtn.badgeBackgroundColor = UIColor.clear
                        badgeBtn.badgeTextColor = .clear
                        badgeBtn.badgeValue = "\(count)"
                        badgeBtn.badgeRadius = 10
                        badgeBtn.badgeOffset = CGPoint(x: 0, y: -10)
                    }
                } else {
                    self.title = self.viewControllers![indx].tabBarItem.title
                    button.setTitle(self.viewControllers![indx].tabBarItem.title, for: .normal)
                    button.setTitleColor(UIColor.init(named: "NavBar1")!, for: .normal)
                    button.imageView?.image?.withRenderingMode(.alwaysTemplate)
                    button.imageView?.tintColor = .black
                    if let badgeBtn = button as? SYBadgeButton{
                        badgeBtn.badgeBackgroundColor = UIColor.clear
                        badgeBtn.badgeRadius = 10
                        badgeBtn.badgeTextColor = .clear
                        badgeBtn.badgeValue = "\(count)"
                        badgeBtn.badgeOffset = CGPoint(x: 0, y: -10)
                    }
                }
            }
            
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                
                self.indexView.backgroundColor = self.buttonsColors[index]
                
                self.indexViewWidthAnchor.isActive = false
                self.indexViewWidthAnchor = nil
                self.indexViewWidthAnchor = self.indexView.widthAnchor.constraint(equalTo: self.buttons[index].widthAnchor, constant: -20)
                self.indexViewWidthAnchor.isActive = true
                
                self.indexViewCenterXAnchor.isActive = false
                self.indexViewCenterXAnchor = nil
                self.indexViewCenterXAnchor = self.indexView.centerXAnchor.constraint(equalTo: self.buttons[index].centerXAnchor)
                self.indexViewCenterXAnchor.isActive = true
                
                self.view.layoutIfNeeded()
                
            }, completion: nil)
            
        }
        
    }
    
    // Delegate:
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        super.tabBar(tabBar, didSelect: item)
        guard
            let items = tabBar.items,
            let index = items.firstIndex(of: item)
            else {
                print("not found")
                return
        }
        didSelectIndex(sender: self.buttons[index])
    }
    
}
extension TextyTabBarController{
   
    //MARK: - Expense Claim Status
    private func getExpenseInbox(){
        count = 0
        //showLoader()
        ExpenseReimburseStatusTrackersAPI.apiExpenseReimburseStatusTrackersApprovalsPendingForApproverIdGet(_id: Int(DefaultsManager.shared.userID!) ?? 0) { (result, error) in
            if error == nil {
                let expenseCount = result ?? []
                self.count = self.count + expenseCount.count
                self.getAdvancenbox()
            }
            else{
                hideLoader()
                switch error as! ErrorResponse {
                case .error(let code, let result, let message):
                    print(code,result,message)
                    if code == 401 {
                        DefaultsManager.shared.accesstoken = ""
                        DefaultsManager.shared.userRole = ""
                        DefaultsManager.shared.isRemoved = false
                        AppDelegate.shared.setupRootViewController()
                    }
                    else{
                        do{
                            let json = try JSONSerialization.jsonObject(with: result!, options: .allowFragments) as! [String: AnyObject]
                             Loaf((json["message"] as! String), state: .error,location: .top, sender: self).show(.short, completionHandler: nil)
                        }
                        catch{
                            Loaf(NSLocalizedString("somthing_wrong", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
                            print("json error \(error.localizedDescription)")
                        }
                    }
                    
                }
            }
        }
    }
    
    //MARK: - Advance cash request
    private func getAdvancenbox(){
        
        ClaimApprovalStatusTrackersAPI.apiClaimApprovalStatusTrackersApprovalsPendingForApproverIdGet(_id: Int(DefaultsManager.shared.userID!) ?? 0) { (result, error) in
            
            if error == nil {
                let cashAdvanceRequest = result ?? []
                self.count = self.count + cashAdvanceRequest.count
                self.getTravelInbox()
            }
            else{
                hideLoader()
                switch error as! ErrorResponse {
                case .error(let code, let result, let message):
                    print(code,result,message)
                    if code == 401 {
                        DefaultsManager.shared.accesstoken = ""
                        DefaultsManager.shared.userRole = ""
                        DefaultsManager.shared.isRemoved = false
                        AppDelegate.shared.setupRootViewController()
                    }
                    else{
                        do{
                            let json = try JSONSerialization.jsonObject(with: result!, options: .allowFragments) as! [String: AnyObject]
                             Loaf((json["message"] as! String), state: .error,location: .top, sender: self).show(.short, completionHandler: nil)
                        }
                        catch{
                            Loaf(NSLocalizedString("somthing_wrong", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
                            print("json error \(error.localizedDescription)")
                        }
                    }
                    
                }
            }
        }
    }
    
    //MARK: - Travel Request
    
    
    private func getTravelInbox(){
        TravelApprovalStatusTrackersAPI.apiTravelApprovalStatusTrackersApprovalsPendingForApproverIdGet(_id: Int(DefaultsManager.shared.userID!) ?? 0) { (result, error) in
            hideLoader()
            if error == nil {
                let travelRequest = result ?? []
                //print("Inbox",self.inboxList)
                self.count = self.count + travelRequest.count
                DispatchQueue.main.async {
                    if let badgeBtn = self.buttons[4] as? SYBadgeButton{
                        if self.count == 0{
                            badgeBtn.badgeBackgroundColor = UIColor.clear
                            badgeBtn.badgeRadius = 5
                            badgeBtn.badgeTextColor = .clear
                            badgeBtn.badgeValue = "\(self.count)"
                            badgeBtn.badgeOffset = CGPoint(x: 0, y: -10)
                            
                        }
                        else{
                            badgeBtn.badgeBackgroundColor = UIColor.red
                            badgeBtn.badgeRadius = 5
                            badgeBtn.badgeTextColor = .white
                            badgeBtn.badgeValue = "\(self.count)"
                            badgeBtn.badgeOffset = CGPoint(x: 0, y: -10)
                        }
                    }
                }
            }
            else{
                switch error as! ErrorResponse {
                case .error(let code, let result, let message):
                    print(code,result,message)
                    if code == 401 {
                        DefaultsManager.shared.accesstoken = ""
                        DefaultsManager.shared.userRole = ""
                        DefaultsManager.shared.isRemoved = false
                        AppDelegate.shared.setupRootViewController()
                    }
                    else{
                        do{
                            let json = try JSONSerialization.jsonObject(with: result!, options: .allowFragments) as! [String: AnyObject]
                             Loaf((json["message"] as! String), state: .error,location: .top, sender: self).show(.short, completionHandler: nil)
                        }
                        catch{
                            Loaf(NSLocalizedString("somthing_wrong", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
                            print("json error \(error.localizedDescription)")
                        }
                    }
                    
                }
            }
        }
    }
}

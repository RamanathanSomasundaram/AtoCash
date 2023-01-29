//
//  DashboardViewController.swift
//  AtoCash
//
//  Created by user on 05/02/21.
//

import UIKit
import SideMenu
import Charts
class DashboardViewController: UIViewController,BarButtonConfigarable {
 
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var walletBalance: UILabel!
    
    @IBOutlet weak var lblWelcome: UILabel!
    
    var walletBal : EmpCurrentPettyCashBalanceDTO?
    var cashPieChartData : RequestCountModel?
    var travelPieChartData : RequestCountModel?
    var expensePieChartData : RequestCountModel?
    @IBOutlet weak var collectionView: UICollectionView!
    var collectionFlowLayout : UICollectionViewFlowLayout!
    var inboxChartCount = [[String:Int]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.title = "Dashboard"
        //setupUI()
        // Do any additional setup after loading the view.
        self.lblUserName.text = DefaultsManager.shared.fullName ?? ""
        self.collectionView.register(UINib(nibName: "DashboardCell", bundle: nil), forCellWithReuseIdentifier: "dashboardCell")
        setupCollectionView()
    }
    
    private func setupUI(){
        self.title = NSLocalizedString("dashboard", comment: "")
        self.lblWelcome.text = NSLocalizedString("welcome", comment: "")
        
    }
    
    func setupCollectionView()
    {
        collectionFlowLayout = UICollectionViewFlowLayout()
        collectionFlowLayout.itemSize = CGSize(width: (SCREEN_WIDTH - 20), height: 150)
        collectionFlowLayout.minimumLineSpacing = 1
        collectionFlowLayout.minimumInteritemSpacing = 1
        collectionFlowLayout.scrollDirection = .vertical
        self.collectionView.collectionViewLayout = collectionFlowLayout
        self.collectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.islangauge(self.currentLanguage()) { return}
        setupUI()
        inboxChartCount = [[String:Int]]()
        if DefaultsManager.shared.userRole == "Admin" {
            self.addBarButtonItem(ofType: .menu(.left))
            self.walletBalance.text = "0.00"
        }
        else{
            if(DefaultsManager.shared.userRole == "Manager" || DefaultsManager.shared.userRole == "FinManager"){
                self.addBarButtonItem(ofType: .menu(.left))
               
            }
            self.getWalletBalance()
            
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
        dropDown.dataSource = [DefaultsManager.shared.userEmail ?? "" ,"Logout"]
        
//        dropDown.backgroundColor = UIColor(named: "NavBar1")!
//        dropDown.textColor = UIColor.white
        
        
        // Action triggered on selection
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            if index == 0{
                let vc = mainStoryboard.instantiateViewController(withIdentifier: "UserProfileViewController") as! UserProfileViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
//            else if index == 1{
//                let alert = UIAlertController(title: "Language", message: "", preferredStyle: .alert)
//                let okAlert = UIAlertAction(title: "English", style: .default) { (action) in
//                    CSLanguage.setAppleLAnguageTo(lang: "en")
//                }
//                let arabicAlert = UIAlertAction(title: "Arabic", style: .default) { (action) in
//                    CSLanguage.setAppleLAnguageTo(lang: "ar")
//                }
//                let cancelAlert = UIAlertAction(title: "No", style: .cancel, handler: nil)
//                alert.addAction(okAlert)
//                alert.addAction(arabicAlert)
//                alert.addAction(cancelAlert)
//                self.present(alert, animated: true, completion: nil)
//            }
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
    
    
    private func getWalletBalance(){
        showLoader()
        EmpCurrentPettyCashBalancesAPI.apiEmpCurrentPettyCashBalancesGetEmpCurrentPettyCashBalanceIdGet(_id: Int(DefaultsManager.shared.userID!) ?? 0) { (result, error) in
            
            if error == nil {
                self.walletBal = result
                if let wallet = self.walletBal {
                    self.walletBalance.text = String(format: "%.2f", (wallet.curBalance ?? 0)) + " " + (DefaultsManager.shared.currencyType ?? "").uppercased()
                }
                self.getAdvanceRequestCount()
            }
            else{
                hideLoader()
                self.getAdvanceRequestCount()
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
    
    private func getAdvanceRequestCount(){
        PettyCashRequestsAPI.apiPettyCashRequestsCountAllPettyCashRequestRaisedByEmployeeIdGet(_id: Int(DefaultsManager.shared.userID!) ?? 0) { (result, error) in
            if error == nil {
                self.cashPieChartData = result
                self.getTravelRequestCount()
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
    
    private func getExpenseRequestCount(){
        ExpenseReimburseRequestsAPI.apiExpenseReimburseRequestsCountAllExpenseReimburseRequestRaisedByEmployeeIdGet(_id: Int(DefaultsManager.shared.userID!) ?? 0) { (result, error) in
            hideLoader()
            if error == nil {
                self.expensePieChartData = result
                self.getExpenseInbox()
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
    
    private func getTravelRequestCount(){
        TravelApprovalRequestsAPI.apiTravelApprovalRequestsCountAllTravelRequestRaisedByEmployeeIdGet(_id: Int(DefaultsManager.shared.userID!) ?? 0) { (result, error) in
            
            if error == nil {
                self.travelPieChartData = result
                self.getExpenseRequestCount()
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
    
    //MARK: - Expense Claim Status
    private func getExpenseInbox(){
        //showLoader()
        ExpenseReimburseStatusTrackersAPI.apiExpenseReimburseStatusTrackersApprovalsPendingForApproverIdGet(_id: Int(DefaultsManager.shared.userID!) ?? 0) { (result, error) in
            if error == nil {
                let expenseCount = result ?? []
                self.inboxChartCount.append([ NSLocalizedString("expense", comment: "") : expenseCount.count])
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
                self.inboxChartCount.append([NSLocalizedString("advance", comment: "") : cashAdvanceRequest.count])
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
                self.inboxChartCount.append([NSLocalizedString("travel", comment: "") : travelRequest.count])
                var countValue = 0
                for i in 0..<self.inboxChartCount.count{
                    let inbox = self.inboxChartCount[i]
                    let count = inbox[inbox.keys.first!]
                    countValue += (count ?? 0)
                }
//                if let tab = self.tabBarController as? TextyTabBarController{
//                    if let button = tab.buttons[4] as? SYBadgeButton{
//                        button.badgeBackgroundColor = UIColor.red
//                        //button.cornerRadius = 10.0
//                        button.badgeRadius = 10.0
//                        button.badgeTextColor = .clear
//                        button.badgeValue = "10"
//                        print("Badge Enable")
//                    }
//                }
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension DashboardViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (self.cashPieChartData == nil && self.travelPieChartData == nil && self.expensePieChartData == nil){
            return 0
        }
        return (DefaultsManager.shared.userRole == "Manager" || DefaultsManager.shared.userRole == "FinManager") ? 4 : 3
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dashboardCell", for: indexPath) as! DashboardCell
        cell.chartBtn.tag = indexPath.row
        cell.chartBtn.addTarget(self, action: #selector(chartViewAction(_:)), for: .touchUpInside)
        if indexPath.row == 0{
            cell.lblTitle.text = NSLocalizedString("advance_request", comment: "")
            if let count = self.cashPieChartData {
                cell.lblCOunt.text = "\(count.totalCount ?? 0)"
                cell.setDataCount(count)
            }
           
            cell.baseView.backgroundColor = UIColor(red: 74.0/255.0, green: 178.0/255.0, blue: 176.0/255.0, alpha: 1.0)//74,178,176
        }
        else if(indexPath.row == 1){
            cell.lblTitle.text =  NSLocalizedString("travel_request", comment: "") 
            if let count = self.travelPieChartData {
                cell.lblCOunt.text = "\(count.totalCount ?? 0)"
                cell.setDataCount(count)
            }
            cell.baseView.backgroundColor = UIColor(red: 122.0/255.0, green: 195.0/255.0, blue: 171.0/255.0, alpha: 1.0)
        }
        else if (indexPath.row == 2){
            cell.lblTitle.text =  NSLocalizedString("expense_request", comment: "")
            if let count = self.expensePieChartData {
                cell.lblCOunt.text = "\(count.totalCount ?? 0)"
                cell.setDataCount(count)
            }
           
            cell.baseView.backgroundColor = UIColor(red: 31.0/255.0, green: 147.0/255.0, blue: 214.0/255.0, alpha: 1.0)//31,147,214
        }
        else{
            cell.lblTitle.text =  NSLocalizedString("inbox", comment: "")
            var countValue = 0
            for i in 0..<self.inboxChartCount.count{
                let inbox = self.inboxChartCount[i]
                let count = inbox[inbox.keys.first!]
                countValue += (count ?? 0)
            }
            cell.lblCOunt.text = "\(countValue)"
            cell.setDataInboxCount(self.inboxChartCount)
           
            cell.baseView.backgroundColor = UIColor(red: 246.0/255.0, green: 71.0/255.0, blue: 172.0/255.0, alpha: 1.0)//246,71,172
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if let tab = self.tabBarController as? TextyTabBarController{
            switch indexPath.row{
            case 0:
                tab.didSelectIndex(sender: tab.buttons[2])
                break
            case 1:
                tab.didSelectIndex(sender: tab.buttons[3])
                break
            case 2:
                tab.didSelectIndex(sender: tab.buttons[1])
                break
            case 3:
                tab.didSelectIndex(sender: tab.buttons[4])
            default:
                break
            }
            
        }
    }
    
    @objc func chartViewAction(_ sender : UIButton){
        let vc = ChartViewController()
        let message = NSLocalizedString("no_chart", comment: "")
        switch sender.tag{
        case 0:
            if self.cashPieChartData?.totalCount == 0 {
                Loaf(NSLocalizedString("no_chart", comment: ""), state: .info, location: .top, sender: self).show(.short, completionHandler: nil)
            }
            else{
            vc.pieChartData = self.cashPieChartData
            vc.chartName = self.cashPieChartData?.totalCount == 0 ? "" : NSLocalizedString("advance_request", comment: "")
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: true, completion: nil)
            }
            break
        case 1:
            if self.travelPieChartData?.totalCount == 0 {
                Loaf(NSLocalizedString("no_chart", comment: ""), state: .info, location: .top, sender: self).show(.short, completionHandler: nil)
            }
            else{
                vc.pieChartData = self.travelPieChartData
                vc.chartName = self.travelPieChartData?.totalCount == 0 ? "" : NSLocalizedString("travel_request", comment: "")
                vc.modalPresentationStyle = .overCurrentContext
                self.present(vc, animated: true, completion: nil)
                }
            break
        case 2:
            if self.expensePieChartData?.totalCount == 0 {
                Loaf(NSLocalizedString("no_chart", comment: ""), state: .info, location: .top, sender: self).show(.short, completionHandler: nil)
            }
            else{
                vc.pieChartData = self.expensePieChartData
                vc.chartName = self.expensePieChartData?.totalCount == 0 ? "" : NSLocalizedString("expense_request", comment: "")
                vc.modalPresentationStyle = .overCurrentContext
                self.present(vc, animated: true, completion: nil)
                }
            break
        case 3:
            var countValue = 0
            for i in 0..<self.inboxChartCount.count{
                let inbox = self.inboxChartCount[i]
                let count = inbox[inbox.keys.first!]
                countValue += (count ?? 0)
            }
            if countValue == 0 {
                Loaf(NSLocalizedString("no_chart", comment: ""), state: .info, location: .top, sender: self).show(.short, completionHandler: nil)
            }
            else{
                vc.chartName = countValue == 0 ? "" : NSLocalizedString("inbox", comment: "")
                vc.inboxCount = self.inboxChartCount
                vc.modalPresentationStyle = .overCurrentContext
                self.present(vc, animated: true, completion: nil)
                }
            break
        default:
            break
        }
        
    }
}

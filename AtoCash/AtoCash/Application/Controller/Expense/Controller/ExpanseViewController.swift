//
//  ExpanseViewController.swift
//  AtoCash
//
//  Created by user on 05/02/21.
//

import UIKit

class ExpanseViewController: UIViewController ,BarButtonConfigarable,createExpenseViewDelegate {
    
    
    @IBOutlet weak var segmentControlView: CustomeSegmentedControl!
    var selectSegmentIndex = 0
    @IBOutlet weak var travelListTableView: UITableView!
    
    var travelRequestList = [ExpenseReimburseRequestDTO]()
    var expanseOffline = [offlineData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentControlView.itemTitles = [NSLocalizedString("draft", comment: ""),NSLocalizedString("submit_request", comment: "")]
        segmentControlView.selectItemAt(index: 1, animated: false)
        // Do any additional setup after loading the view.
        self.selectSegmentIndex = 1
        segmentControlView.didSelectItemWith = { (index, title) -> () in
            if self.selectSegmentIndex != index{
                _ = index == 1 ? self.getAllSubmittedRequest() : self.getOfflineData()
                self.selectSegmentIndex = index
                print("selected Index \(self.selectSegmentIndex)")
            }
            if self.selectSegmentIndex == 0{
                if let expenseData = DefaultsManager.shared.expenseRequest?.keys.first{
                    
                    if let expense = DefaultsManager.shared.expenseRequest![expenseData], expense.count > 0{
                        
                        self.expanseOffline = expense
                    }
                    else{
                        self.expanseOffline = []
                    }
                }
            }
            DispatchQueue.main.async {
                self.travelListTableView.reloadData()
            }
            
        }
        self.title = NSLocalizedString("expense_claim", comment: "")
        travelListTableView.tableFooterView = UIView()
        travelListTableView.register(UINib(nibName: "ExpenseListCell", bundle: nil), forCellReuseIdentifier: "expenseListCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.islangauge(self.currentLanguage()) { return}
        self.viewUpdates()
        
        self.title = NSLocalizedString("expense_claim", comment: "")
        if DefaultsManager.shared.userRole == "Admin" {
            self.addBarButtonItem(ofType: .menu(.left))
        }
        else{
            if(DefaultsManager.shared.userRole == "Manager" || DefaultsManager.shared.userRole == "FinManager"){
                self.addBarButtonItem(ofType: .menu(.left))
            }
            _ = self.selectSegmentIndex == 1 ? self.getAllSubmittedRequest() : self.getOfflineData()
        }
        self.addBarButtonItem(ofType: .user(.right))
        // self.addBarButtonItem2(ofType: .user(.right) , type1:.notification(.right))
        
        
        
    }
    
    func getOfflineData(){
        if self.selectSegmentIndex == 0{
            if let expenseData = DefaultsManager.shared.expenseRequest?.keys.first{
                
                if let expense = DefaultsManager.shared.expenseRequest![expenseData], expense.count > 0{
                    
                    self.expanseOffline = expense
                }
                else{
                    self.expanseOffline = []
                }
            }
        }
        DispatchQueue.main.async {
            self.travelListTableView.reloadData()
        }
        
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
                let alert = UIAlertController(title: "Logout", message: "Are you sure? You want logout this account?", preferredStyle: .alert)
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
    
    @IBAction func createtravelRequestClicked(_ sender: Any) {
        
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "CreateExpenseViewController") as! CreateExpenseViewController
        vc.modalPresentationStyle = .overCurrentContext
        vc.expenseDelegate = self
        vc.viewDetailModel = nil
        self.present(vc, animated: true, completion: nil)
        
    }
    
    func expenseViewUIupdate(_ info: [String : Any?]) {
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "ExpenseFormViewController") as! ExpenseFormViewController
        vc.UIInfo = info
        vc.editExpense = nil
        vc.isRealmSave = false
        vc.isBusiness = (selectSegmentIndex == 2)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func getAllSubmittedRequest(){
        
        showLoader()
        
        ExpenseReimburseRequestsAPI.apiExpenseReimburseRequestsGetExpenseReimburseRequestRaisedForEmployeeIdGet(_id: Int(DefaultsManager.shared.userID!) ?? 0) { (result, error) in
            hideLoader()
            if error == nil {
                self.travelRequestList = result ?? []
                DispatchQueue.main.async {
                    self.travelListTableView.reloadData()
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


extension ExpanseViewController : UITableViewDelegate,UITableViewDataSource,expenseListDelegate {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.selectSegmentIndex == 1{
            return self.travelRequestList.count
        }
        else{
            return self.expanseOffline.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "expenseListCell") as! ExpenseListCell
        
        cell.ttotalAmount.text = NSLocalizedString("total_amount", comment: "")
        cell.tCurrentStatus.text = NSLocalizedString("current_status", comment: "")
        cell.trackBtn.setTitle(NSLocalizedString("track_status", comment: ""), for: .normal)
        cell.viewEye.tag = indexPath.row
        cell.editBtn.tag = indexPath.row
        cell.deleteBtn.tag = indexPath.row
        cell.trackBtn.tag = indexPath.row
        cell.explistDelegate = self
        if self.selectSegmentIndex == 1{
            let myRequest = self.travelRequestList[indexPath.row]
            cell.lblExpenseTitle.text = " " + UtilsManager.shared.systemDateStringFromUTC(utcDate: UtilsManager.shared.systemDatetoString(myRequest.expReimReqDate!),formatOf: "dd MMM yyyy") + " "
            cell.lblDesc.text = myRequest.expenseReportTitle
            cell.lblClaimAmount.text = "\(myRequest.totalClaimAmount ?? 0.0)"
            cell.lblStatus.text = myRequest.approvalStatusType
            if myRequest.showEditDelete!{
                cell.editBtn.isHidden = false
                cell.deleteBtn.isHidden = false
                
            }
            else{
                cell.editBtn.isHidden = true
                cell.deleteBtn.isHidden = true
                
            }
            if myRequest.project != "" && myRequest.project != nil {
                cell.lblLink.text = "\(myRequest.project ?? NSLocalizedString("proj", comment: ""))"
            }
            else if myRequest.department != nil{
                cell.lblLink.text = "\(myRequest.department ?? NSLocalizedString("dept", comment: ""))"
            }
            else{
                cell.lblLink.text = NSLocalizedString("business", comment: "")
            }
        }
        else{
            if self.expanseOffline.count > 0{
                let myRequest = self.expanseOffline[indexPath.row]
                cell.lblExpenseTitle.text = " " + UtilsManager.shared.systemDateStringFromUTC(utcDate: UtilsManager.shared.systemDatetoString(myRequest.expenseDate!),formatOf: "dd MMM yyyy") + " "
                cell.lblDesc.text = myRequest.expenseTitle
                cell.lblClaimAmount.text = "\(myRequest.totalAmount ?? 0.0)"
                cell.lblStatus.isHidden = false
                cell.editBtn.isHidden = false
                cell.deleteBtn.isHidden = false
                if myRequest.project?.projectName != "" && myRequest.project != nil {
                    cell.lblLink.text = "\(myRequest.project?.projectName ?? NSLocalizedString("proj", comment: ""))"
                }
                else if (myRequest.isBusiness ?? false) && !(myRequest.isDepart ?? false){
                    cell.lblLink.text = NSLocalizedString("dept", comment: "")
                }
                else{
                    cell.lblLink.text = NSLocalizedString("business", comment: "")
                }
                
                cell.lblStatus.text = NSLocalizedString("draft_record", comment: "")
                cell.viewEye.isHidden = true
                cell.trackBtn.isHidden = true
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let animation = AnimationFactory.makeMoveUpWithBounce(rowHeight: cell.frame.height, duration: 1.0, delayFactor: 0.05)
        //let animation = AnimationFactory.makeMoveUpWithFade(rowHeight: cell.frame.height, duration: 1.0, delayFactor: 0.05)
        let animator = Animator(animation: animation)
        animator.animate(cell: cell, at: indexPath, in: tableView)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func viewDetailsExpense(_ sender: Int) {
        let myRequest = self.travelRequestList[sender]
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "ExpenseListViewController") as! ExpenseListViewController
        vc.expenseRequestId = myRequest._id!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func editActionTag(_ sender: Int) {
        if self.selectSegmentIndex == 1 {
            let myRequest = self.travelRequestList[sender]
            let vc = mainStoryboard.instantiateViewController(withIdentifier: "ExpenseFormViewController") as! ExpenseFormViewController
            vc.UIInfo = [:]
            vc.editExpense = myRequest
            vc.isRealmSave = false
            vc.isBusiness = myRequest.isBusinessAreaReq ?? false
            vc.isProject = myRequest.isBusinessAreaReq ?? true
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else{
            let vc = mainStoryboard.instantiateViewController(withIdentifier: "ExpenseFormViewController") as! ExpenseFormViewController
            vc.UIInfo = [:]
            vc.editOfflineData = self.expanseOffline[sender]
            vc.isOffline = true
            vc.editOfflineDataIndex = sender
            vc.isBusiness = self.expanseOffline[sender].isBusiness ?? false
            vc.isProject = !(self.expanseOffline[sender].isBusiness ?? false)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    func deleteActionTag(_ sender: Int) {
        
        let alert = UIAlertController(title: NSLocalizedString("delete", comment: ""), message: NSLocalizedString("delete_alert", comment: ""), preferredStyle: .alert)
        let okAlert = UIAlertAction(title: NSLocalizedString("yes", comment: ""), style: .destructive) { (action) in
            if self.selectSegmentIndex == 1 {
                self.deleteTravelRequest(deleteCenter: self.travelRequestList[sender])
            }
            else{
                if let expenseData = DefaultsManager.shared.expenseRequest?.keys.first{
                    if let expense = DefaultsManager.shared.expenseRequest![expenseData], expense.count > 0{
                        self.expanseOffline.remove(at: sender)
                        DefaultsManager.shared.expenseRequest?[DefaultsManager.shared.userID!] = self.expanseOffline
                        DispatchQueue.main.async {
                            self.travelListTableView.reloadData()
                        }
                    }
                }
            }
        }
        let cancelAlert = UIAlertAction(title: NSLocalizedString("no", comment: ""), style: .cancel, handler: nil)
        alert.addAction(okAlert)
        alert.addAction(cancelAlert)
        self.present(alert, animated: true, completion: nil)
        
        
    }
    func viewActionTag(_ sender: Int) {
        let myRequest = self.travelRequestList[sender]
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "TrackViewController") as! TrackViewController
        vc.trackStatusType = .expanse
        vc.trackerRequestId = myRequest._id!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func deleteTravelRequest(deleteCenter : ExpenseReimburseRequestDTO){
        showLoader()
        ExpenseReimburseRequestsAPI.apiExpenseReimburseRequestsDeleteExpenseReimburseRequestIdDelete(_id: deleteCenter._id!) { (result, error) in
            hideLoader()
            if error == nil {
                Loaf(NSLocalizedString("claim_delete_toast", comment: ""), state: .success, location: .top, sender: self).show(.short, completionHandler: nil)
                DispatchQueue.main.async {
                    self.getAllSubmittedRequest()
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
                            Loaf((json["message"] as! String), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
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

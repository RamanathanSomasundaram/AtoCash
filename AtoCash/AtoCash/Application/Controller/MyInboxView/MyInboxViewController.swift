//
//  MyInboxViewController.swift
//  AtoCash
//
//  Created by user on 04/04/21.
//

import UIKit


protocol IncomeboxMoveTracker : NSObjectProtocol {
    func incomeboxTracker(_ id : Int, incomeviewType : TrackStatusType)
    func expenseTracker(_ id: Int)
    func updateBadge()
}

class MyInboxViewController: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    var inboxList = [TravelApprovalStatusTrackerDTO]()
    var inboxviewType : TrackStatusType = .travel
    var currentIndex : Int?
    var approvalStatus = [ApprovalStatusType]()
    var cashAdvanceRequest = [ClaimApprovalStatusTrackerDTO]()
    var expenseRequest = [ExpenseReimburseStatusTrackerDTO]()
    
    weak var incomDelegate : IncomeboxMoveTracker?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tblView.tableFooterView = UIView()
        tblView.register(UINib(nibName: "MyInboxCell", bundle: nil), forCellReuseIdentifier: myInboxCell)
        
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //getInbox()
        switch inboxviewType {
        case .advance:
            self.currentIndex = nil
            self.getAdvancenbox()
            break
        case .expanse:
            self.currentIndex = nil
            self.getExpenseInbox()
            break
        case .travel:
            self.currentIndex = nil
            self.getTravelInbox()
            break
        }
        self.getApprovalStatusType()
    }
    
    func getApprovalStatusType(){
        ApprovalStatusTypesAPI.apiApprovalStatusTypesGet { (result, error) in
            if error == nil {
                self.approvalStatus = result ?? []
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
    
    //MARK: - Expense Claim Status
    private func getExpenseInbox(){
        showLoader()
        ExpenseReimburseStatusTrackersAPI.apiExpenseReimburseStatusTrackersApprovalsPendingForApproverIdGet(_id: Int(DefaultsManager.shared.userID!) ?? 0) { (result, error) in
            hideLoader()
            if error == nil {
                self.expenseRequest = result ?? []
                //print("Inbox",self.inboxList)
                DispatchQueue.main.async {
                    self.tblView.reloadData()
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
    
    
    func acceptExpenseRequest(_ comment : String){
        if currentIndex == nil && approvalStatus.count == 0{
            Loaf(NSLocalizedString("somthing_wrong", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
            return
        }
        
        let statusUpdate = self.approvalStatus.filter { (statusResult) -> Bool in
            return  statusResult.status == (comment == "" ? "Approved" : "Rejected")
        }
        
        
        showLoader()
        let travelAccept = self.expenseRequest[currentIndex!]
        
        ExpenseReimburseStatusTrackersAPI.apiExpenseReimburseStatusTrackersPutExpenseReimburseStatusTrackerPut(body: [ExpenseReimburseStatusTrackerDTO(_id: travelAccept._id, employeeId: Int(DefaultsManager.shared.userID!) ?? 0, employeeName: DefaultsManager.shared.fName! + " " + DefaultsManager.shared.lName!, businessTypeId: travelAccept.businessTypeId,businessUnitId: travelAccept.businessUnitId,expenseReimburseRequestId: travelAccept.expenseReimburseRequestId, currencyTypeId: travelAccept.currencyTypeId, currencyType: travelAccept.currencyType, totalClaimAmount: travelAccept.totalClaimAmount, expReimReqDate: travelAccept.expReimReqDate, departmentId: travelAccept.departmentId, department: travelAccept.department, projectId: travelAccept.projectId, project: travelAccept.project, workTaskId: travelAccept.workTaskId, workTask: travelAccept.workTask, subProjectId: travelAccept.subProjectId, subProject: travelAccept.subProject, approvalGroupId: travelAccept.approvalGroupId, approvalLevelId: travelAccept.approvalLevelId, jobRoleId: travelAccept.jobRoleId, jobRole: travelAccept.jobRole, approvalStatusType: (statusUpdate.count > 0 ? statusUpdate.first!.status : travelAccept.approvalStatusType), approvalStatusTypeId: (statusUpdate.count > 0 ? statusUpdate.first!._id! : travelAccept.approvalStatusTypeId), approvedDate: travelAccept.approvedDate, comments: comment)]) { (result, error) in

            hideLoader()
            if error == nil {
                let message = comment == "" ? NSLocalizedString("expense_approve_status", comment: "") : NSLocalizedString("expense_reject_status", comment: "")
                Loaf(message, state: .success, location: .top, sender: self).show(.short, completionHandler: nil)
                self.getExpenseInbox()
                self.incomDelegate?.updateBadge()
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
    
    
    
    //MARK: - Advance cash request
    private func getAdvancenbox(){
        showLoader()
        
        ClaimApprovalStatusTrackersAPI.apiClaimApprovalStatusTrackersApprovalsPendingForApproverIdGet(_id: Int(DefaultsManager.shared.userID!) ?? 0) { (result, error) in
            hideLoader()
            if error == nil {
                self.cashAdvanceRequest = result ?? []
                //print("Inbox",self.inboxList)
                DispatchQueue.main.async {
                    self.tblView.reloadData()
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
    
    
    func acceptAdvanceRequest(_ comment : String){
        if currentIndex == nil && approvalStatus.count == 0{
            Loaf(NSLocalizedString("somthing_wrong", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
            return
        }
        
        let statusUpdate = self.approvalStatus.filter { (statusResult) -> Bool in
            return  statusResult.status == (comment == "" ? "Approved" : "Rejected")
        }
        
        
        showLoader()
        let cashAccept = self.cashAdvanceRequest[currentIndex!]
        /*
         [{"id":59,"employeeId":40002,"employeeName":"Sign 11000","cashAdvanceRequestId":38,"businessType":"Stores","businessTypeId":1002,"businessUnit":"Sign Anas In Malek:20001","businessUnitId":101,"projectId":null,"projectName":null,"subProjectId":null,"subProjectName":null,"workTaskId":null,"workTask":null,"approvalGroupId":null,"jobRoleId":602,"jobRole":"STOR-ROLE-MGR:Store-Manager","approvalLevelId":2,"requestDate":"2023-01-29T17:37:20.329665Z","approverEmpId":null,"approverActionDate":null,"approvalStatusTypeId":4,"approvalStatusType":"Approved","claimAmount":1000,"comments":""}]
         */
        ClaimApprovalStatusTrackersAPI.apiClaimApprovalStatusTrackersPutClaimApprovalStatusTrackerPut(body: [ClaimApprovalStatusTrackerDTO(_id: cashAccept._id!, employeeId: Int(DefaultsManager.shared.userID!) ?? 0 , employeeName:  DefaultsManager.shared.fName! + " " + DefaultsManager.shared.lName!,businessType: cashAccept.businessType,businessUnit: cashAccept.businessUnit,businessTypeId: cashAccept.businessTypeId,businessUnitId: cashAccept.businessUnitId, cashAdvanceRequestId: cashAccept.cashAdvanceRequestId, departmentId: cashAccept.departmentId, departmentName: cashAccept.departmentName, projectId: cashAccept.projectId, projectName: cashAccept.projectName, subProjectId: cashAccept.subProjectId, subProjectName: cashAccept.subProjectName, workTaskId: cashAccept.workTaskId, workTask: cashAccept.workTask, roleId: cashAccept.roleId, jobRole: cashAccept.jobRole, approvalLevelId: cashAccept.approvalLevelId, reqDate: cashAccept.reqDate, finalApprovedDate: cashAccept.finalApprovedDate, approvalStatusTypeId: (statusUpdate.count > 0 ? statusUpdate.first!._id! : cashAccept.approvalStatusTypeId), approvalStatusType: (statusUpdate.count > 0 ? statusUpdate.first!.status : cashAccept.approvalStatusType), comments: comment,claimAmount: cashAccept.claimAmount)]) { (result, error) in
            hideLoader()
            if error == nil {
                let message = comment == "" ? NSLocalizedString("cash_approve_status", comment: "") : NSLocalizedString("cash_reject_status", comment: "")
                Loaf(message, state: .success, location: .top, sender: self).show(.short, completionHandler: nil)
                self.getAdvancenbox()
                self.incomDelegate?.updateBadge()
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
    
    
    //MARK: - Travel Request
    
    
    private func getTravelInbox(){
        showLoader()
        TravelApprovalStatusTrackersAPI.apiTravelApprovalStatusTrackersApprovalsPendingForApproverIdGet(_id: Int(DefaultsManager.shared.userID!) ?? 0) { (result, error) in
            hideLoader()
            if error == nil {
                self.inboxList = result ?? []
                //print("Inbox",self.inboxList)
                DispatchQueue.main.async {
                    self.tblView.reloadData()
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
    
    
    func accepttravelRequest(_ comment : String){
        if currentIndex == nil && approvalStatus.count == 0{
            Loaf(NSLocalizedString("somthing_wrong", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
            return
        }
        
        let statusUpdate = self.approvalStatus.filter { (statusResult) -> Bool in
            return  statusResult.status == (comment == "" ? "Approved" : "Rejected")
        }
        
        
        showLoader()
        let travelAccept = self.inboxList[currentIndex!]
        TravelApprovalStatusTrackersAPI.apiTravelApprovalStatusTrackersPutTravelApprovalStatusTrackerPut(body: [TravelApprovalStatusTrackerDTO(_id: travelAccept._id, employeeId: Int(DefaultsManager.shared.userID!) ?? 0, employeeName: DefaultsManager.shared.fName! + " " + DefaultsManager.shared.lName!, businessTypeId: travelAccept.businessTypeId,businessUnitId: travelAccept.businessUnitId,travelApprovalRequestId: travelAccept.travelApprovalRequestId, travelStartDate: travelAccept.travelStartDate, travelEndDate: travelAccept.travelEndDate, departmentId: travelAccept.departmentId, departmentName: travelAccept.departmentName, projectId: travelAccept.projectId, projectName: travelAccept.projectName, roleId: travelAccept.roleId, jobRole: travelAccept.jobRole, approvalLevelId: travelAccept.approvalLevelId, reqDate: travelAccept.reqDate, finalApprovedDate: travelAccept.finalApprovedDate, approvalStatusTypeId: (statusUpdate.count > 0 ? statusUpdate.first!._id! : travelAccept.approvalStatusTypeId), approvalStatusType: (statusUpdate.count > 0 ? statusUpdate.first!.status : travelAccept.approvalStatusType), comments: comment)]) { (result, error) in
            hideLoader()
            if error == nil {
                let message = comment == "" ? NSLocalizedString("travel_approve_status", comment: "") : NSLocalizedString("travel_reject_status", comment: "")
                Loaf(message, state: .success, location: .top, sender: self).show(.short, completionHandler: nil)
                self.getTravelInbox()
                self.incomDelegate?.updateBadge()
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
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension MyInboxViewController : UITableViewDelegate,UITableViewDataSource,myInboxDetailDelegate,popupDismissDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch inboxviewType {
        case .advance:
            return self.cashAdvanceRequest.count
        case .expanse:
            return self.expenseRequest.count
        case .travel:
            return self.inboxList.count
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: myInboxCell) as! MyInboxCell
        cell.ytRequestDate.text = NSLocalizedString("request_date", comment: "")
        cell.approveBtn.setTitle(NSLocalizedString("approve", comment: ""), for: .normal)
        cell.rejectBtn.setTitle(NSLocalizedString("rej", comment: ""), for: .normal)
        cell.deleteBtn.setTitle(NSLocalizedString("moreinfo", comment: ""), for: .normal)
        switch inboxviewType {
        case .advance:
            let incomeMsg = self.cashAdvanceRequest[indexPath.row]
            let businessTitle = "Business Type: " + (incomeMsg.businessType ?? "")
            cell.lblTitle.text = " " + (((incomeMsg.projectName != nil) ? incomeMsg.projectName : businessTitle)!) + " "
            
            cell.stackHeight.constant = 40.0
            cell.amountStackView.isHidden = true
            cell.lblReqDate.text = UtilsManager.shared.systemDateStringFromUTC(utcDate: UtilsManager.shared.systemDatetoString(incomeMsg.reqDate!),formatOf: "dd MMM yyyy")
            cell.approveBtn.tag = indexPath.row
            cell.rejectBtn.tag = indexPath.row
            cell.deleteBtn.tag = indexPath.row
            cell.lblEmpName.text =  "Business unit: " + (incomeMsg.businessUnit ?? "") + "\n" + "Location: " + (incomeMsg.location ?? "") + "\n" + "Name: " + (incomeMsg.employeeName ?? "")
            cell.eyeBtn.tag = indexPath.row
            cell.eyeBtn.isHidden = true
            cell.inboxDelegate =  self
        case .expanse:
            let incomeMsg = self.expenseRequest[indexPath.row]
            let businessTitle = "Business Type: " + (incomeMsg.businessType ?? "")
            cell.lblTitle.text = " " + ((((incomeMsg.department != nil) ? incomeMsg.department : incomeMsg.project != nil ? incomeMsg.project : businessTitle)!)) + " "
            
            cell.stackHeight.constant = 40.0
            cell.amountStackView.isHidden = true
            cell.lblReqDate.text = UtilsManager.shared.systemDateStringFromUTC(utcDate: UtilsManager.shared.systemDatetoString(incomeMsg.expReimReqDate!),formatOf: "dd MMM yyyy")
            cell.approveBtn.tag = indexPath.row
            cell.rejectBtn.tag = indexPath.row
            cell.deleteBtn.tag = indexPath.row
            cell.lblEmpName.text =  "Business unit: " + (incomeMsg.businessUnit ?? "") + "\n" + "Location: " + (incomeMsg.location ?? "") + "\n" + "Name: " + (incomeMsg.employeeName ?? "")
            cell.inboxDelegate =  self
            cell.eyeBtn.tag = indexPath.row
            cell.eyeBtn.isHidden = false
        case .travel:
            let incomeMsg = self.inboxList[indexPath.row]
            let businessTitle = "Business Type: " + (incomeMsg.businessType ?? "")
            cell.lblTitle.text = " " + (((incomeMsg.projectName != nil) ? (incomeMsg.projectName ?? "") : businessTitle)!) + " "
            
            cell.stackHeight.constant = 40.0
            cell.amountStackView.isHidden = true
            cell.lblReqDate.text = UtilsManager.shared.systemDateStringFromUTC(utcDate: UtilsManager.shared.systemDatetoString(incomeMsg.reqDate!),formatOf: "dd MMM yyyy")
            cell.approveBtn.tag = indexPath.row
            cell.rejectBtn.tag = indexPath.row
            cell.deleteBtn.tag = indexPath.row
            cell.lblEmpName.text =  "Business unit: " + (incomeMsg.businessUnit ?? "") + "\n" + "Location: " + (incomeMsg.location ?? "") + "\n" + "Name: " + (incomeMsg.employeeName ?? "")
            cell.inboxDelegate =  self
            cell.eyeBtn.tag = indexPath.row
            cell.eyeBtn.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
           let animation = AnimationFactory.makeMoveUpWithBounce(rowHeight: cell.frame.height, duration: 1.0, delayFactor: 0.05)
           let animator = Animator(animation: animation)
           animator.animate(cell: cell, at: indexPath, in: tableView)
       }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func acceptTagAction(_ sender: Int) {
        self.currentIndex = sender
        let alert = UIAlertController(title: NSLocalizedString("approve", comment: ""), message: NSLocalizedString("approve_request", comment: ""), preferredStyle: .alert)
        let okAlert = UIAlertAction(title: NSLocalizedString("yes", comment: ""), style: .default) { (action) in
            switch self.inboxviewType {
            case .advance:
                self.acceptAdvanceRequest("")
            case .expanse:
                self.acceptExpenseRequest("")
                break
            case .travel:
                self.accepttravelRequest("")
            }
        }
        let cancelAlert = UIAlertAction(title: NSLocalizedString("no", comment: ""), style: .cancel, handler: nil)
        alert.addAction(okAlert)
        alert.addAction(cancelAlert)
        self.present(alert, animated: true, completion: nil)
        
    }
    func eyeTagAction(_ sender: Int) {
        let incomeMsg = self.expenseRequest[sender]
        if (self.incomDelegate != nil){
            self.incomDelegate?.expenseTracker(incomeMsg.expenseReimburseRequestId!)
        }
    }
    
    func rejectTagAction(_ sender: Int) {
        self.currentIndex = sender
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "PopupViewController") as! PopupViewController
        vc.modalPresentationStyle = .overFullScreen
        vc.rejectDelegate = self
        self.present(vc, animated: true, completion: nil)
        
    }
    
    func didRejectAction(_ text: String) {
        switch inboxviewType {
        case .advance:
            self.acceptAdvanceRequest(text)
        case .expanse:
            self.acceptExpenseRequest(text)
            break
        case .travel:
            self.accepttravelRequest(text)
        }
    }
    func deleteTagAction(_ sender: Int) {
        self.currentIndex = sender
        switch inboxviewType {
        case .advance:
            self.incomDelegate?.incomeboxTracker(self.cashAdvanceRequest[sender].cashAdvanceRequestId!, incomeviewType: .advance)
            break
        case .expanse:
            self.incomDelegate?.incomeboxTracker(self.expenseRequest[sender].expenseReimburseRequestId!, incomeviewType: .expanse)
            break
        case .travel:
            self.incomDelegate?.incomeboxTracker(self.inboxList[sender].travelApprovalRequestId!, incomeviewType: .travel)
            break
        }
        
    }
    
    
}

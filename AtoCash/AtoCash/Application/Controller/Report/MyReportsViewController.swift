//
//  MyReportsViewController.swift
//  AtoCash
//
//  Created by user on 05/05/21.
//

import UIKit
protocol reportsMoveTracker : NSObjectProtocol {
    func reportsTracker(_ id : Int, reportViewType : TrackStatusType)
    func expensereportsTracker(_ id: Int)
}
class MyReportsViewController: UIViewController {

    @IBOutlet weak var filterHeight: NSLayoutConstraint!
    @IBOutlet weak var filterView: CSCustomViewCell!
    @IBOutlet weak var tblView: UITableView!
    var inboxList = [TravelApprovalStatusTrackerDTO]()
    var inboxviewType : TrackStatusType = .travel
    var currentIndex : Int?
    var cashAdvanceRequest = [ReportsModel]()
    var expenseRequest = [ReportsModel]()
    var travelRequest = [TravelApprovalReportDTO]()
    
    var isReportView : Bool = false
    
    weak var incomDelegate : reportsMoveTracker?
    override func viewDidLoad() {
        super.viewDidLoad()
        filterView.isHidden = true
        filterHeight.constant = 0.0
        // Do any additional setup after loading the view.
        tblView.tableFooterView = UIView()
        tblView.register(UINib(nibName: "MyReportCell", bundle: nil), forCellReuseIdentifier: "myreportCell")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        //getInbox()
        switch inboxviewType {
        case .advance://maanger report true , need my report manager false
            self.currentIndex = nil
            let params = CashAndClaimRequestSearchModel(LoggedEmpId: Int(DefaultsManager.shared.userID!) ?? 0, IsManager: isReportView, requestTypeId: 1, ReporteeEmpId: nil)
            self.getAdvancenbox(params)
            break
        case .expanse:
            self.currentIndex = nil
            let params = CashAndClaimRequestSearchModel(LoggedEmpId: Int(DefaultsManager.shared.userID!) ?? 0, IsManager: isReportView, requestTypeId: 2, ReporteeEmpId: nil)
            self.getExpenseInbox(params)
            break
        case .travel:
            self.currentIndex = nil
            let params = TravelRequestSearchModel(LoggedEmpId:Int(DefaultsManager.shared.userID!) ?? 0, IsManager: isReportView,ReporteeEmpId: nil)
            self.getTravelInbox(params)
            break
        }
    }
    
    //MARK: - Expense Claim Status
    private func getExpenseInbox(_ reportModel : CashAndClaimRequestSearchModel){
        showLoader()
        ReportsAPI.apiReportsGetAdvanceAndReimburseReportsEmployeeJsonPost(body: reportModel) { (result, error) in
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
    
    
    
    
    //MARK: - Advance cash request
    private func getAdvancenbox(_ reportModel : CashAndClaimRequestSearchModel){
        showLoader()
        //https://atocashdev.ml/api/Reports/GetAdvanceAndReimburseReportsEmployeeJson
        
        ReportsAPI.apiReportsGetAdvanceAndReimburseReportsEmployeeJsonPost(body: reportModel) { (result, error) in
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
    
    
    
    //MARK: - Travel Request
    
    
    private func getTravelInbox(_ reportModel : TravelRequestSearchModel){
        showLoader()
        
        ReportsAPI.apiReportsGetTravelRequestReportForEmployeeJsonPost(body: reportModel) { (result, error) in
            hideLoader()
            if error == nil {
                self.travelRequest = result ?? []
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension MyReportsViewController : UITableViewDelegate,UITableViewDataSource,myReportDelegate {
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
            return self.travelRequest.count
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myreportCell") as! MyReportCell
        
        cell.moreBtn.setTitle(NSLocalizedString("moreinfo", comment: ""), for: .normal)
        cell.lblEndDate.textAlignment = .defaultAlignment
        cell.lblStartDate.textAlignment = .defaultAlignment
        cell.lblStatus.textAlignment = .defaultAlignment
        cell.lblReqId.textAlignment = .defaultAlignment
        cell.lblReqDate.textAlignment = .defaultAlignment
        cell.lblTitle.textAlignment = .defaultAlignment
        cell.lblName.textAlignment = .defaultAlignment
        cell.tEndDate.text = NSLocalizedString("end_date", comment: "")
        cell.tStartDate.text = NSLocalizedString("start_date", comment: "")
        cell.tStatusType.text = NSLocalizedString("statustype", comment: "")
        cell.tRequestDate.text = NSLocalizedString("request_date", comment: "")
        cell.tRequestID.text = NSLocalizedString("request_id", comment: "")
        switch inboxviewType {
        case .advance:
            let incomeMsg = self.cashAdvanceRequest[indexPath.row]
            cell.lblTitle.text = "Business Type : " + (incomeMsg.businessType ?? "")
            
            cell.startDateView.isHidden = true
            cell.endDateView.isHidden = true
            cell.lblStatus.text = incomeMsg.approvalStatusType ?? ""
            cell.lblReqId.text = "\(incomeMsg.id ?? 0) "
            cell.lblReqDate.text = UtilsManager.shared.systemDateStringFromUTC(utcDate: UtilsManager.shared.systemDatetoString(incomeMsg.requestDate!),formatOf: "dd MMM yyyy")
            cell.moreBtn.tag = indexPath.row
            cell.lblName.text = incomeMsg.employeeName
            cell.eyeBtn.tag = indexPath.row
            cell.eyeBtn.isHidden = true
            cell.reportDelegate =  self
        case .expanse:
            let incomeMsg = self.expenseRequest[indexPath.row]
            cell.lblTitle.text = incomeMsg.requestTitleDescription
            
            cell.startDateView.isHidden = true
            cell.endDateView.isHidden = true
            cell.lblStatus.text = incomeMsg.approvalStatusType ?? ""
            cell.lblReqId.text = "\(incomeMsg.id ?? 0) "
            cell.lblReqDate.text = UtilsManager.shared.systemDateStringFromUTC(utcDate: UtilsManager.shared.systemDatetoString(incomeMsg.requestDate!),formatOf: "dd MMM yyyy")
//            cell.lblReqDate.text = incomeMsg.requestDate!
            cell.moreBtn.tag = indexPath.row
            cell.lblName.text = incomeMsg.employeeName
            cell.eyeBtn.tag = indexPath.row
            cell.eyeBtn.isHidden = false
            cell.reportDelegate =  self
        case .travel:
            let incomeMsg = self.travelRequest[indexPath.row]
            cell.lblTitle.text = "Business Type : " + (incomeMsg.businessType ?? "")
            cell.eyeBtn.tag = indexPath.row
            cell.eyeBtn.isHidden = true
            cell.startDateView.isHidden = true
            cell.endDateView.isHidden = true
//            cell.lblStartDate.text = UtilsManager.shared.systemDateStringFromUTC(utcDate: UtilsManager.shared.systemDatetoString(incomeMsg.travelStartDate!),formatOf: "dd MMM yyyy")
//            cell.lblEndDate.text = UtilsManager.shared.systemDateStringFromUTC(utcDate: UtilsManager.shared.systemDatetoString(incomeMsg.travelStartDate!),formatOf: "dd MMM yyyy")
            cell.lblStatus.text = incomeMsg.approvalStatusType ?? ""
            cell.lblReqId.text = "\(incomeMsg.id ?? 0) "
            cell.lblReqDate.text = UtilsManager.shared.systemDateStringFromUTC(utcDate: UtilsManager.shared.systemDatetoString(incomeMsg.requestDate!),formatOf: "dd MMM yyyy")
            cell.moreBtn.tag = indexPath.row
            cell.lblName.text = incomeMsg.employeeName
            cell.eyeBtn.tag = indexPath.row
            cell.reportDelegate =  self
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
    
    func eyeTagAction(_ sender: Int) {
        self.navigationController?.navigationBar.isHidden = false
        let incomeMsg = self.expenseRequest[sender]
        if (self.incomDelegate != nil){
            self.incomDelegate?.expensereportsTracker(incomeMsg.blendedRequestId!)
        }
    }
    
    func moreTagAction(_ sender : Int){
        self.navigationController?.navigationBar.isHidden = false
        self.currentIndex = sender
        switch inboxviewType {
        case .advance:
            self.incomDelegate?.reportsTracker(self.cashAdvanceRequest[sender].blendedRequestId!, reportViewType: .advance)
            break
        case .expanse:
            self.incomDelegate?.reportsTracker(self.expenseRequest[sender].blendedRequestId!, reportViewType: .expanse)
            break
        case .travel:
            self.incomDelegate?.reportsTracker(self.travelRequest[sender].id!, reportViewType: .travel)
            break
        }
        
    }
}

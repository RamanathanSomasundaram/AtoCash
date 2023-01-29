//
//  TrackViewController.swift
//  AtoCash
//
//  Created by user on 18/04/21.
//

import UIKit

enum TrackStatusType{
    case travel
    case advance
    case expanse
}

class TrackViewController: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    var trackStatusType : TrackStatusType = .travel
    var trackerRequestId : Int = 0
    
    var travelRequestTrackList = [ApprovalStatusFlowVM]()
    var travelRequestData : TravelApprovalRequestDTO?
    var cashRequestData : PettyCashRequestDTO?
    var expenseData : ExpenseReimburseRequestDTO?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let backBtn = UIBarButtonItem(image: UIImage.init(named: "back"), style: .plain, target: self, action: #selector(BackButtonTapped))
        backBtn.tintColor = .white
    
        self.navigationItem.leftBarButtonItem = backBtn
        tblView.tableFooterView = UIView()
        tblView.register(UINib(nibName: "TrackCell", bundle: nil), forCellReuseIdentifier: "trackCell")
        tblView.register(UINib(nibName: "TrackDetailCell", bundle: nil), forCellReuseIdentifier: "trackDetailCell")
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.islangauge(self.currentLanguage()) { return}
        self.viewUpdates()
        self.setupUI()
    }
    
    private func setupUI(){
        switch self.trackStatusType {
        case .advance:
            self.title = NSLocalizedString("advace_track", comment: "")
            self.getAdvanceRequestTracker()
            break
        case .expanse:
            self.title = NSLocalizedString("expense_track", comment: "")
            self.getExpenseRequestTracker()
            break
        case .travel:
            self.title = NSLocalizedString("travel_track", comment: "")
            self.getTravelRequestTracker()
            break
        }
    }
    
    
    //BAckbutton Action
    @objc func BackButtonTapped(){
        //Pop to home view controller
        self.navigationController?.popViewController(animated: true)
    }
    //MARK: - Expense Track
    func getExpenseRequestTracker(){
        showLoader()
        
        ExpenseReimburseStatusTrackersAPI.apiExpenseReimburseStatusTrackersApprovalFlowForRequestIdGet(_id: self.trackerRequestId, completion: { (result, error) in
            hideLoader()
            if error == nil {
                self.travelRequestTrackList = result ?? []
                self.getExpenseApprovalData()
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
                            print("json error \(error.localizedDescription)")
                        }
                    }
                    
                }
            }
        })
    }
    
    
    private func getExpenseApprovalData(){
        showLoader()
        
        ExpenseReimburseRequestsAPI.apiExpenseReimburseRequestsGetExpenseReimburseRequestIdGet(_id: self.trackerRequestId) { (result, error) in
            hideLoader()
            if error == nil {
                self.expenseData = result
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
                            print("json error \(error.localizedDescription)")
                        }
                    }
                    
                }
            }
        }
    }
    
    //MARK: - Advance Track
    func getAdvanceRequestTracker(){
        showLoader()
        
        ClaimApprovalStatusTrackersAPI.apiClaimApprovalStatusTrackersApprovalFlowForRequestIdGet(_id: self.trackerRequestId) { (result, error) in
            hideLoader()
            if error == nil {
                self.travelRequestTrackList = result ?? []
                self.getAdvanceApprovalData()
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
                            print("json error \(error.localizedDescription)")
                        }
                    }
                    
                }
            }
        }
    }
    
    
    private func getAdvanceApprovalData(){
        showLoader()
        PettyCashRequestsAPI.apiPettyCashRequestsGetPettyCashRequestIdGet(_id: self.trackerRequestId) { (result, error) in
            hideLoader()
            if error == nil {
                self.cashRequestData = result
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
                            print("json error \(error.localizedDescription)")
                            Loaf(NSLocalizedString("somthing_wrong", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
                        }
                    }
                    
                }
            }
        }
    }
    
    //MARK: - Travel Track
    
    func getTravelRequestTracker(){
        showLoader()
        TravelApprovalStatusTrackersAPI.apiTravelApprovalStatusTrackersApprovalFlowForTravelRequestIdGet(_id: self.trackerRequestId) { (result, error) in
            hideLoader()
            if error == nil {
                self.travelRequestTrackList = result ?? []
                self.getTravelApprovalData()
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
    
    
    private func getTravelApprovalData(){
        showLoader()
        TravelApprovalRequestsAPI.apiTravelApprovalRequestsGetTravelApprovalRequestIdGet(_id: self.trackerRequestId) { (result, error) in
            hideLoader()
            if error == nil {
                self.travelRequestData = result
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
extension TrackViewController : UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        switch self.trackStatusType {
        case .advance:
            return 2
        case .expanse:
            
            if self.travelRequestTrackList.count > 0{
                let req = self.travelRequestTrackList.filter { (reject) -> Bool in
                    return reject.approvalStatusType == "Rejected"
                }
                if req.count > 0{
                    return 3
                }
                else{
                    return 2
                }
            }
           return 2
        case .travel:
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.trackStatusType {
        case .advance:
            if section == 1{
                return (self.cashRequestData == nil ? 0 : 1)
            }
            return self.travelRequestTrackList.count
        case .expanse:
            if section == 1{
                return (self.expenseData == nil ? 0 : 1)
            }
            return self.travelRequestTrackList.count
        case .travel:
            if section == 1{
                return (self.travelRequestData == nil ? 0 : 1)
            }
            if section == 0{
                return self.travelRequestTrackList.count
            }
            else{
                return 1
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "trackCell") as! TrackCell
            let trackRequest = self.travelRequestTrackList[indexPath.row]
            cell.lblRoleName.text = trackRequest.approverRole
            cell.lblApprovalName.text = trackRequest.approverName
            switch trackRequest.approvalStatusType {
            case "Pending":
                cell.statusIcon.image = UIImage(named: trackImageName.pending.rawValue)
                cell.lblLine.backgroundColor = UIColor.lightGray
                break
            case "Initiated":
                //Initative
                cell.statusIcon.image = UIImage(named: trackImageName.initative.rawValue)
                cell.lblLine.backgroundColor = UIColor.lightGray
                break
            case "Approved":
                cell.statusIcon.image = UIImage(named: trackImageName.approval.rawValue)
                cell.lblLine.backgroundColor = UIColor(named: "TrackColorSuccess")
                //approve
                break
            default:
                cell.statusIcon.image = UIImage(named: trackImageName.reject.rawValue)
                cell.lblLine.backgroundColor = UIColor.lightGray
                //reject
                break
            }
            if indexPath.row == self.travelRequestTrackList.count - 1{
                cell.lblLine.isHidden = true
            }
            else{
                cell.lblLine.isHidden = false
            }
            
            return cell
        }
        else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "trackDetailCell") as! TrackDetailCell
            let currentStatus = NSLocalizedString("current_status", comment: "")
            let dept = NSLocalizedString("dept", comment: "")
            let proj = NSLocalizedString("proj", comment: "")
            cell.tRequestDate.text = NSLocalizedString("request_amount", comment: "")
            cell.tRequestId.text = NSLocalizedString("request_id", comment: "")
            cell.tStartDate.text = NSLocalizedString("start_date_title", comment: "")
            cell.tEndDate.text = NSLocalizedString("end_date_title", comment: "")
            switch self.trackStatusType {
                
            case .advance:
                cell.lbltitle.text = NSLocalizedString("track_status_cash", comment: "")
                cell.lblStatus.text = currentStatus + " " + (self.cashRequestData!.approvalStatusType ?? "")
//                cell.lblStartDate.text =
//                cell.lblEnddate.text =
                cell.stackView.isHidden = true
                cell.stackHeight.constant = 0
                cell.lblDesc.text = self.cashRequestData!.cashAdvanceRequestDesc ?? ""
                let businessTitle = "Business Type: " + (self.cashRequestData!.businessType ?? "") + "\n" + "Business unit: " + (self.cashRequestData!.businessUnit ?? "") + "\n" + "Location: " + (self.cashRequestData!.location ?? "")
                cell.lblDept.text = ((self.cashRequestData?.project != nil) ? proj + " : " + self.cashRequestData!.project! : businessTitle)
                cell.lblEmpName.text = self.cashRequestData?.employeeName ?? ""
                cell.requestStactHeight.constant = 80.0
                cell.lblRequestId.text = "\(self.trackerRequestId)"
                cell.lblRequestAmount.text = "\(self.cashRequestData?.cashAdvanceAmount ?? 0)"
                break
            case .expanse:
                
                cell.lbltitle.text = NSLocalizedString("track_status_expense", comment: "")
                cell.lblStatus.text = currentStatus + " " + (self.expenseData!.approvalStatusType ?? "")
                cell.stackView.isHidden = true
                cell.stackHeight.constant = 0
                cell.lblDesc.text = self.expenseData!.expenseReportTitle ?? ""
                let businessTitle = "Business Type: " + (self.expenseData!.businessType ?? "") + "\n" + "Business unit: " + (self.expenseData!.businessUnit ?? "") + "\n" + "Location: " + (self.expenseData!.location ?? "")
                cell.lblDept.text = ((self.expenseData?.project != nil) ? proj + " : " + self.expenseData!.project! : businessTitle)
                
                cell.lblEmpName.text = self.expenseData?.employeeName ?? ""
                cell.requestStactHeight.constant = 80.0
                cell.lblRequestId.text = "\(self.trackerRequestId)"
                cell.lblRequestAmount.text = "\(self.expenseData?.totalClaimAmount ?? 0)"
               break
            case .travel:
                
                cell.lbltitle.text = NSLocalizedString("track_status_travel", comment: "")
                cell.lblStatus.text = currentStatus + " " +  (self.travelRequestData!.approvalStatusType ?? "")
                cell.lblStartDate.text = UtilsManager.shared.systemDateStringFromUTC(utcDate: UtilsManager.shared.systemDatetoString(self.travelRequestData!.travelStartDate!),formatOf: "dd MMM yyyy")
                cell.lblEnddate.text = UtilsManager.shared.systemDateStringFromUTC(utcDate: UtilsManager.shared.systemDatetoString(self.travelRequestData!.travelEndDate!),formatOf: "dd MMM yyyy")
                cell.lblDesc.text = self.travelRequestData!.travelPurpose
                let businessTitle = "Business Type: " + (self.travelRequestData!.businessType ?? "") + "\n" + "Business unit: " + (self.travelRequestData!.businessUnit ?? "") + "\n" + "Location: " + (self.travelRequestData!.location ?? "")
                cell.lblDept.text = ((self.travelRequestData?.project != nil) ? proj + " : " + self.travelRequestData!.project! : businessTitle)
                cell.lblEmpName.text = self.travelRequestData?.employeeName ?? ""
                cell.requestStactHeight.constant = 0.0
                break
                
                
            }
            return cell
        }
        else{
            
            
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
           let animation = AnimationFactory.makeMoveUpWithBounce(rowHeight: cell.frame.height, duration: 1.0, delayFactor: 0.05)
           let animator = Animator(animation: animation)
           animator.animate(cell: cell, at: indexPath, in: tableView)
       }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

//
//  travelRequestViewController.swift
//  AtoCash
//
//  Created by Vinothini on 17/04/21.
//

import UIKit

class travelRequestViewController: UIViewController,BarButtonConfigarable {
    
    
    @IBOutlet weak var travelListTableView: UITableView!
    
    var travelRequestList = [TravelApprovalRequestDTO]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = NSLocalizedString("travel_title", comment: "")
        travelListTableView.tableFooterView = UIView()
        travelListTableView.register(UINib(nibName: "MyRequestCell", bundle: nil), forCellReuseIdentifier: myRequestCell)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.islangauge(self.currentLanguage()) { return}
        self.viewUpdates()
        self.title = NSLocalizedString("travel_title", comment: "")
        
        
        if DefaultsManager.shared.userRole == "Admin" {
            self.addBarButtonItem(ofType: .menu(.left))
        }
        else{
            if(DefaultsManager.shared.userRole == "Manager" || DefaultsManager.shared.userRole == "FinManager"){
                self.addBarButtonItem(ofType: .menu(.left))
            }
            getAllSubmittedRequest()
        }
        self.addBarButtonItem(ofType: .user(.right))
        //self.addBarButtonItem2(ofType: .user(.right) , type1:.notification(.right))
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
    
    @IBAction func createtravelRequestClicked(_ sender: Any) {
        
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "CreatetravelRequestViewController") as! CreatetravelRequestViewController
        vc.viewDetailModel = nil
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func getAllSubmittedRequest(){
        
        showLoader()
        TravelApprovalRequestsAPI.apiTravelApprovalRequestsGetTravelApprovalRequestRaisedForEmployeeIdGet(_id: Int(DefaultsManager.shared.userID!) ?? 0) { (result, error) in
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
}


extension travelRequestViewController : UITableViewDelegate,UITableViewDataSource,myRequestDetailDelegate {
   
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.travelRequestList.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: myRequestCell) as! MyRequestCell
        let myRequest = self.travelRequestList[indexPath.row]
        cell.viewDetailBtn.setTitle(NSLocalizedString("track_status", comment: ""), for: .normal)
        cell.lblReqAmount.text =  " " + UtilsManager.shared.systemDateStringFromUTC(utcDate: UtilsManager.shared.systemDatetoString(myRequest.travelStartDate!),formatOf: "dd MMM yyyy") + " - " + UtilsManager.shared.systemDateStringFromUTC(utcDate: UtilsManager.shared.systemDatetoString(myRequest.travelEndDate!),formatOf: "dd MMM yyyy") + " "
        cell.editDeleteView.isHidden = !myRequest.showEditDelete!
        cell.lblReqName.text = myRequest.travelPurpose ?? ""
        cell.lblCurrency.isHidden = true
        cell.lblReqDate.isHidden = false
        cell.lblReqDate.text = myRequest.approvalStatusType
        cell.lblReqDate.textColor = myRequest.approvalStatusType == "Approved" ? UIColor(named: "Approve") : myRequest.approvalStatusType == "Rejected" ? UIColor(named: "RejectApprove") : myRequest.approvalStatusType == "Pending" ? UIColor(named: "NavBar") : UIColor.lightGray
        cell.lblReqDate.font = UIFont.boldSystemFont(ofSize: 17.0)
        cell.viewDetailBtn.tag = indexPath.row
        cell.linkIcon.isHidden = true
        cell.linkStatus.isHidden = true
        cell.requestDelegate = self
        cell.editBtnAction.tag = indexPath.row
        cell.deleteAction.tag = indexPath.row
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
           let animation = AnimationFactory.makeMoveUpWithBounce(rowHeight: cell.frame.height, duration: 1.0, delayFactor: 0.05)
           let animator = Animator(animation: animation)
           animator.animate(cell: cell, at: indexPath, in: tableView)
       }
    
    func editDetailsTagAction(_ sender: Int) {
        let myRequest = self.travelRequestList[sender]
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "CreatetravelRequestViewController") as! CreatetravelRequestViewController
        vc.viewDetailModel = myRequest
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func deleteDetailsTagAction(_ sender: Int) {
        let alert = UIAlertController(title: NSLocalizedString("delete", comment: ""), message: NSLocalizedString("delete_alert", comment: ""), preferredStyle: .alert)
        let okAlert = UIAlertAction(title: NSLocalizedString("yes", comment: ""), style: .destructive) { (action) in
            self.deleteTravelRequest(deleteCenter: self.travelRequestList[sender])
        }
        let cancelAlert = UIAlertAction(title: NSLocalizedString("no", comment: ""), style: .cancel, handler: nil)
        alert.addAction(okAlert)
        alert.addAction(cancelAlert)
        self.present(alert, animated: true, completion: nil)
    }
    
    func viewDetailsTagAction(_ sender: Int) {
        let myRequest = self.travelRequestList[sender]
        
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "TrackViewController") as! TrackViewController
        vc.trackStatusType = .travel
        vc.trackerRequestId = myRequest._id!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func deleteTravelRequest(deleteCenter : TravelApprovalRequestDTO){
        showLoader()
        
        TravelApprovalRequestsAPI.apiTravelApprovalRequestsDeleteTravelApprovalRequestIdDelete(_id: deleteCenter._id!) { (result, error) in
            hideLoader()
            if error == nil {
                Loaf(NSLocalizedString("travel_request_delete", comment: ""), state: .success, location: .top, sender: self).show(.short, completionHandler: nil)
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

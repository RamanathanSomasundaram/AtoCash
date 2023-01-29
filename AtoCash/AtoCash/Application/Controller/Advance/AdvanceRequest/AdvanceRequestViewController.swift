//
//  AdvanceRequestViewController.swift
//  AtoCash
//
//  Created by user on 19/03/21.
//

import UIKit

class AdvanceRequestViewController: UIViewController,BarButtonConfigarable {

    @IBOutlet weak var tblView: UITableView!
    var selectSegmentIndex = 0
    var getAdvanceRequests = [PettyCashRequestDTO]()
    override func viewDidLoad() {
        super.viewDidLoad()        
        self.title = NSLocalizedString("adance_title", comment: "")
        tblView.tableFooterView = UIView()
        tblView.register(UINib(nibName: "MyRequestCell", bundle: nil), forCellReuseIdentifier: myRequestCell)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if islangauge(currentLanguage()) { return}
        self.viewUpdates()
        self.setupUI()
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
    
    private func setupUI(){
        self.title = NSLocalizedString("adance_title", comment: "")
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
    
    func getAllSubmittedRequest(){
        
        showLoader()
        PettyCashRequestsAPI.apiPettyCashRequestsGetPettyCashRequestRaisedForEmployeeIdGet(_id: Int(DefaultsManager.shared.userID!) ?? 0) { (result, error) in
            hideLoader()
            if error == nil {
                self.getAdvanceRequests = result ?? []
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

    
    @IBAction func createAction(_ sender: Any) {
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "CreateAdvanceRequestViewController") as! CreateAdvanceRequestViewController
        vc.viewDetailModel = nil
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
extension AdvanceRequestViewController : UITableViewDelegate,UITableViewDataSource,myRequestDetailDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.getAdvanceRequests.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: myRequestCell) as! MyRequestCell
        cell.viewDetailBtn.tag = indexPath.row
        cell.requestDelegate = self
        cell.viewDetailBtn.setTitle(NSLocalizedString("track_status", comment: ""), for: .normal)
        let myRequest = self.getAdvanceRequests[indexPath.row]
        let request = NSLocalizedString("request_amt", comment: "")
        cell.lblReqAmount.text = " \(request) \(myRequest.cashAdvanceAmount!) "
        cell.lblReqName.text = myRequest.cashAdvanceRequestDesc
        cell.lblReqDate.text =  UtilsManager.shared.systemDateStringFromUTC(utcDate: UtilsManager.shared.systemDatetoString(myRequest.cashReqDate ?? Date()))
        cell.lblCurrency.text = myRequest.currencyType
        cell.editBtnAction.tag = indexPath.row
        cell.deleteAction.tag = indexPath.row
        //cell.editDeleteView.isHidden = true
        cell.editDeleteView.isHidden = !myRequest.showEditDelete!
        if myRequest.showEditDelete!{
            cell.editDeleteView.isHidden = false
        }
        if myRequest.project != "" && myRequest.project != nil {
            cell.linkStatus.text = myRequest.project
        }
        else{
            let businessTitle = "Business Type: " + (myRequest.businessType ?? "") + "\n" + "Business unit: " + (myRequest.businessUnit ?? "") + "\n" + "Location: " + (myRequest.location ?? "")
            cell.linkStatus.text = businessTitle
        }
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
           let animation = AnimationFactory.makeMoveUpWithBounce(rowHeight: cell.frame.height, duration: 1.0, delayFactor: 0.05)
           let animator = Animator(animation: animation)
           animator.animate(cell: cell, at: indexPath, in: tableView)
       }

    func editDetailsTagAction(_ sender: Int) {
        let myRequest = self.getAdvanceRequests[sender]
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "CreateAdvanceRequestViewController") as! CreateAdvanceRequestViewController
        vc.viewDetailModel = myRequest
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func deleteDetailsTagAction(_ sender: Int) {
        let alert = UIAlertController(title: NSLocalizedString("delete", comment: ""), message: NSLocalizedString("delete_alert", comment: ""), preferredStyle: .alert)
        let okAlert = UIAlertAction(title: NSLocalizedString("yes", comment: ""), style: .destructive) { (action) in
            self.deleteCashRequest(deleteCenter: self.getAdvanceRequests[sender])
        }
        let cancelAlert = UIAlertAction(title: NSLocalizedString("no", comment: ""), style: .cancel, handler: nil)
        alert.addAction(okAlert)
        alert.addAction(cancelAlert)
        self.present(alert, animated: true, completion: nil)
    }
    func viewDetailsTagAction(_ sender: Int) {
        let myRequest = self.getAdvanceRequests[sender]
        
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "TrackViewController") as! TrackViewController
        vc.trackStatusType = .advance
        vc.trackerRequestId = myRequest._id!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func deleteCashRequest(deleteCenter : PettyCashRequestDTO){
        showLoader()
        
        PettyCashRequestsAPI.apiCashRequestsDeleteCashApprovalRequestIdDelete(_id: deleteCenter._id!) { (result, error) in
            hideLoader()
            if error == nil {
                Loaf(NSLocalizedString("cash_request_delete", comment: ""), state: .success, location: .top, sender: self).show(.short, completionHandler: nil)
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

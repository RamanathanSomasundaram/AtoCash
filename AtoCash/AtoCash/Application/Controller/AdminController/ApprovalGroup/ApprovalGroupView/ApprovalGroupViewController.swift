//
//  ApprovalGroupViewController.swift
//  AtoCash
//
//  Created by user on 12/03/21.
//

import UIKit

class ApprovalGroupViewController: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    var getCostCenter = [ApprovalGroup]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tblView.tableFooterView = UIView()
        self.tblView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: reuseCell)
        self.getCostCenter = []
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getAllCostCenters()
    }
    
    func getAllCostCenters(){
        showLoader()
        ApprovalGroupsAPI.apiApprovalGroupsGetApprovalGroupsGet { (result, error) in
            hideLoader()
            if error == nil {
                self.getCostCenter = result ?? []
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
    
    @IBAction func profileAction(_ sender: Any) {
        
    }
    @IBAction func menuAction(_ sender: UIBarButtonItem) {
        self.present(SideMenuManager.default.leftMenuNavigationController!, animated: true, completion: nil)
    }
    
    @IBAction func notificationAction(_ sender: Any) {
    }
    
    @IBAction func createAction(_ sender: Any) {
        let vc = adminStoryboard.instantiateViewController(withIdentifier: "CreateApprovalGroupViewController") as! CreateApprovalGroupViewController
        vc.editApprovalGroup = nil
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
extension ApprovalGroupViewController : UITableViewDataSource,UITableViewDelegate, customCellButtonActionDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.getCostCenter.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseCell) as! CustomCell
        cell.customActionDelegate = self
        cell.editBtn.tag = indexPath.row
        cell.deleteBtn.tag = indexPath.row
        cell.statusIcon.isHidden = true
        cell.statusLbl.isHidden = true
        cell.lblProductId.text = " " + getCostCenter[indexPath.row].approvalGroupCode + " "
        cell.lblDetailDesc.text = getCostCenter[indexPath.row].approvalGroupDesc
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func editActionTag(_ sender: Int) {
        
        let vc = adminStoryboard.instantiateViewController(withIdentifier: "CreateApprovalGroupViewController") as! CreateApprovalGroupViewController
        vc.editApprovalGroup = getCostCenter[sender]
        self.navigationController?.pushViewController(vc, animated: true)
        print("Edit row \(sender)")
    }
    func deleteActionTag(_ sender: Int) {
        print("Delete row \(sender)")
        let alert = UIAlertController(title: "Delete", message: "Are you sure? You want delete this record?", preferredStyle: .alert)
        let okAlert = UIAlertAction(title: "yes", style: .destructive) { (action) in
            self.deleteCostCenter(deleteCenter: self.getCostCenter[sender])
        }
        let cancelAlert = UIAlertAction(title: "no", style: .cancel, handler: nil)
        alert.addAction(okAlert)
        alert.addAction(cancelAlert)
        self.present(alert, animated: true, completion: nil)
    }
    
    func deleteCostCenter(deleteCenter : ApprovalGroup){
        showLoader()
        ApprovalGroupsAPI.apiApprovalGroupsDeleteApprovalGroupIdDelete(_id: deleteCenter._id!) { (result, error) in
            hideLoader()
            if error == nil {
                Loaf("Approval Group deleted successfully", state: .success, location: .top, sender: self).show(.short, completionHandler: nil)
                DispatchQueue.main.async {
                    self.getAllCostCenters()
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

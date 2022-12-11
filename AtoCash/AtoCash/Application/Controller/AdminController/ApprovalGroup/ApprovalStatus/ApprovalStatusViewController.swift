//
//  ApprovalStatusViewController.swift
//  AtoCash
//
//  Created by user on 12/03/21.
//

import UIKit

class ApprovalStatusViewController: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    var getCostCenter = [ApprovalStatusType]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tblView.tableFooterView = UIView()
        self.tblView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: reuseCell)
        self.getCostCenter = []
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getAllCostCenters()
    }
    
    func getAllCostCenters(){
        showLoader()
        ApprovalStatusTypesAPI.apiApprovalStatusTypesGet { (result, error) in
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
        let vc = adminStoryboard.instantiateViewController(withIdentifier: "CreateApprovalStatusViewController") as! CreateApprovalStatusViewController
        vc.editApprovalStatus = nil
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
extension ApprovalStatusViewController : UITableViewDataSource,UITableViewDelegate, customCellButtonActionDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.getCostCenter.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseCell) as! CustomCell
        cell.customActionDelegate = self
        cell.editBtn.tag = indexPath.row
        cell.deleteBtn.tag = indexPath.row
       // cell.lblDesc.text = "Approval status type Description"
        cell.lblProductId.text = getCostCenter[indexPath.row].status
        cell.lblDetailDesc.text = getCostCenter[indexPath.row].statusDesc
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func editActionTag(_ sender: Int) {
        
        let vc = adminStoryboard.instantiateViewController(withIdentifier: "CreateApprovalStatusViewController") as! CreateApprovalStatusViewController
        vc.editApprovalStatus = getCostCenter[sender]
        self.navigationController?.pushViewController(vc, animated: true)
        print("Edit row \(sender)")
    }
    func deleteActionTag(_ sender: Int) {
        print("Delete row \(sender)")
        self.deleteCostCenter(deleteCenter: getCostCenter[sender])
    }
    
    func deleteCostCenter(deleteCenter : ApprovalStatusType){
        showLoader()
        ApprovalStatusTypesAPI.apiApprovalStatusTypesIdDelete(_id: deleteCenter._id!) { (result, error) in
            hideLoader()
            if error == nil {
                Loaf("Approval status type deleted successfully", state: .success, location: .top, sender: self).show(.short, completionHandler: nil)
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
//        showLoader()
//        networking.setAuthorizationHeader(token: DefaultsManager.shared.accesstoken ?? "")
//        networking.delete(APPROVAL_STATUS_TYPE + "/\(deleteCenter.id!)", parameters: nil) { (result) in
//            hideLoader()
//            do{
//            switch result {
//            case .success(let response):
//                print("responseModel \(response)")
//                Loaf("Employee Type deleted successfully", state: .success, location: .top, sender: self).show(.short, completionHandler: nil)
//                self.getAllCostCenters()
//                
//            break
//            case .failure(let error):
//                if error.statusCode == 401{
//                    DefaultsManager.shared.accesstoken = ""
//                    DefaultsManager.shared.userRole = ""
//                    AppDelegate.shared.setupRootViewController()
//                }
//                print("error \(error.fullResponse)")
//                break
//            }
//            }
//            
//        }
    }
}


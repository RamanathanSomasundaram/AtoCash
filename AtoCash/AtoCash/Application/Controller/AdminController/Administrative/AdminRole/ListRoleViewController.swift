//
//  ListRoleViewController.swift
//  AtoCash
//
//  Created by user on 14/03/21.
//

import UIKit

class ListRoleViewController: UIViewController {
    var adminRoles = [AdminRoleModel]()
    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblView.tableFooterView = UIView()
        self.tblView.register(UINib(nibName: "AdminCell", bundle: nil), forCellReuseIdentifier: adminReuseCell)
        self.adminRoles = []
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getAllCostCenters()
    }
    
    func getAllCostCenters(){
//        showLoader()
//        networking.setAuthorizationHeader(token: DefaultsManager.shared.accesstoken ?? "")
//        networking.get(ADMIN_LISTROLES) { result in
//            hideLoader()
//            switch result {
//            case .success(let response):
//                do{
//                let jsonDecoder = JSONDecoder()
//                    let responseModel = try jsonDecoder.decode([AdminRoleModel].self, from: response.data)
//                    self.adminRoles = responseModel
//                    DispatchQueue.main.async {
//                        self.tblView.reloadData()
//                    }
//                }
//                catch {
//                    print("Decoding Error \(error)")
//                }
//                // Do something with JSON, you can also get arrayBody
//            case .failure(let response):
//                // Handle error
//            print("error \(response)")
//                self.adminRoles = []
//                DispatchQueue.main.async {
//                    self.tblView.reloadData()
//                }
//                if response.statusCode == 401{
//                    DefaultsManager.shared.accesstoken = ""
//                    DefaultsManager.shared.userRole = ""
//                    AppDelegate.shared.setupRootViewController()
//                }
//                Loaf(response.fullResponse.description, state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
//            }
//        }
    }
    
    @IBAction func profileAction(_ sender: Any) {
        
    }
    @IBAction func menuAction(_ sender: UIBarButtonItem) {
        self.present(SideMenuManager.default.leftMenuNavigationController!, animated: true, completion: nil)
    }
    
    @IBAction func notificationAction(_ sender: Any) {
    }
    
    @IBAction func createAction(_ sender: Any) {
        let vc = adminStoryboard.instantiateViewController(withIdentifier: "EditRoleViewController") as! EditRoleViewController
        vc.editAdminRole = nil
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
extension ListRoleViewController : UITableViewDataSource,UITableViewDelegate, adminCellDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.adminRoles.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: adminReuseCell) as! AdminCell
        cell.adminDelegate = self
        cell.editBtn.tag = indexPath.row
        cell.deleteBtn.tag = indexPath.row
        cell.lblTitle.text = adminRoles[indexPath.row].name
        cell.userIcon.isHighlighted = true
        
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func editActionTag(_ sender: Int) {
        
        let vc = adminStoryboard.instantiateViewController(withIdentifier: "EditRoleViewController") as! EditRoleViewController
        vc.editAdminRole = adminRoles[sender]
        self.navigationController?.pushViewController(vc, animated: true)
        print("Edit row \(sender)")
    }
    func deleteActionTag(_ sender: Int) {
        print("Delete row \(sender)")
        self.deleteCostCenter(deleteCenter: adminRoles[sender])
    }
    
    func deleteCostCenter(deleteCenter : AdminRoleModel){
//        showLoader()
//        networking.setAuthorizationHeader(token: DefaultsManager.shared.accesstoken ?? "")
//        networking.delete(DELETE_ADMIN_ROLE + "/\(deleteCenter.id!)", parameters: nil) { (result) in
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


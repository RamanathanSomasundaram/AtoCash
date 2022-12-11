//
//  DepartmentViewController.swift
//  AtoCash
//
//  Created by user on 11/03/21.
//

import UIKit

class DepartmentViewController: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    var getDepatmentModel = [DepartmentDTO]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tblView.tableFooterView = UIView()
        self.tblView.register(UINib(nibName: dropDownCellName, bundle: nil), forCellReuseIdentifier: reuseDropDown)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getDepartments()
    }
    
    
    private func getDepartments(){
        
        showLoader()
        SwaggerClientAPI.customHeaders = ["Authorization" : "bearer \(DefaultsManager.shared.accesstoken ?? "")"]
        DepartmentsAPI.apiDepartmentsGetDepartmentsGet { (departmentList, error) in
            hideLoader()
            if error == nil {
                self.getDepatmentModel = departmentList ?? []
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
                             Loaf((json["message"] as! String), state: .error,location: .top, sender: self).show(.short, completionHandler: nil)
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
        let vc = adminStoryboard.instantiateViewController(withIdentifier: "CreateDepartmentViewController") as! CreateDepartmentViewController
        vc.editDepartMent = nil
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
extension DepartmentViewController : UITableViewDataSource,UITableViewDelegate, customCellDropdownDelegate{
   
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.getDepatmentModel.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseDropDown) as! CustomCellDropDown
        cell.linkIcon.isHighlighted = false
        cell.editBtn.tag = indexPath.row
        cell.deleteBtn.tag = indexPath.row
        cell.lblProductId.text = " " + self.getDepatmentModel[indexPath.row].deptCode! + " "
        cell.lblDescDetail.text = self.getDepatmentModel[indexPath.row].deptName
        cell.lblSelectDescDetail.text = self.getDepatmentModel[indexPath.row].costCenter
        cell.statusIcon.backgroundColor = getDepatmentModel[indexPath.row].statusType == "Active" ? UIColor(named: "Approve") : UIColor.lightGray
        cell.lblStatus.text = getDepatmentModel[indexPath.row].statusType
        cell.customDropDownDelegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func editActionTag(_ sender: Int) {
        let vc = adminStoryboard.instantiateViewController(withIdentifier: "CreateDepartmentViewController") as! CreateDepartmentViewController
        vc.editDepartMent = getDepatmentModel[sender]
        self.navigationController?.pushViewController(vc, animated: true)
        print("Edit row \(sender)")
    }
    func deleteActionTag(_ sender: Int) {
        print("Delete row \(sender)")
        let alert = UIAlertController(title: "Delete", message: "Are you sure? You want delete this record", preferredStyle: .alert)
        let okAlert = UIAlertAction(title: "Delete", style: .destructive) { (action) in
            self.deleteCostCenter(deleteCenter: self.getDepatmentModel[sender])
        }
        let cancelAlert = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(okAlert)
        alert.addAction(cancelAlert)
        self.present(alert, animated: true, completion: nil)
       
    }
    func viewActionTag(_ sender: Int) {
        
    }
    
    func deleteCostCenter(deleteCenter : DepartmentDTO){
        showLoader()
        DepartmentsAPI.apiDepartmentsDeleteDepartmentIdDelete(_id: deleteCenter._id!) { (result, error) in
            hideLoader()
            if error == nil {
                Loaf("Department deleted successfully", state: .success, location: .top, sender: self).show(.short, completionHandler: nil)
                DispatchQueue.main.async {
                    self.getDepartments()
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
                            print("json error \(error.localizedDescription)")
                        }
                    }
                    
                }
            }
        }
    }
}

//
//  EmployeeViewController.swift
//  AtoCash
//
//  Created by user on 11/03/21.
//

import UIKit

class EmployeeViewController: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    var getDepatmentModel = [EmployeeModel]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tblView.tableFooterView = UIView()
        self.tblView.register(UINib(nibName: "CustomCellDropDown", bundle: nil), forCellReuseIdentifier: reuseDropDown)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getEmployee()
    }
    
    
    private func getEmployee(){
//        showLoader()
//        networking.setAuthorizationHeader(token: DefaultsManager.shared.accesstoken ?? "")
//        networking.get(EMPLOYEES) { result in
//            hideLoader()
//            switch result {
//            case .success(let response):
//                do{
//                let jsonDecoder = JSONDecoder()
//                    let responseModel = try jsonDecoder.decode([EmployeeModel].self, from: response.data)
//                    self.getDepatmentModel = responseModel
//                }
//                catch {
//                    print("Decoding Error \(error)")
//                }
//                DispatchQueue.main.async {
//                    self.tblView.reloadData()
//                }
//                // Do something with JSON, you can also get arrayBody
//            case .failure(let response):
//                // Handle error
//            print("error \(response)")
//                self.getDepatmentModel = []
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
        let vc = adminStoryboard.instantiateViewController(withIdentifier: "CreateEmployeeViewController") as! CreateEmployeeViewController
        vc.editEmployeeModel = nil
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
extension EmployeeViewController : UITableViewDataSource,UITableViewDelegate, customCellDropdownDelegate{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.getDepatmentModel.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseDropDown) as! CustomCellDropDown
        cell.editBtn.tag = indexPath.row
        cell.deleteBtn.tag = indexPath.row
       // cell.viewMoreBtn.isHidden = false
        //cell.viewMoreHeight.constant = 30
        cell.lblProductId.text = self.getDepatmentModel[indexPath.row].empCode
        //cell.lblDesc.text = "Email Address"
        cell.lblDescDetail.text = self.getDepatmentModel[indexPath.row].email
        //cell.lblSelectDesc.text = "Employee full Name"
        cell.lblSelectDescDetail.text = self.getDepatmentModel[indexPath.row].firstName! + " " + self.getDepatmentModel[indexPath.row].lastName!
        cell.customDropDownDelegate = self
        return cell
    }
    
    func editActionTag(_ sender: Int) {
        let vc = adminStoryboard.instantiateViewController(withIdentifier: "CreateEmployeeViewController") as! CreateEmployeeViewController
        vc.editEmployeeModel = getDepatmentModel[sender]
        self.navigationController?.pushViewController(vc, animated: true)
        print("Edit row \(sender)")
    }
    func deleteActionTag(_ sender: Int) {
        print("Delete row \(sender)")
        self.deleteCostCenter(deleteCenter: getDepatmentModel[sender])
    }
    func viewActionTag(_ sender: Int) {
        let vc = adminStoryboard.instantiateViewController(withIdentifier: "EmployeeViewDetailController") as! EmployeeViewDetailController
        vc.editEmployeeModel = getDepatmentModel[sender]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func deleteCostCenter(deleteCenter : EmployeeModel){
//        showLoader()
//        networking.setAuthorizationHeader(token: DefaultsManager.shared.accesstoken ?? "")
//        networking.delete(DELETE_EMPLOYEE + "\(deleteCenter.id!)", parameters: nil) { (result) in
//            hideLoader()
//            do{
//            switch result {
//            case .success(let response):
//                print("responseModel \(response)")
//                Loaf("Department deleted successfully", state: .success, location: .top, sender: self).show(.short, completionHandler: nil)
//                self.getEmployee()
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

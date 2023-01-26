//
//  ProjectViewController.swift
//  AtoCash
//
//  Created by user on 11/03/21.
//

import UIKit

class ProjectViewController: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    var getDepatmentModel = [ProjectModel]()
    var getCostCenter = [CostCenterModel]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tblView.tableFooterView = UIView()
        self.tblView.register(UINib(nibName: "CustomCellDropDown", bundle: nil), forCellReuseIdentifier: reuseDropDown)
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getDepartments()
    }
    
    
    private func getDepartments(){
//        showLoader()
//        networking.setAuthorizationHeader(token: DefaultsManager.shared.accesstoken ?? "")
//        networking.get(PROJECTS) { result in
//            hideLoader()
//            switch result {
//            case .success(let response):
//                do{
//                let jsonDecoder = JSONDecoder()
//                    let responseModel = try jsonDecoder.decode([ProjectModel].self, from: response.data)
//                    self.getDepatmentModel = responseModel
//                    self.getAllCostCenters()
//                }
//                catch {
//                    print("Decoding Error \(error)")
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
    private func getAllCostCenters(){
//        showLoader()
//        networking.setAuthorizationHeader(token: DefaultsManager.shared.accesstoken ?? "")
//        networking.get(COSTCENTER) { result in
//            hideLoader()
//            switch result {
//            case .success(let response):
//                do{
//                let jsonDecoder = JSONDecoder()
//                    let responseModel = try jsonDecoder.decode([CostCenterModel].self, from: response.data)
//                    self.getCostCenter = responseModel
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
//                self.getCostCenter = []
//                DispatchQueue.main.async {
//                    self.tblView.reloadData()
//                }
//                if response.statusCode == 401{
//                    DefaultsManager.shared.accesstoken = ""
//                    DefaultsManager.shared.userRole = ""
//                    AppDelegate.shared.setupRootViewController()
//                }
//
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
        let vc = adminStoryboard.instantiateViewController(withIdentifier: "CreateProjectViewController") as! CreateProjectViewController
        vc.editProjectModel = nil
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
extension ProjectViewController : UITableViewDataSource,UITableViewDelegate, customCellDropdownDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.getDepatmentModel.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseDropDown) as! CustomCellDropDown
        cell.editBtn.tag = indexPath.row
        cell.deleteBtn.tag = indexPath.row
        //cell.viewMoreBtn.isHidden = true
        //cell.viewMoreHeight.constant = 0
        cell.lblProductId.text = self.getDepatmentModel[indexPath.row].projectName
        //cell.lblDesc.text = "Project Description"
        cell.lblDescDetail.text = self.getDepatmentModel[indexPath.row].projectDesc
        //cell.lblSelectDesc.text = "Cost Center"
        let costCenterDesc = self.getCostCenter.filter({ (result) -> Bool in
            return result.id == self.getDepatmentModel[indexPath.row].costCentreId
        })
        cell.lblSelectDescDetail.text = "\(costCenterDesc.first!.costCentreCode!)- \(costCenterDesc.first!.costCentreDesc!)"
        cell.customDropDownDelegate = self
        return cell
    }
    
    func editActionTag(_ sender: Int) {
        let vc = adminStoryboard.instantiateViewController(withIdentifier: "CreateProjectViewController") as! CreateProjectViewController
        vc.editProjectModel = getDepatmentModel[sender]
        self.navigationController?.pushViewController(vc, animated: true)
        print("Edit row \(sender)")
    }
    func deleteActionTag(_ sender: Int) {
        print("Delete row \(sender)")
        self.deleteCostCenter(deleteCenter: getDepatmentModel[sender])
    }
    func viewActionTag(_ sender: Int) {
        
    }
    
    func deleteCostCenter(deleteCenter : ProjectModel){
//        showLoader()
//        networking.setAuthorizationHeader(token: DefaultsManager.shared.accesstoken ?? "")
//        networking.delete(DELETE_PROJECTS + "\(deleteCenter.id!)", parameters: nil) { (result) in
//            hideLoader()
//            do{
//            switch result {
//            case .success(let response):
//                print("responseModel \(response)")
//                Loaf("Department deleted successfully", state: .success, location: .top, sender: self).show(.short, completionHandler: nil)
//                self.getDepartments()
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

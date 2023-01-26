//
//  AdminAssignRoleViewController.swift
//  AtoCash
//
//  Created by user on 14/03/21.
//

import UIKit

class AdminAssignRoleViewController: UIViewController {

    @IBOutlet weak var createBtn: UIButton!
    @IBOutlet weak var txtRoleId: UITextField!
    @IBOutlet weak var txtApprovalGroup: UITextField!
    var getAdminUser = [AdminUserModel]()
    var selectedJobRole : [AdminRoleModel]?
    var getAdminModel = [AdminRoleModel]()
    var selectedUserRole : AdminUserModel?
    var selectJob = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        txtRoleId.setupRightPadview()
        txtApprovalGroup.setupRightPadview()
        getAdminRoles()
        selectJob = []
        self.navigationController?.isNavigationBarHidden = true
    }
    @IBAction func backAction(_ sender: Any) {
        self.present(SideMenuManager.default.leftMenuNavigationController!, animated: true, completion: nil)
    }
    func getAdminRoles(){
//        showLoader()
//        networking.setAuthorizationHeader(token: DefaultsManager.shared.accesstoken ?? "")
//        networking.get(ADMIN_LISTROLES) { result in
//            hideLoader()
//            switch result {
//            case .success(let response):
//                do{
//                let jsonDecoder = JSONDecoder()
//                    let responseModel = try jsonDecoder.decode([AdminRoleModel].self, from: response.data)
//                    self.getAdminModel = responseModel
//                    self.getAdminUsers()
//                }
//                catch {
//                    print("Decoding Error \(error)")
//                }
//                // Do something with JSON, you can also get arrayBody
//            case .failure(let response):
//                // Handle error
//            print("error \(response)")
//                self.getAdminModel = []
//                if response.statusCode == 401{
//                    DefaultsManager.shared.accesstoken = ""
//                    DefaultsManager.shared.userRole = ""
//                    AppDelegate.shared.setupRootViewController()
//                }
//                Loaf(response.fullResponse.description, state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
//            }
//        }
    }
    func getAdminUsers(){
//        showLoader()
//        networking.setAuthorizationHeader(token: DefaultsManager.shared.accesstoken ?? "")
//        networking.get(ADMIN_LISTUSERS) { result in
//            hideLoader()
//            switch result {
//            case .success(let response):
//                do{
//                let jsonDecoder = JSONDecoder()
//                    let responseModel = try jsonDecoder.decode([AdminUserModel].self, from: response.data)
//                    self.getAdminUser = responseModel
//                }
//                catch {
//                    print("Decoding Error \(error)")
//                }
//                // Do something with JSON, you can also get arrayBody
//            case .failure(let response):
//                // Handle error
//            print("error \(response)")
//                self.getAdminUser = []
//                if response.statusCode == 401{
//                    DefaultsManager.shared.accesstoken = ""
//                    DefaultsManager.shared.userRole = ""
//                    AppDelegate.shared.setupRootViewController()
//                }
//                Loaf(response.fullResponse.description, state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
//            }
//        }
    }
    @IBAction func cancelAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func createAction(_ sender: Any) {
        if txtRoleId.text == ""{
           // txtRoleId.errorMessage = "Please Enter role Name"
            Loaf("Please Enter role name", state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
        else if txtApprovalGroup.text == ""{
           // txtApprovalGroup.errorMessage = "Please Enter User name"
            Loaf("Please Enter User name", state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
        else{
          //  txtRoleId.errorMessage = ""
            // txtApprovalGroup.errorMessage = ""
            self.createCostCenter()
        }
    }
    
    func createCostCenter(){
//        showLoader()
//        let params = ["userId": self.selectedUserRole!.id!,
//                      "roleIds": self.selectJob] as [String : Any]
//        networking.setAuthorizationHeader(token: DefaultsManager.shared.accesstoken ?? "")
//        networking.post(ADMIN_ASSIGN_POST, parameterType: .json, parameters: params) { (result) in
//            hideLoader()
//            do{
//            switch result {
//            case .success(let response):
//                print("responseModel \(response)")
//                Loaf("Approval Status created successfully", state: .success, location: .top, sender: self).show(.short, completionHandler: nil)
//                self.view.isUserInteractionEnabled = false
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//                    self.view.isUserInteractionEnabled = true
//                    self.navigationController?.popViewController(animated: true)
//                }
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

extension AdminAssignRoleViewController : UITextFieldDelegate{
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtApprovalGroup{
            //User
            var projectTitle = [String]()
            for dropDown in self.getAdminUser{
                projectTitle.append("\(dropDown.userName!) - \(dropDown.email!)")
            }
            
            let simpleArray: [String] = projectTitle
            var simpleSelectedArray: [String] = selectedUserRole == nil ? [] : ["\(selectedUserRole!.userName!) - \(selectedUserRole!.email!)"]
            let selectionMenu = RSSelectionMenu(dataSource: simpleArray) { (cell, item, indexPath) in
                cell.textLabel?.text = item
                cell.separatorInset = .zero
                cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 15.0)
                cell.layoutMargins = .zero
            }
            if (textField.text != nil) {
                simpleSelectedArray = [textField.text] as! [String]
            }
            selectionMenu.setSelectedItems(items: simpleSelectedArray) {(item, index, isSelected, selectedItems) in
                textField.text = item!
                for drop in self.getAdminUser{
                    if "\(drop.userName!) - \(drop.email!)" == item!{
                        self.selectedUserRole = drop
                        break
                    }
                }
                
            }
            selectionMenu.show(style: .popover(sourceView: textField, size: CGSize(width: textField.frame.size.width, height: 230)), from: self)
            
            return false
        }
        if textField == txtRoleId{
            //role
            var projectTitle = [String]()
            for dropDown in self.getAdminModel{
                projectTitle.append(dropDown.name!)
            }
            
            let simpleArray: [String] = projectTitle
            var simpleSelectedArray: [String] = []
            let selectionMenu = RSSelectionMenu(dataSource: simpleArray) { (cell, item, indexPath) in
                cell.textLabel?.text = item
                cell.separatorInset = .zero
                cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 15.0)
                cell.layoutMargins = .zero
            }
            if (textField.text != nil) {
                simpleSelectedArray = [textField.text] as! [String]
            }
            selectionMenu.setSelectedItems(items: simpleSelectedArray) {(item, index, isSelected, selectedItems) in
                textField.text = item!
                for drop in self.getAdminModel{
                    if drop.name! == item!{
                        self.selectedJobRole = [drop]
                        self.selectJob = [drop.id!]
                        break
                    }
                }
            }
            selectionMenu.show(style: .popover(sourceView: textField, size: CGSize(width: textField.frame.size.width, height: 230)), from: self)
            
            return false
        }
        
        return true
    }
}

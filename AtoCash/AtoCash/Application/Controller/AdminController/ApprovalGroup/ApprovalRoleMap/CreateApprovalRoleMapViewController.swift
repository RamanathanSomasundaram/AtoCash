//
//  CreateApprovalRoleMapViewController.swift
//  AtoCash
//
//  Created by user on 12/03/21.
//

import UIKit

class CreateApprovalRoleMapViewController: UIViewController {

    @IBOutlet weak var createBtn: UIButton!
    @IBOutlet weak var txtApprovalLevel: UITextField!
    @IBOutlet weak var txtRoleId: UITextField!
    @IBOutlet weak var txtApprovalGroup: UITextField!

    var editApprovalRoleMap : ApprovalRoleMapDTO?
    
    var approvalGroup = [ApprovalGroupVM]()
    var selectApprovalGroup : ApprovalGroupVM?
    
    var approvalLevel = [ApprovalLevelDTO]()
    var selectApprovalLevel : ApprovalLevelDTO?
    
    var roleMap = [ApprovalRoleMapDTO]()
    var selectRole : ApprovalRoleMapDTO?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        txtApprovalLevel.setupRightPadview()
        txtRoleId.setupRightPadview()
        txtApprovalGroup.setupRightPadview()
        getAllApprovalGroup()
        getAllApprovalLevel()
        getAllJobRoles()
        if editApprovalRoleMap == nil {
            self.createBtn.setTitle("CREATE", for: .normal)
        }
        else{
            self.createBtn.setTitle("SAVE", for: .normal)
            txtApprovalLevel.text = "\(editApprovalRoleMap!.approvalLevel!)"
            txtApprovalGroup.text = editApprovalRoleMap?.approvalGroup
            txtRoleId.text = editApprovalRoleMap?.role
        }
    }
    
    func getAllApprovalGroup(){
        showLoader()
        ApprovalGroupsAPI.apiApprovalGroupsApprovalGroupsForDropdownGet { (result, error) in
            hideLoader()
            if error == nil {
                self.approvalGroup = result ?? []
                if self.editApprovalRoleMap != nil {
                    for group in self.approvalGroup{
                        if self.editApprovalRoleMap?.approvalGroupId == group._id{
                            self.selectApprovalGroup = group
                        }
                    }
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
    
    func getAllApprovalLevel(){
        showLoader()
        ApprovalLevelsAPI.apiApprovalLevelsGet { (result, error) in
            hideLoader()
            if error == nil {
                self.approvalLevel = result ?? []
                if self.editApprovalRoleMap != nil {
                    for group in self.approvalLevel{
                        if self.editApprovalRoleMap?.approvalLevelId == group._id{
                            self.selectApprovalLevel = group
                        }
                    }
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
    func getAllJobRoles(){
        showLoader()
        
        ApprovalRoleMapsAPI.apiApprovalRoleMapsGet { (result, error) in
            hideLoader()
            if error == nil {
                self.roleMap = result ?? []
                if self.editApprovalRoleMap != nil {
                    for group in self.roleMap{
                        if self.editApprovalRoleMap?.roleId == group._id{
                            self.selectRole = group
                        }
                    }
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
    
    
    @IBAction func cancelAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func createAction(_ sender: Any) {
            
            if txtApprovalGroup.text == ""{
               // txtApprovalGroup.errorMessage = "Please select Approval Code"
                Loaf("Please select Approval Code", state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
            }
            else if txtApprovalLevel.text == "" {
            //    txtApprovalLevel.errorMessage = "Please select Approval level "
                Loaf("Please select Approval level ", state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
            }
            else if txtRoleId.text == "" {
               // txtRoleId.errorMessage = "Please select Role level"
                Loaf("Please select role level ", state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
            }
            else{
               // txtRoleId.errorMessage = ""
               // txtApprovalLevel.errorMessage = ""
               // txtApprovalGroup.errorMessage = ""
                if editApprovalRoleMap == nil {
                    self.createCostCenter()
                }
                else{
                    self.updateCostCenter()
                }
            }
        }
        
        func createCostCenter(){
            showLoader()
            ApprovalRoleMapsAPI.apiApprovalRoleMapsPost(body: ApprovalRoleMapDTO(_id: 0, approvalGroup: self.selectApprovalGroup?.approvalGroupCode, approvalGroupId: self.selectApprovalGroup?._id, role: self.selectRole?.role, roleId: self.selectRole?._id, approvalLevel: self.selectApprovalLevel?.level, approvalLevelId: self.selectApprovalLevel?._id)) { (result, error) in
                hideLoader()
                if error == nil {
                    Loaf("Approval role map created successfully", state: .success, location: .top, sender: self).show(.short, completionHandler: nil)
                    self.view.isUserInteractionEnabled = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        self.view.isUserInteractionEnabled = true
                        self.navigationController?.popViewController(animated: true)
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
        
        func updateCostCenter(){
            showLoader()
            ApprovalRoleMapsAPI.apiApprovalRoleMapsIdPut(_id: self.editApprovalRoleMap!._id!, body: ApprovalRoleMapDTO(_id: self.editApprovalRoleMap!._id!, approvalGroup: self.selectApprovalGroup?.approvalGroupCode, approvalGroupId: self.selectApprovalGroup?._id, role: self.selectRole?.approvalGroup, roleId: self.selectRole?._id, approvalLevel: self.selectApprovalLevel?.level, approvalLevelId: self.selectApprovalLevel?._id)) { (result, error) in
                hideLoader()
                if error == nil {
                    Loaf("Approval role map created successfully", state: .success, location: .top, sender: self).show(.short, completionHandler: nil)
                    self.view.isUserInteractionEnabled = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        self.view.isUserInteractionEnabled = true
                        self.navigationController?.popViewController(animated: true)
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
        
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension CreateApprovalRoleMapViewController : UITextFieldDelegate{
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtApprovalGroup{
            var projectTitle = [String]()
            for dropDown in self.approvalGroup{
                projectTitle.append(dropDown.approvalGroupCode!)
            }
            
            let simpleArray: [String] = projectTitle
            var simpleSelectedArray: [String] = selectApprovalGroup == nil ? [] : [selectApprovalGroup!.approvalGroupCode!]
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
                for drop in self.approvalGroup{
                    if drop.approvalGroupCode! == item!{
                        self.selectApprovalGroup = drop
                        break
                    }
                }
                
            }
            selectionMenu.show(style: .popover(sourceView: textField, size: CGSize(width: textField.frame.size.width, height: 230)), from: self)
            
            return false
        }
        if textField == txtApprovalLevel{
            var projectTitle = [String]()
            for dropDown in self.approvalLevel{
                projectTitle.append("\(dropDown.level!) - \(dropDown.levelDesc!)")
            }
            
            let simpleArray: [String] = projectTitle
            var simpleSelectedArray: [String] = selectApprovalLevel == nil ? [] : ["\(selectApprovalLevel!.level!) - \(selectApprovalLevel!.levelDesc!)"]
            let selectionMenu = RSSelectionMenu(dataSource: simpleArray) { (cell, item, indexPath) in
                cell.textLabel?.text = item
                cell.separatorInset = .zero
                cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 15.0)
                cell.layoutMargins = .zero
            }
//            if (textField.text != nil) {
//                simpleSelectedArray = [textField.text] as! [String]
//            }
            selectionMenu.setSelectedItems(items: simpleSelectedArray) {(item, index, isSelected, selectedItems) in
                textField.text = item!
                for drop in self.approvalLevel{
                    if "\(drop.level!) - \(drop.levelDesc!)" == item!{
                        self.selectApprovalLevel = drop
                        break
                    }
                }
                
            }
            selectionMenu.show(style: .popover(sourceView: textField, size: CGSize(width: textField.frame.size.width, height: 230)), from: self)
            
            return false
        }
        if textField == txtRoleId{
            var projectTitle = [String]()
            for dropDown in self.roleMap{
                projectTitle.append("\(dropDown.roleId!) - \(dropDown.role!)")
            }
            
            let simpleArray: [String] = projectTitle
            var simpleSelectedArray: [String] = selectRole == nil ? [] : ["\(selectRole!.roleId!) - \(selectRole!.role!)"]
            let selectionMenu = RSSelectionMenu(dataSource: simpleArray) { (cell, item, indexPath) in
                cell.textLabel?.text = item
                cell.separatorInset = .zero
                cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 15.0)
                cell.layoutMargins = .zero
            }
//            if (textField.text != nil) {
//                simpleSelectedArray = [textField.text] as! [String]
//            }
            selectionMenu.setSelectedItems(items: simpleSelectedArray) {(item, index, isSelected, selectedItems) in
                textField.text = item!
                for dropDown in self.roleMap{
                    if "\(dropDown.roleId!) - \(dropDown.role!)" == item!{
                        self.selectRole = dropDown
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

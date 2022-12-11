//
//  CreateDepartmentViewController.swift
//  AtoCash
//
//  Created by user on 12/03/21.
//

import UIKit

class CreateDepartmentViewController: UIViewController {

    @IBOutlet weak var statusError: UILabel!
    @IBOutlet weak var descError: UILabel!
    @IBOutlet weak var codeError: UILabel!
    @IBOutlet weak var costError: UILabel!
    @IBOutlet weak var txtCostCenterCode: UITextField!
    @IBOutlet weak var txtDeptName: UITextField!
    @IBOutlet weak var txtDeptCode: UITextField!
    @IBOutlet weak var txtStatus: UITextField!
    
    var editDepartMent : DepartmentDTO?
    var getCostCenter = [CostCenterVM]()
    var selectCostCenter : CostCenterDTO?
    var selectedStatusType : StatusType?
    var statusTypeList = [StatusTypeVM]()
    

    
    @IBOutlet weak var createBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.txtCostCenterCode.setupRightPadview()
        self.txtStatus.setupRightPadview()
        if editDepartMent == nil {
            self.createBtn.setTitle("CREATE", for: .normal)
        }
        else{
            self.createBtn.setTitle("SAVE", for: .normal)
            self.txtDeptCode.text = editDepartMent?.deptCode
            self.txtDeptName.text = editDepartMent?.deptName
            
            CostCentersAPI.apiCostCentersGetCostCenterIdGet(_id: editDepartMent!.costCenterId!) { (centerResult, error) in
                if error == nil {
                self.selectCostCenter = centerResult
                    self.txtCostCenterCode.text = centerResult?.costCenterCode
                }
            }
            StatusTypesAPI.apiStatusTypesGetStatusTypeIdGet(_id: editDepartMent!.statusTypeId!) { (status, error) in
                if error == nil{
                    self.selectedStatusType = status
                    self.txtStatus.text = status?.status
                }
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getAllCostCenters()
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func cancelAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func createAction(_ sender: Any) {
        self.descError.isHidden = true
        self.codeError.isHidden = true
        self.costError.isHidden = true
        self.statusError.isHidden = true
        if txtCostCenterCode.text == "" && txtDeptName.text == "" && txtDeptCode.text == "" && txtStatus.text == "" {
            self.descError.isHidden = false
            self.codeError.isHidden = false
            self.costError.isHidden = false
            self.statusError.isHidden = false
        }
        if txtDeptCode.text == ""{
            self.codeError.isHidden = false
            //txtDeptCode.errorMessage = "Please Enter Department Code"
            Loaf("Please Enter Department Code", state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
        else if txtDeptName.text == "" {
            self.descError.isHidden = false
            //txtDeptName.errorMessage = "Please Enter Department Description"
            Loaf("Please Enter Department Description", state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
        else if txtCostCenterCode.text == "" {
            self.costError.isHidden = false
            //txtCostCenterCode.errorMessage = "Please select cost center"
            Loaf("Please select cost center", state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
        else if txtStatus.text == "" {
            self.statusError.isHidden = false
            //txtCostCenterCode.errorMessage = "Please select cost center"
            Loaf("Please select status", state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
        else{
            self.descError.isHidden = true
            self.codeError.isHidden = true
            self.costError.isHidden = true
            self.statusError.isHidden = true
            if editDepartMent == nil {
                self.createCostCenter()
            }
            else{
                self.updateCostCenter()
            }
        }
    }
    
    private func createCostCenter(){
        showLoader()
        DepartmentsAPI.apiDepartmentsPostDepartmentPost(body: DepartmentDTO(_id: 0, deptCode: self.txtDeptCode.text, deptName: self.txtDeptName.text, costCenterId: self.selectCostCenter?._id, costCenter: self.selectCostCenter?.costCenterCode, statusType: self.selectedStatusType?.status, statusTypeId: self.selectedStatusType?._id)) { (result, error) in
            hideLoader()
            if error == nil {
                Loaf("Department created successfully", state: .success, location: .top, sender: self).show(.short, completionHandler: nil)
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
    
    func updateCostCenter(){
        showLoader()
        DepartmentsAPI.apiDepartmentsPutDepartmentIdPut(_id: self.editDepartMent!._id!, body: DepartmentDTO(_id: self.editDepartMent?._id!, deptCode: self.txtDeptCode.text, deptName: self.txtDeptName.text, costCenterId: self.selectCostCenter?._id, costCenter: self.selectCostCenter?.costCenterCode, statusType: self.selectedStatusType?.status, statusTypeId: self.selectedStatusType?._id)) {  (result, error) in
            hideLoader()
            if error == nil {
                Loaf("Department updated successfully", state: .success, location: .top, sender: self).show(.short, completionHandler: nil)
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
    
    
    private func getAllCostCenters(){
        CostCentersAPI.apiCostCentersCostCentersForDropdownGet { (result, error) in
            if error == nil {
                self.getCostCenter = result ?? []
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
        StatusTypesAPI.apiStatusTypesStatusTypesForDropdownGet { (statusList, error) in
            if error == nil {
                self.statusTypeList = statusList ?? []
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension CreateDepartmentViewController : UITextFieldDelegate{
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtCostCenterCode{
            var projectTitle = [String]()
            for dropDown in self.getCostCenter{
                projectTitle.append(dropDown.costCenterCode!)
            }
            
            let simpleArray: [String] = projectTitle
            var simpleSelectedArray: [String] = selectCostCenter == nil ? [] : [selectCostCenter!.costCenterCode!]
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
                for drop in self.getCostCenter{
                    if drop.costCenterCode == item!{
                        self.selectCostCenter = CostCenterDTO(_id: drop._id, costCenterCode: drop.costCenterCode, costCenterDesc: nil, statusTypeId: nil, statusType: nil)
                        break
                    }
                }
                
            }
            // show searchbar with placeholder and barTintColor
            selectionMenu.showSearchBar(withPlaceHolder: "Search Cost center", barTintColor: UIColor.init(named: "NavBar")!.withAlphaComponent(0.2)) { (searchText) -> ([String]) in

                return simpleArray.filter({ $0.lowercased().contains(searchText.lowercased()) })
            }
            selectionMenu.show(style: .popover(sourceView: textField, size: CGSize(width: textField.frame.size.width, height: 230)), from: self)
            
            
            return false
        }
        if textField == txtStatus {
            var projectTitle = [String]()
            for dropDown in self.statusTypeList{
                projectTitle.append(dropDown.status!)
            }
            
            let simpleArray: [String] = projectTitle
            var simpleSelectedArray: [String] = selectedStatusType == nil ? [] : [selectedStatusType!.status]
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
                for drop in self.statusTypeList{
                    if drop.status == item!{
                        self.selectedStatusType = StatusType(_id: drop._id, status: drop.status!)
                        break
                    }
                }
                
            }
            
            // show searchbar with placeholder and barTintColor
            selectionMenu.showSearchBar(withPlaceHolder: "Search status type", barTintColor: UIColor.init(named: "NavBar")!.withAlphaComponent(0.2)) { (searchText) -> ([String]) in
                
                return simpleArray.filter({ $0.lowercased().contains(searchText.lowercased()) })
            }
            selectionMenu.show(style: .popover(sourceView: textField, size: CGSize(width: textField.frame.size.width, height: 230)), from: self)
            
            
            return false
        }
        return true
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtDeptCode{
        guard let text = textField.text else { return true }
        let allowedCharacters = CharacterSet(charactersIn:"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")//Here change this characters based on your requirement
        let characterSet = CharacterSet(charactersIn: string)
        
        let newLength = text.utf16.count + string.utf16.count - range.length
           // txtDeptCode.errorMessage = newLength <= 20 && allowedCharacters.isSuperset(of: characterSet) ? "" : "Enter Maximum 20 character"
        return newLength <= 20 && allowedCharacters.isSuperset(of: characterSet)
        }
        else if(textField == txtDeptName){
            guard let text = textField.text else { return true }
            let allowedCharacters = CharacterSet(charactersIn:"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            
            let newLength = text.utf16.count + string.utf16.count - range.length
            //txtDeptName.errorMessage = newLength <= 100 && allowedCharacters.isSuperset(of: characterSet) ? "" : "Enter Maximum 100 character"
            return newLength <= 100 && allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
}

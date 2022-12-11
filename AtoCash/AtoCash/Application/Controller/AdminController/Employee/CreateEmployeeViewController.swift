//
//  CreateEmployeeViewController.swift
//  AtoCash
//
//  Created by user on 12/03/21.
//

import UIKit

class CreateEmployeeViewController: UIViewController {

    @IBOutlet weak var txtEMailAddress: UITextField!
    @IBOutlet weak var txtGender: UITextField!
    @IBOutlet weak var txtDOB: UITextField!
    @IBOutlet weak var txtDOJ: UITextField!
    @IBOutlet weak var txtNationality: UITextField!
    @IBOutlet weak var txtBankAccount: UITextField!
    @IBOutlet weak var txtEmployeeCode: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtFirstName: UITextField!
    
    var selectedStatusType : StatusType?
    var statusTypeList = [StatusTypeVM]()
    
    var selectedStatusType1 : CurrencyType?
    var statusTypeList1 = [CurrencyTypeVM]()
    
    @IBOutlet weak var txtMiddleName: UITextField!
    @IBOutlet weak var txtDebitCard: UITextField!
    @IBOutlet weak var txtTaxNo: UITextField!
    @IBOutlet weak var txtPassportID: UITextField!
    @IBOutlet weak var txtNationalID: UITextField!
    @IBOutlet weak var selectRole: UITextField!
    @IBOutlet weak var selectDept: UITextField!
    @IBOutlet weak var selectEmpType: UITextField!
    @IBOutlet weak var txtMobileNumber: UITextField!
    @IBOutlet weak var txtSelectApprovalGroup: UITextField!
    @IBOutlet weak var txtCurrency: UITextField!
    
    @IBOutlet weak var txtStatus: UITextField!
    
    
    
    var selectRoleModel : JobRoleModel?
    var selectApprovalGroup : ApprovalGroupModel?
    var selectEmpTypeModel : EmployeeTypeModel?
    var selectDeptModel : DepartmentModel?
    var getRolesArray = [JobRoleModel]()
    var getApprovalGroupArray = [ApprovalGroupModel]()
    var getDepartmentArray = [DepartmentModel]()
    var getEmployeeType = [EmployeeTypeModel]()
    
    var editEmployeeModel : EmployeeModel?
    
    @IBOutlet weak var createBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getStatusType()
        self.getCurrencyType()

        // Do any additional setup after loading the view.
        self.getDepartments()
        txtDOB.setupRightPadview()
        txtDOJ.setupRightPadview()
        txtGender.setupRightPadview()
        selectEmpType.setupRightPadview()
        txtNationality.setupRightPadview()
        selectRole.setupRightPadview()
        selectDept.setupRightPadview()
        
        txtCurrency.setupRightPadview()
        txtStatus.setupRightPadview()

        
        txtSelectApprovalGroup.setupRightPadview()
        txtDOB.setInputViewPicker(nil, target: self, selector: #selector(dateOfBirthSelection))
        txtDOJ.setInputViewPicker(nil, target: self, selector: #selector(dateofJoining))
        if editEmployeeModel == nil {
            self.createBtn.setTitle("CREATE", for: .normal)
        }
        else{
            self.createBtn.setTitle("SAVE", for: .normal)
            self.txtFirstName.text = editEmployeeModel?.firstName
            self.txtLastName.text = editEmployeeModel?.lastName
            self.txtGender.text = editEmployeeModel?.gender
            self.txtNationality.text = editEmployeeModel?.nationality
            self.txtNationalID.text = editEmployeeModel?.nationalID
            self.txtPassportID.text = editEmployeeModel?.passportNo
            self.txtTaxNo.text = editEmployeeModel?.taxNumber
            self.txtBankAccount.text = editEmployeeModel?.bankAccount
            self.txtDebitCard.text = editEmployeeModel?.bankCardNo
            self.txtDOB.text = UtilsManager.shared.systemDateStringFromUTC(utcDate: editEmployeeModel?.dob ?? "")
            self.txtDOJ.text = UtilsManager.shared.systemDateStringFromUTC(utcDate: editEmployeeModel?.doj ?? "")
            self.txtMiddleName.text = editEmployeeModel?.middleName
            self.txtEMailAddress.text = editEmployeeModel?.email
            self.txtEmployeeCode.text = editEmployeeModel?.empCode
            self.txtMobileNumber.text = editEmployeeModel?.mobileNumber
        }
    }
    
    @objc func dateOfBirthSelection(){
        if let datePicker = self.txtDOB.inputView as? UIDatePicker { // 2-1
            let dateformatter = DateFormatter() // 2-2
            dateformatter.dateStyle = .long
            dateformatter.dateFormat = "yyyy-MM-dd"
            self.txtDOB.text = dateformatter.string(from: datePicker.date) //2-4
        }
        self.txtDOB.resignFirstResponder() // 2-5
    }
    
    @objc func dateofJoining()
    {
        if let datePicker = self.txtDOJ.inputView as? UIDatePicker { // 2-1
            let dateformatter = DateFormatter() // 2-2
            dateformatter.dateStyle = .long
            dateformatter.dateFormat = "yyyy-MM-dd"
            self.txtDOJ.text = dateformatter.string(from: datePicker.date) //2-4
        }
        self.txtDOJ.resignFirstResponder() // 2-5
    }
    private func getDepartments(){
//        showLoader()
//        networking.setAuthorizationHeader(token: DefaultsManager.shared.accesstoken ?? "")
//        networking.get(DEPARTMENTS) { result in
//            hideLoader()
//            switch result {
//            case .success(let response):
//                do{
//                let jsonDecoder = JSONDecoder()
//                    let responseModel = try jsonDecoder.decode([DepartmentModel].self, from: response.data)
//                    self.getDepartmentArray = responseModel
//                }
//                catch {
//                    print("Decoding Error \(error)")
//                }
//                if self.editEmployeeModel != nil {
//                    let cost = self.getDepartmentArray.filter({ (result) -> Bool in
//                        return result.id == self.editEmployeeModel?.departmentId
//                    })
//                    self.selectDept.text = "\(cost.first!.deptCode!) - \(cost.first!.deptName!)"
//                    self.selectDeptModel = cost.first
//                }
//                self.getRolesList()
//                // Do something with JSON, you can also get arrayBody
//            case .failure(let response):
//                // Handle error
//            print("error \(response)")
//                if response.statusCode == 401{
//                    DefaultsManager.shared.accesstoken = ""
//                    DefaultsManager.shared.userRole = ""
//                    AppDelegate.shared.setupRootViewController()
//                }
//                Loaf(response.fullResponse.description, state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
//            }
//        }
    }
    
    private func getRolesList(){
//        showLoader()
//        networking.setAuthorizationHeader(token: DefaultsManager.shared.accesstoken ?? "")
//        networking.get(JOBROLES) { result in
//            hideLoader()
//            switch result {
//            case .success(let response):
//                do{
//                let jsonDecoder = JSONDecoder()
//                    let responseModel = try jsonDecoder.decode([JobRoleModel].self, from: response.data)
//                    self.getRolesArray = responseModel
//                }
//                catch {
//                    print("Decoding Error \(error)")
//                }
//                if self.editEmployeeModel != nil {
//                    let cost = self.getRolesArray.filter({ (result) -> Bool in
//                        return result.id == self.editEmployeeModel?.roleId
//                    })
//                    self.selectRole.text = "\(cost.first!.roleCode!) - \(cost.first!.roleName!)"
//                    self.selectRoleModel = cost.first
//                }
//                self.getAllEmployeeType()
//                // Do something with JSON, you can also get arrayBody
//            case .failure(let response):
//                // Handle error
//            print("error \(response)")
//
//                Loaf(response.fullResponse.description, state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
//            }
//        }
    }
    func getAllEmployeeType(){
//        showLoader()
//        networking.setAuthorizationHeader(token: DefaultsManager.shared.accesstoken ?? "")
//        networking.get(EMPLOYMENT_TYPES) { result in
//            hideLoader()
//            switch result {
//            case .success(let response):
//                do{
//                let jsonDecoder = JSONDecoder()
//                    let responseModel = try jsonDecoder.decode([EmployeeTypeModel].self, from: response.data)
//                    self.getEmployeeType = responseModel
//                }
//                catch {
//                    print("Decoding Error \(error)")
//                }
//                if self.editEmployeeModel != nil {
//                    let cost = self.getEmployeeType.filter({ (result) -> Bool in
//                        return result.id == self.editEmployeeModel?.employmentTypeId
//                    })
//                    self.selectEmpType.text = "\(cost.first!.empJobTypeCode!) - \(cost.first!.empJobTypeDesc!)"
//                    self.selectEmpTypeModel = cost.first
//                }
//                self.getApprovalGroup()
//                // Do something with JSON, you can also get arrayBody
//            case .failure(let response):
//                // Handle error
//            print("error \(response)")
//                if response.statusCode == 401{
//                    DefaultsManager.shared.accesstoken = ""
//                    DefaultsManager.shared.userRole = ""
//                    AppDelegate.shared.setupRootViewController()
//                }
//                Loaf(response.fullResponse.description, state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
//            }
//        }
    }
    
    func getApprovalGroup(){
//        showLoader()
//        networking.setAuthorizationHeader(token: DefaultsManager.shared.accesstoken ?? "")
//        networking.get(GET_APPROVALGROUP) { result in
//            hideLoader()
//            switch result {
//            case .success(let response):
//                do{
//                let jsonDecoder = JSONDecoder()
//                    let responseModel = try jsonDecoder.decode([ApprovalGroupModel].self, from: response.data)
//                    self.getApprovalGroupArray = responseModel
//                }
//                catch {
//                    print("Decoding Error \(error)")
//                }
//                if self.editEmployeeModel != nil {
//                    let cost = self.getApprovalGroupArray.filter({ (result) -> Bool in
//                        return result.id == self.editEmployeeModel?.approvalGroupId
//                    })
//                    self.txtSelectApprovalGroup.text = "\(cost.first!.approvalGroupCode!) - \(cost.first!.approvalGroupDesc!)"
//                    self.selectApprovalGroup = cost.first
//                }
//                // Do something with JSON, you can also get arrayBody
//            case .failure(let response):
//                // Handle error
//            print("error \(response)")
//                if response.statusCode == 401{
//                    DefaultsManager.shared.accesstoken = ""
//                    DefaultsManager.shared.userRole = ""
//                    AppDelegate.shared.setupRootViewController()
//                }
//                Loaf(response.fullResponse.description, state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
//            }
//        }
    }

    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func createAction(_ sender: Any) {
        
        if txtFirstName.text == ""{
         //   txtFirstName.errorMessage = "Please Enter First Name"
            Loaf("Please Enter First Name", state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }else  if txtLastName.text == ""{
          //  txtLastName.errorMessage = "Please Enter Last Name"
            Loaf("Please Enter Last Name", state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }else  if txtEMailAddress.text == "" || !UtilsManager.isValidEmail(txtEMailAddress.text ?? ""){
           // txtEMailAddress.errorMessage = "Please Enter Valid Email Address"
            Loaf("Please Enter First Name", state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }else if txtBankAccount.text == ""{
          //  txtBankAccount.errorMessage = "Please Enter Valid bank account"
            Loaf("Please Enter valid bank Name", state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }else if txtNationality.text == ""{
           // txtNationality.errorMessage = "Please select nationality"
            Loaf("Please select nationality", state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        } else if txtDOB.text == ""{
            //txtDOB.errorMessage = "Please select DOB"
            Loaf("Please select DOB", state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }else if txtGender.text == ""{
           // txtGender.errorMessage = "Please select Gender"
            Loaf("Please select Gender", state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }else if txtDOJ.text == ""{
            //txtDOJ.errorMessage = "Please select Gender"
            Loaf("Please select DOJ", state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        } else  if txtEmployeeCode.text == ""{
            //txtEmployeeCode.errorMessage = "Please emter the employee code"
            Loaf("Please emter the employee code", state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
        else if txtSelectApprovalGroup.text == "" {
           // txtSelectApprovalGroup.errorMessage = "Please select approval group"
            Loaf("Please select approval group", state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
        else if selectRole.text == "" {
         //   selectRole.errorMessage = "Please select role"
            Loaf("Please select role", state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
        else if selectDept.text == "" {
          //  selectDept.errorMessage = "Please select department"
            Loaf("Please select department", state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
        else if selectEmpType.text == "" {
        //    selectEmpType.errorMessage = "Please select Employee Type"
            Loaf("Please select Employee", state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
        else{
//            txtFirstName.errorMessage = ""
//            txtGender.errorMessage = ""
//            txtLastName.errorMessage = ""
//            txtEMailAddress.errorMessage = ""
//            txtBankAccount.errorMessage = ""
//            txtNationality.errorMessage = ""
//            txtEmployeeCode.errorMessage = ""
            if editEmployeeModel == nil {
                self.createCostCenter()
            }
            else{
                self.updateCostCenter()
            }
        }
    }
    
    func createCostCenter(){
//        showLoader()
//        let params = ["firstName": self.txtFirstName.text!,
//                      "middleName": self.txtMiddleName.text!,
//                      "lastName": self.txtLastName.text!,
//                      "empCode": self.txtEmployeeCode.text!,
//                        "bankAccount": self.txtBankAccount.text!,
//                        "bankCardNo": self.txtDebitCard.text!,
//                        "nationalID": self.txtNationalID.text!,
//                        "passportNo": self.txtPassportID.text!,
//                        "taxNumber": self.txtTaxNo.text!,
//                        "nationality": self.txtNationality.text!,
//                        "dob": UtilsManager.shared.UTCDateFromString(date: self.txtDOB.text!),
//                        "doj": UtilsManager.shared.UTCDateFromString(date: self.txtDOJ.text!),
//                        "gender": self.txtGender.text!,
//                        "email": self.txtEMailAddress.text!,
//                        "mobileNumber": self.txtMobileNumber.text!,
//                        "employmentTypeId": selectEmpTypeModel?.id! ?? 0,
//                        "departmentId": selectDeptModel?.id! ?? 0,
//                        "roleId": selectRoleModel?.id! ?? 0,
//                        "approvalGroupId": selectApprovalGroup?.id! ?? 0] as [String : Any]
//        networking.setAuthorizationHeader(token: DefaultsManager.shared.accesstoken ?? "")
//        networking.post(POST_EMPLOYEE, parameterType: .json, parameters: params) { (result) in
//            hideLoader()
//            do{
//            switch result {
//            case .success(let response):
//                print("responseModel \(response)")
//                Loaf("Cost center created successfully", state: .success, location: .top, sender: self).show(.short, completionHandler: nil)
//                self.view.isUserInteractionEnabled = false
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//                    self.view.isUserInteractionEnabled = true
//                    self.navigationController?.popViewController(animated: true)
//                }
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
    
    func updateCostCenter(){
//        showLoader()
//        let params = ["id" : self.editEmployeeModel!.id!,
//            "firstName": self.txtFirstName.text!,
//                      "middleName": self.txtMiddleName.text!,
//                      "lastName": self.txtLastName.text!,
//                      "empCode": self.txtEmployeeCode.text!,
//                        "bankAccount": self.txtBankAccount.text!,
//                        "bankCardNo": self.txtDebitCard.text!,
//                        "nationalID": self.txtNationalID.text!,
//                        "passportNo": self.txtPassportID.text!,
//                        "taxNumber": self.txtTaxNo.text!,
//                        "nationality": self.txtNationality.text!,
//                        "dob": UtilsManager.shared.UTCDateFromString(date: self.txtDOB.text!),
//                        "doj": UtilsManager.shared.UTCDateFromString(date: self.txtDOJ.text!),
//                        "gender": self.txtGender.text!,
//                        "email": self.txtEMailAddress.text!,
//                        "mobileNumber": self.txtMobileNumber.text!,
//                        "employmentTypeId": selectEmpTypeModel?.id! ?? 0,
//                        "departmentId": selectDeptModel?.id! ?? 0,
//                        "roleId": selectRoleModel?.id! ?? 0,
//                        "approvalGroupId": selectApprovalGroup?.id! ?? 0] as [String : Any]
//        networking.setAuthorizationHeader(token: DefaultsManager.shared.accesstoken ?? "")
//            networking.put(PUT_EMPLOYEE + "/\(self.editEmployeeModel!.id!)", parameterType: .json, parameters: params) { (result) in
//            hideLoader()
//            do{
//            switch result {
//            case .success(let response):
//                print("responseModel \(response)")
//                Loaf("Cost center updated successfully", state: .success, location: .bottom, sender: self).show(.short, completionHandler: nil)
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
    
    
    func getStatusType(){
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
    
    func getCurrencyType(){
        CurrencyTypesAPI.apiCurrencyTypesCurrencyTypesForDropdownGet { (statusList, error) in
            if error == nil {
                self.statusTypeList1 = statusList ?? []
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
extension CreateEmployeeViewController : UITextFieldDelegate{
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == selectDept{
            var projectTitle = [String]()
            for dropDown in self.getDepartmentArray{
                projectTitle.append("\(dropDown.deptCode!) - \(dropDown.deptName!)")
            }
            
            let simpleArray: [String] = projectTitle
            var simpleSelectedArray: [String] = selectDeptModel == nil ? [] : ["\(selectDeptModel!.deptCode!) - \(selectDeptModel!.deptName!)"]
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
                for drop in self.getDepartmentArray{
                    if "\(drop.deptCode!) - \(drop.deptName!)" == item!{
                        self.selectDeptModel = drop
                        break
                    }
                }
                
            }
            // show searchbar with placeholder and barTintColor
            selectionMenu.showSearchBar(withPlaceHolder: "Search department", barTintColor: UIColor.lightGray.withAlphaComponent(0.2)) { (searchText) -> ([String]) in

                return simpleArray.filter({ $0.lowercased().starts(with: searchText.lowercased()) })
            }
            selectionMenu.show(style: .popover(sourceView: textField, size: CGSize(width: textField.frame.size.width, height: 230)), from: self)
            
            
            return false
        }
        if textField == selectRole{
            var projectTitle = [String]()
            for dropDown in self.getRolesArray{
                projectTitle.append("\(dropDown.roleCode!) - \(dropDown.roleName!)")
            }
            
            let simpleArray: [String] = projectTitle
            var simpleSelectedArray: [String] = selectRoleModel == nil ? [] : ["\(selectRoleModel!.roleCode!) - \(selectRoleModel!.roleName!)"]
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
                for drop in self.getRolesArray{
                    if "\(drop.roleCode!) - \(drop.roleName!)" == item!{
                        self.selectRoleModel = drop
                        break
                    }
                }
                
            }
            // show searchbar with placeholder and barTintColor
            selectionMenu.showSearchBar(withPlaceHolder: "Search roles", barTintColor: UIColor.lightGray.withAlphaComponent(0.2)) { (searchText) -> ([String]) in

                return simpleArray.filter({ $0.lowercased().starts(with: searchText.lowercased()) })
            }
            selectionMenu.show(style: .popover(sourceView: textField, size: CGSize(width: textField.frame.size.width, height: 230)), from: self)
            
            
            return false
        }
        
        if textField == selectEmpType{
            var projectTitle = [String]()
            for dropDown in self.getEmployeeType{
                projectTitle.append("\(dropDown.empJobTypeCode!) - \(dropDown.empJobTypeDesc!)")
            }
            
            let simpleArray: [String] = projectTitle
            var simpleSelectedArray: [String] = selectEmpTypeModel == nil ? [] : ["\(selectEmpTypeModel!.empJobTypeCode!) - \(selectEmpTypeModel!.empJobTypeDesc!)"]
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
                for drop in self.getEmployeeType{
                    if "\(drop.empJobTypeCode!) - \(drop.empJobTypeDesc!)" == item!{
                        self.selectEmpTypeModel = drop
                        break
                    }
                }
                
            }
            // show searchbar with placeholder and barTintColor
            selectionMenu.showSearchBar(withPlaceHolder: "Search Employee type", barTintColor: UIColor.lightGray.withAlphaComponent(0.2)) { (searchText) -> ([String]) in

                return simpleArray.filter({ $0.lowercased().starts(with: searchText.lowercased()) })
            }
            selectionMenu.show(style: .popover(sourceView: textField, size: CGSize(width: textField.frame.size.width, height: 230)), from: self)
            
            
            return false
        }
        if textField == txtSelectApprovalGroup{
            var projectTitle = [String]()
            for dropDown in self.getApprovalGroupArray{
                projectTitle.append("\(dropDown.approvalGroupCode!) - \(dropDown.approvalGroupDesc!)")
            }
            
            let simpleArray: [String] = projectTitle
            var simpleSelectedArray: [String] = selectApprovalGroup == nil ? [] : ["\(selectApprovalGroup!.approvalGroupCode!) - \(selectApprovalGroup!.approvalGroupDesc!)"]
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
                for drop in self.getApprovalGroupArray{
                    if "\(drop.approvalGroupCode!) - \(drop.approvalGroupDesc!)" == item!{
                        self.selectApprovalGroup = drop
                        break
                    }
                }
                
            }
            // show searchbar with placeholder and barTintColor
            selectionMenu.showSearchBar(withPlaceHolder: "Search Approval Group", barTintColor: UIColor.lightGray.withAlphaComponent(0.2)) { (searchText) -> ([String]) in

                return simpleArray.filter({ $0.lowercased().starts(with: searchText.lowercased()) })
            }
            selectionMenu.show(style: .popover(sourceView: textField, size: CGSize(width: textField.frame.size.width, height: 230)), from: self)
            
            
            return false
        }
        
        if txtGender == textField{
            let simpleArray: [String] = ["Male", "Female"]
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
            }
            selectionMenu.show(style: .popover(sourceView: textField, size: CGSize(width: textField.frame.size.width, height: 100)), from: self)
            return false
        }
        
        if txtNationality == textField{
            let simpleArray: [String] = nationality
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
            }
            
            // show searchbar with placeholder and barTintColor
            selectionMenu.showSearchBar(withPlaceHolder: "Search nationality", barTintColor: UIColor.lightGray.withAlphaComponent(0.2)) { (searchText) -> ([String]) in

                return simpleArray.filter({ $0.lowercased().starts(with: searchText.lowercased()) })
            }
            selectionMenu.show(style: .popover(sourceView: textField, size: CGSize(width: textField.frame.size.width, height: 230)), from: self)
            return false
        }
        if textField == txtCurrency{
            var projectTitle = [String]()
            for dropDown in self.statusTypeList1{
                projectTitle.append(dropDown.currencyCode!)
            }
            
            let simpleArray: [String] = projectTitle
            var simpleSelectedArray: [String] = selectedStatusType1 == nil ? [] : [selectedStatusType1!.currencyCode]
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
            selectionMenu.showSearchBar(withPlaceHolder: "Search Currency", barTintColor: UIColor.init(named: "NavBar")!.withAlphaComponent(0.2)) { (searchText) -> ([String]) in
                
                return simpleArray.filter({ $0.lowercased().contains(searchText.lowercased()) })
            }
            selectionMenu.show(style: .popover(sourceView: textField, size: CGSize(width: textField.frame.size.width, height: 230)), from: self)
            
            
            return false
        }
         
            if textField == txtStatus{
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
        
        if txtFirstName == textField || txtMiddleName == textField || txtLastName == textField || txtNationalID == textField || txtTaxNo == textField || txtPassportID == textField || txtEmployeeCode == textField{
            guard let text = textField.text else { return true }
            let allowedCharacters = CharacterSet(charactersIn:"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            
            let newLength = text.utf16.count + string.utf16.count - range.length
            return newLength <= 20 && allowedCharacters.isSuperset(of: characterSet)
        }
        else if(txtBankAccount == textField || txtDebitCard == textField || txtMobileNumber == textField){
            guard let text = textField.text else { return true }
            let allowedCharacters = CharacterSet(charactersIn:"0123456789")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            let length = textField == txtMobileNumber ? 10 : 16
            let newLength = text.utf16.count + string.utf16.count - range.length
            return newLength <= length && allowedCharacters.isSuperset(of: characterSet)
        }
        else if(textField == txtEMailAddress){
            if let text = textField.text {
                       if let floatingLabelTextField = textField as? SkyFloatingLabelTextField {
                           if(text.count < 3 || !text.contains("@")) {
                               floatingLabelTextField.errorMessage = "Invalid email"
                           }
                           else {
                               // The error message will only disappear when we reset it to nil or empty string
                               floatingLabelTextField.errorMessage = ""
                           }
                       }
                   }
        }
        
        return true
    }
}

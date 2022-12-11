//
//  EmployeeViewDetailController.swift
//  AtoCash
//
//  Created by user on 14/03/21.
//

import UIKit

class EmployeeViewDetailController: UIViewController {

    @IBOutlet weak var txtEMailAddress: InputTextFieldDesign!
    @IBOutlet weak var txtGender: InputTextFieldDesign!
    @IBOutlet weak var txtDOB: UITextField!
    @IBOutlet weak var txtDOJ: UITextField!
    @IBOutlet weak var txtNationality: InputTextFieldDesign!
    @IBOutlet weak var txtBankAccount: InputTextFieldDesign!
    @IBOutlet weak var txtEmployeeCode: InputTextFieldDesign!
    @IBOutlet weak var txtLastName: InputTextFieldDesign!
    @IBOutlet weak var txtFirstName: InputTextFieldDesign!
    
    @IBOutlet weak var txtMiddleName: InputTextFieldDesign!
    @IBOutlet weak var txtDebitCard: InputTextFieldDesign!
    @IBOutlet weak var txtTaxNo: InputTextFieldDesign!
    @IBOutlet weak var txtPassportID: InputTextFieldDesign!
    @IBOutlet weak var txtNationalID: InputTextFieldDesign!
    @IBOutlet weak var selectRole: InputTextFieldDesign!
    @IBOutlet weak var selectDept: InputTextFieldDesign!
    @IBOutlet weak var selectEmpType: InputTextFieldDesign!
    @IBOutlet weak var txtMobileNumber: InputTextFieldDesign!
    @IBOutlet weak var txtSelectApprovalGroup: InputTextFieldDesign!
    var selectRoleModel : JobRoleModel?
    var selectApprovalGroup : ApprovalGroupModel?
    var selectEmpTypeModel : EmployeeTypeModel?
    var selectDeptModel : DepartmentModel?
    var getRolesArray = [JobRoleModel]()
    var getApprovalGroupArray = [ApprovalGroupModel]()
    var getDepartmentArray = [DepartmentModel]()
    var getEmployeeType = [EmployeeTypeModel]()
    
    var editEmployeeModel : EmployeeModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.getDepartments()
        txtDOB.setupRightPadview()
        txtDOJ.setupRightPadview()
        txtGender.setupRightPaddingView()
        txtNationality.setupRightPaddingView()
        selectRole.setupRightPaddingView()
        selectDept.setupRightPaddingView()
        txtSelectApprovalGroup.setupRightPaddingView()
        txtDOB.setInputViewPicker(nil, target: self, selector: #selector(dateOfBirthSelection))
        txtDOJ.setInputViewPicker(nil, target: self, selector: #selector(dateofJoining))

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
    
    @objc func dateOfBirthSelection(){
        if let datePicker = self.txtDOB.inputView as? UIDatePicker { // 2-1
            let dateformatter = DateFormatter() // 2-2
            dateformatter.dateStyle = .long
            dateformatter.dateFormat = "yyyy-mm-dd"
            self.txtDOB.text = dateformatter.string(from: datePicker.date) //2-4
        }
        self.txtDOB.resignFirstResponder() // 2-5
    }
    
    @objc func dateofJoining()
    {
        if let datePicker = self.txtDOJ.inputView as? UIDatePicker { // 2-1
            let dateformatter = DateFormatter() // 2-2
            dateformatter.dateStyle = .long
            dateformatter.dateFormat = "yyyy-mm-dd"
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
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

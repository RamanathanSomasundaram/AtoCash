//
//  RegisterViewController.swift
//  AtoCash
//
//  Created by user on 14/03/21.
//

import UIKit
public func isValidPassword(_ password : String) -> Bool {
    let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#])[A-Za-z\\dd$@$!%*?&#]{6,}"
    return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
}
class RegisterViewController: UIViewController {

    @IBOutlet weak var confirmPassword: InputTextFieldDesign!
    @IBOutlet weak var newPassword: InputTextFieldDesign!
    @IBOutlet weak var txtEmailAddress: InputTextFieldDesign!
    @IBOutlet weak var txtUserName: InputTextFieldDesign!
    @IBOutlet weak var txtSelectEmp: InputTextFieldDesign!
    var getDepatmentModel = [EmployeeModel]()
    var selectCostCenter : EmployeeModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        txtSelectEmp.setupRightPaddingView()
        self.getEmployee()
        self.navigationController?.isNavigationBarHidden = true
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
//                // Do something with JSON, you can also get arrayBody
//            case .failure(let response):
//                // Handle error
//            print("error \(response)")
//                self.getDepatmentModel = []
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
        self.present(SideMenuManager.default.leftMenuNavigationController!, animated: true, completion: nil)
    }
    @IBAction func createAction(_ sender: Any) {
        if txtSelectEmp.text == ""{
            txtSelectEmp.errorMessage = "Please select Employee Code"
            Loaf("Please select Employee Code", state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
        else if txtUserName.text == "" {
            txtUserName.errorMessage = "Please Enter username"
            Loaf("Please Enter username", state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
        else if newPassword.text == "" {
            newPassword.errorMessage = "Please Enter password"
            Loaf("Please Enter username", state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
        else if confirmPassword.text == "" {
            confirmPassword.errorMessage = "Please Enter password"
            Loaf("Please Enter username", state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
        else if(!isValidPassword(newPassword.text!)){
            confirmPassword.errorMessage = "Minimum 6 characters at least 1 Uppercase Alphabet, 1 Lowercase Alphabet, 1 Number and 1 Special Character"
            Loaf("Minimum 6 characters at least 1 Uppercase Alphabet, 1 Lowercase Alphabet, 1 Number and 1 Special Character", state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
        else if(newPassword.text != confirmPassword.text){
            confirmPassword.errorMessage = "Password does not match"
            Loaf("Password does not match", state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
        else{
            txtSelectEmp.errorMessage = ""
            txtUserName.errorMessage = ""
            newPassword.errorMessage = ""
            confirmPassword.errorMessage = ""
            registerUser()
            
        }
    }
    
    func registerUser(){
//        showLoader()
//        let params = ["employeeId": self.selectCostCenter!.id!,
//                      "username": self.txtUserName.text!,
//                      "email": self.selectCostCenter!.email!,
//                      "password": self.newPassword.text!] as [String : Any]
//        networking.setAuthorizationHeader(token: DefaultsManager.shared.accesstoken ?? "")
//        networking.post(REGISTER, parameterType: .json, parameters: params) { (result) in
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
    
    @IBAction func cancelAction(_ sender: Any) {
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
extension RegisterViewController : UITextFieldDelegate{
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtSelectEmp{
            var projectTitle = [String]()
            for dropDown in self.getDepatmentModel{
                projectTitle.append("\(dropDown.empCode!) - \(dropDown.firstName! + " " + dropDown.lastName!)")
            }
            
            let simpleArray: [String] = projectTitle
            var simpleSelectedArray: [String] = selectCostCenter == nil ? [] : ["\(selectCostCenter!.empCode!) - \(selectCostCenter!.firstName! + " " + selectCostCenter!.lastName!)"]
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
                for dropDown in self.getDepatmentModel{
                    if "\(dropDown.empCode!) - \(dropDown.firstName! + " " + dropDown.lastName!)" == item!{
                        self.txtEmailAddress.text = dropDown.email
                        self.selectCostCenter = dropDown
                        break
                    }
                }
                
            }
            // show searchbar with placeholder and barTintColor
            selectionMenu.showSearchBar(withPlaceHolder: "Search Cost center", barTintColor: UIColor.lightGray.withAlphaComponent(0.2)) { (searchText) -> ([String]) in

                return simpleArray.filter({ $0.lowercased().starts(with: searchText.lowercased()) })
            }
            selectionMenu.show(style: .popover(sourceView: textField, size: CGSize(width: textField.frame.size.width, height: 230)), from: self)
            
            
            return false
        }
        return true
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtUserName{
        guard let text = textField.text else { return true }
        let allowedCharacters = CharacterSet(charactersIn:"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")//Here change this characters based on your requirement
        let characterSet = CharacterSet(charactersIn: string)
        
        let newLength = text.utf16.count + string.utf16.count - range.length
            txtUserName.errorMessage = newLength <= 20 && allowedCharacters.isSuperset(of: characterSet) ? "" : "Enter Maximum 20 character"
        return newLength <= 20 && allowedCharacters.isSuperset(of: characterSet)
        }
        else if(textField == newPassword || textField == confirmPassword){
            guard let text = textField.text else { return true }
            let allowedCharacters = CharacterSet(charactersIn:"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789$@$!%*?&#")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            
            let newLength = text.utf16.count + string.utf16.count - range.length
            newPassword.errorMessage = newLength <= 15 && allowedCharacters.isSuperset(of: characterSet) ? "" : "Enter Maximum 15 character"
            return newLength <= 15 && allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
}

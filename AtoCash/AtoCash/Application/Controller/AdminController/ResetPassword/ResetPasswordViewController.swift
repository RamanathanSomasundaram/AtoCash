//
//  ResetPasswordViewController.swift
//  AtoCash
//
//  Created by user on 11/03/21.
//

import UIKit

class ResetPasswordViewController: UIViewController {

    @IBOutlet weak var txtConfirmPass: UITextField!
    @IBOutlet weak var txtNewPass: UITextField!
    @IBOutlet weak var txtOldPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func backAction(_ sender: Any) {
        self.present(SideMenuManager.default.leftMenuNavigationController!, animated: true, completion: nil)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func createAction(_ sender: Any) {
        if txtOldPassword.text == "" {
         //   txtOldPassword.errorMessage = "Please Enter username"
            Loaf("Please Enter username", state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
        else if txtNewPass.text == "" {
           // txtNewPass.errorMessage = "Please Enter password"
            Loaf("Please Enter username", state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
        else if txtConfirmPass.text == "" {
           // txtConfirmPass.errorMessage = "Please Enter password"
            Loaf("Please Enter username", state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
        else if(!isValidPassword(txtOldPassword.text!)){
           // txtOldPassword.errorMessage = "Minimum 6 characters at least 1 Uppercase Alphabet, 1 Lowercase Alphabet, 1 Number and 1 Special Character"
            Loaf("Minimum 6 characters at least 1 Uppercase Alphabet, 1 Lowercase Alphabet, 1 Number and 1 Special Character", state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
        else if(!isValidPassword(txtNewPass.text!)){
           // txtNewPass.errorMessage = "Minimum 6 characters at least 1 Uppercase Alphabet, 1 Lowercase Alphabet, 1 Number and 1 Special Character"
            Loaf("Minimum 6 characters at least 1 Uppercase Alphabet, 1 Lowercase Alphabet, 1 Number and 1 Special Character", state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
        else if(txtNewPass.text == txtConfirmPass.text){
           // txtConfirmPass.errorMessage = "Password does not match"
            Loaf("Password does not match", state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
        else{
            resetPasswordAPI()
        }
    }
    
    func resetPasswordAPI(){
//        showLoader()
//        let params = [
//            "email": DefaultsManager.shared.userEmail ?? "",
//            "password": txtNewPass!.text!,
//            "token": DefaultsManager.shared.accesstoken ?? ""
//          ] as [String : Any]
//        networking.setAuthorizationHeader(token: DefaultsManager.shared.accesstoken ?? "")
//        networking.post(RESETPASSWORD, parameterType: .json, parameters: params) { (result) in
//            hideLoader()
//            do{
//            switch result {
//            case .success(let response):
//                print("responseModel \(response)")
//                Loaf("Cost center created successfully", state: .success, location: .top, sender: self).show(.short, completionHandler: nil)
//                self.view.isUserInteractionEnabled = false
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//                    self.view.isUserInteractionEnabled = true
//                    self.navigationController?.popToRootViewController(animated: true)
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
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension ResetPasswordViewController : UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       if(textField == txtNewPass || textField == txtConfirmPass || textField == txtOldPassword){
            guard let text = textField.text else { return true }
            let allowedCharacters = CharacterSet(charactersIn:"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789$@$!%*?&#")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            
            let newLength = text.utf16.count + string.utf16.count - range.length
        if txtNewPass == textField{
           // txtNewPass.errorMessage = newLength <= 15 && allowedCharacters.isSuperset(of: characterSet) ? "" : "Enter valid password"
        }
        else if(txtConfirmPass == textField){
          //  txtConfirmPass.errorMessage = newLength <= 15 && allowedCharacters.isSuperset(of: characterSet) ? "" : "Enter valid password"
        }
        else{
          //  txtOldPassword.errorMessage = newLength <= 15 && allowedCharacters.isSuperset(of: characterSet) ? "" : "Enter valid password"
        }
            return newLength <= 15 && allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
}

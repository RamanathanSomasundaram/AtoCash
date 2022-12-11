//
//  CreateRoleViewController.swift
//  AtoCash
//
//  Created by user on 12/03/21.
//

import UIKit

class CreateRoleViewController: UIViewController {

    @IBOutlet weak var amountError: UILabel!
    @IBOutlet weak var descError: UILabel!
    @IBOutlet weak var codeError: UILabel!
    @IBOutlet weak var txtMaximumAmount: UITextField!
    @IBOutlet weak var txtRoleDesc: UITextField!
    @IBOutlet weak var txtRoleID: UITextField!
    @IBOutlet weak var createBtn: UIButton!
    var editRolesModel : JobRole?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Do any additional setup after loading the view.
        if editRolesModel == nil {
            self.createBtn.setTitle("CREATE", for: .normal)
        }
        else{
            self.createBtn.setTitle("SAVE", for: .normal)
            self.txtRoleID.text = editRolesModel?.roleCode
            self.txtRoleDesc.text = editRolesModel?.roleName
            self.txtMaximumAmount.text = "\(editRolesModel?.maxPettyCashAllowed ?? 0)"
        }
    }
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func cancelAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func createAction(_ sender: Any) {
        self.codeError.isHidden = true
        self.descError.isHidden = true
        self.amountError.isHidden = true
        if txtRoleID.text == "" && txtRoleDesc.text == "" && txtMaximumAmount.text == "" {
            self.codeError.isHidden = false
            self.descError.isHidden = false
            self.amountError.isHidden = false
        }
        if txtRoleID.text == ""{
            codeError.isHidden = false
            //txtRoleID.errorMessage = "Please Enter Role Code"
            Loaf("Please Enter Role Code", state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
        else if txtRoleDesc.text == "" {
            descError.isHidden = false
           // txtRoleDesc.errorMessage = "Please Enter Role Description"
            Loaf("Please Enter Role Description", state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
        else if txtMaximumAmount.text == "" {
            amountError.isHidden = false
            //txtMaximumAmount.errorMessage = "Please enter the amount"
            Loaf("Please enter the amount", state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
        else{
            self.codeError.isHidden = true
            self.descError.isHidden = true
            self.amountError.isHidden = true
            if editRolesModel == nil {
                self.createCostCenter()
            }
            else{
                self.updateCostCenter()
            }
        }
    }
    
    func createCostCenter(){
        
        showLoader()
        JobRolesAPI.apiJobRolesPostRolePost(body: JobRole(_id: 0, roleCode: self.txtRoleID.text!, roleName: self.txtRoleDesc.text!, maxPettyCashAllowed: Double(self.txtMaximumAmount!.text!)!)) { (result, error) in
            hideLoader()
            if error == nil {
                Loaf("Role created successfully", state: .success, location: .top, sender: self).show(.short, completionHandler: nil)
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
        JobRolesAPI.apiJobRolesPutRoleIdPut(_id: (self.editRolesModel?._id!)!, body: JobRoleDTO(_id: self.editRolesModel?._id, roleCode: self.txtRoleID.text, roleName: self.txtRoleDesc.text, maxPettyCashAllowed: Double(self.txtMaximumAmount.text!))) { (result, error) in
            hideLoader()
            if error == nil {
                Loaf("Role updated successfully", state: .success, location: .top, sender: self).show(.short, completionHandler: nil)
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
    
  

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension CreateRoleViewController : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtRoleID{
        guard let text = textField.text else { return true }
        let allowedCharacters = CharacterSet(charactersIn:"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")//Here change this characters based on your requirement
        let characterSet = CharacterSet(charactersIn: string)
        
        let newLength = text.utf16.count + string.utf16.count - range.length
           // txtRoleID.errorMessage = newLength <= 20 && allowedCharacters.isSuperset(of: characterSet) ? "" : "Enter Maximum 20 character"
        return newLength <= 20 && allowedCharacters.isSuperset(of: characterSet)
        }
        else if(textField == txtRoleDesc){
            guard let text = textField.text else { return true }
            let allowedCharacters = CharacterSet(charactersIn:"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            
            let newLength = text.utf16.count + string.utf16.count - range.length
           // txtRoleDesc.errorMessage = newLength <= 100 && allowedCharacters.isSuperset(of: characterSet) ? "" : "Enter Maximum 100 character"
            return newLength <= 100 && allowedCharacters.isSuperset(of: characterSet)
        }
        else{
            guard let text = textField.text else { return true }
            let allowedCharacters = CharacterSet(charactersIn:"0123456789.")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            
            let newLength = text.utf16.count + string.utf16.count - range.length
            //txtMaximumAmount.errorMessage = newLength <= 6 && allowedCharacters.isSuperset(of: characterSet) ? "" : "Enter Maximum 6 character"
            return newLength <= 10 && allowedCharacters.isSuperset(of: characterSet)
        }
    }
}

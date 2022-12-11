//
//  CreateEmployeeTypeViewController.swift
//  AtoCash
//
//  Created by user on 12/03/21.
//

import UIKit

class CreateEmployeeTypeViewController: UIViewController {
    @IBOutlet weak var txtEmployeeTypeCode: UITextField!
    @IBOutlet weak var txtEmployeeTypeDesc: UITextField!
    @IBOutlet weak var createBtn: UIButton!
    @IBOutlet weak var codeError: UILabel!
    @IBOutlet weak var descError: UILabel!
    var editEmployeeModel : EmploymentType?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if editEmployeeModel == nil {
            self.createBtn.setTitle("CREATE", for: .normal)
        }
        else{
            self.createBtn.setTitle("SAVE", for: .normal)
            self.txtEmployeeTypeCode.text = editEmployeeModel?.empJobTypeCode
            self.txtEmployeeTypeDesc.text = editEmployeeModel?.empJobTypeDesc
        }
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func createAction(_ sender: Any) {
        codeError.isHidden = true
        descError.isHidden = true
        if txtEmployeeTypeCode.text == "" && txtEmployeeTypeDesc.text == "" {
            codeError.isHidden = false
            descError.isHidden = false
        }
        if txtEmployeeTypeCode.text == ""{
            codeError.isHidden = false
            //txtEmployeeTypeCode.errorMessage = "Please Enter Employee Code"
            Loaf("Please Enter Employee Code", state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
        else if txtEmployeeTypeDesc.text == "" {
            descError.isHidden = false
            //txtEmployeeTypeDesc.errorMessage = "Please Enter Employee type Description"
            Loaf("Please Enter Employee Type Description", state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
        else{
            if editEmployeeModel == nil {
                self.createCostCenter()
            }
            else{
                self.updateCostCenter()
            }
        }
    }
    
    func createCostCenter(){
        
        showLoader()
        EmploymentTypesAPI.apiEmploymentTypesPost(body: EmploymentType(_id: 0, empJobTypeCode: self.txtEmployeeTypeCode.text!, empJobTypeDesc: self.txtEmployeeTypeDesc.text!)) { (result, error) in
            hideLoader()
            if error == nil {
                Loaf("Employment type created successfully", state: .success, location: .top, sender: self).show(.short, completionHandler: nil)
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
        EmploymentTypesAPI.apiEmploymentTypesIdPut(_id: self.editEmployeeModel!._id!, body: EmploymentTypeDTO(_id: self.editEmployeeModel!._id!, empJobTypeCode: self.txtEmployeeTypeCode.text, empJobTypeDesc: self.txtEmployeeTypeDesc.text)) { (result, error) in
            hideLoader()
            if error == nil {
                Loaf("Employment type updated successfully", state: .success, location: .top, sender: self).show(.short, completionHandler: nil)
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
extension CreateEmployeeTypeViewController : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtEmployeeTypeCode{
        guard let text = textField.text else { return true }
        let allowedCharacters = CharacterSet(charactersIn:"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")//Here change this characters based on your requirement
        let characterSet = CharacterSet(charactersIn: string)
        
        let newLength = text.utf16.count + string.utf16.count - range.length
        return newLength <= 20 && allowedCharacters.isSuperset(of: characterSet)
        }
        else if(textField == txtEmployeeTypeDesc){
            guard let text = textField.text else { return true }
            let allowedCharacters = CharacterSet(charactersIn:"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            
            let newLength = text.utf16.count + string.utf16.count - range.length
            return newLength <= 100 && allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
}

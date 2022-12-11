//
//  CreateApprovalGroupViewController.swift
//  AtoCash
//
//  Created by user on 12/03/21.
//

import UIKit

class CreateApprovalGroupViewController: UIViewController {

    @IBOutlet weak var descError: UILabel!
    @IBOutlet weak var codeError: UILabel!
    @IBOutlet weak var txtApprovalGroupDesc: UITextField!
    @IBOutlet weak var txtApprovalGroupCode: UITextField!
    @IBOutlet weak var createBtn: UIButton!
    var editApprovalGroup : ApprovalGroup?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if editApprovalGroup == nil {
            self.createBtn.setTitle("CREATE", for: .normal)
        }
        else{
            self.createBtn.setTitle("SAVE", for: .normal)
            self.txtApprovalGroupCode.text = editApprovalGroup?.approvalGroupCode
            self.txtApprovalGroupDesc.text = editApprovalGroup?.approvalGroupDesc
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
        if txtApprovalGroupCode.text == ""{
            codeError.isHidden = false
            Loaf("Please Enter Approval Code", state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
        else if txtApprovalGroupDesc.text == "" {
            descError.isHidden = false
            Loaf("Please Enter Approval Type Description", state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
        else{
           
            if editApprovalGroup == nil {
                self.createCostCenter()
            }
            else{
                self.updateCostCenter()
            }
        }
    }
    
    func createCostCenter(){
        showLoader()
        ApprovalGroupsAPI.apiApprovalGroupsPostApprovalGroupPost(body: ApprovalGroup(_id: 0, approvalGroupCode: self.txtApprovalGroupCode.text!, approvalGroupDesc: self.txtApprovalGroupDesc.text!)) { (result, error) in
            hideLoader()
            if error == nil {
                Loaf("Approval Group created successfully", state: .success, location: .top, sender: self).show(.short, completionHandler: nil)
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
        ApprovalGroupsAPI.apiApprovalGroupsPutApprovalGroupIdPut(_id: self.editApprovalGroup!._id!, body: ApprovalGroupDTO(_id: self.editApprovalGroup!._id!, approvalGroupCode: self.txtApprovalGroupCode.text!, approvalGroupDesc: self.txtApprovalGroupDesc.text!)) { (result, error) in
            hideLoader()
            if error == nil {
                Loaf("Approval Group updated successfully", state: .success, location: .top, sender: self).show(.short, completionHandler: nil)
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
extension CreateApprovalGroupViewController : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtApprovalGroupCode{
        guard let text = textField.text else { return true }
        let allowedCharacters = CharacterSet(charactersIn:"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")//Here change this characters based on your requirement
        let characterSet = CharacterSet(charactersIn: string)
        
        let newLength = text.utf16.count + string.utf16.count - range.length
        return newLength <= 20 && allowedCharacters.isSuperset(of: characterSet)
        }
        else if(textField == txtApprovalGroupDesc){
            guard let text = textField.text else { return true }
            let allowedCharacters = CharacterSet(charactersIn:"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            
            let newLength = text.utf16.count + string.utf16.count - range.length
            return newLength <= 100 && allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
}


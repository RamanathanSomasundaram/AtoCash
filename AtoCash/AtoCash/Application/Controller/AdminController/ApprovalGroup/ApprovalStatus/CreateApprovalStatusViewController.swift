//
//  CreateApprovalStatusViewController.swift
//  AtoCash
//
//  Created by user on 12/03/21.
//

import UIKit

class CreateApprovalStatusViewController: UIViewController {

    @IBOutlet weak var txtApprovalStatusDesc: UITextField!
    @IBOutlet weak var txtApprovelStatusID: UITextField!
    @IBOutlet weak var createBtn: UIButton!
    var editApprovalStatus : ApprovalStatusType?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if editApprovalStatus == nil {
            self.createBtn.setTitle("CREATE", for: .normal)
        }
        else{
            self.createBtn.setTitle("SAVE", for: .normal)
            self.txtApprovelStatusID.text = editApprovalStatus?.status
            self.txtApprovalStatusDesc.text = editApprovalStatus?.statusDesc
        }
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func createAction(_ sender: Any) {
        
        if txtApprovelStatusID.text == ""{
         //   txtApprovelStatusID.errorMessage = "Please Enter Approval Code"
            Loaf("Please Enter Employee Code", state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
        else if txtApprovalStatusDesc.text == "" {
           // txtApprovalStatusDesc.errorMessage = "Please Enter Approval Group Description"
            Loaf("Please Enter Employee Type Description", state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
        else{
          //  txtApprovelStatusID.errorMessage = ""
           // txtApprovalStatusDesc.errorMessage = ""
            if editApprovalStatus == nil {
                self.createCostCenter()
            }
            else{
                self.updateCostCenter()
            }
        }
    }
    
    func createCostCenter(){
        
        showLoader()
        ApprovalStatusTypesAPI.apiApprovalStatusTypesPost(body: ApprovalStatusType(_id: 0, status: self.txtApprovelStatusID.text!, statusDesc: self.txtApprovalStatusDesc.text!)) { (result, error) in
            hideLoader()
            if error == nil {
                Loaf("Approval status type created successfully", state: .success, location: .top, sender: self).show(.short, completionHandler: nil)
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
        
        ApprovalStatusTypesAPI.apiApprovalStatusTypesIdPut(_id: (self.editApprovalStatus?._id!)!, body: ApprovalStatusType(_id: self.editApprovalStatus?._id!, status: self.txtApprovelStatusID.text!, statusDesc: self.txtApprovalStatusDesc.text!)) { (result, error) in
            hideLoader()
            if error == nil {
                Loaf("Approval status type created successfully", state: .success, location: .top, sender: self).show(.short, completionHandler: nil)
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
extension CreateApprovalStatusViewController : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtApprovelStatusID{
        guard let text = textField.text else { return true }
        let allowedCharacters = CharacterSet(charactersIn:"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")//Here change this characters based on your requirement
        let characterSet = CharacterSet(charactersIn: string)
        
        let newLength = text.utf16.count + string.utf16.count - range.length
         //   txtApprovelStatusID.errorMessage = newLength <= 20 && allowedCharacters.isSuperset(of: characterSet) ? "" : "Enter Maximum 20 character"
        return newLength <= 20 && allowedCharacters.isSuperset(of: characterSet)
        }
        else if(textField == txtApprovalStatusDesc){
            guard let text = textField.text else { return true }
            let allowedCharacters = CharacterSet(charactersIn:"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            
            let newLength = text.utf16.count + string.utf16.count - range.length
           // txtApprovalStatusDesc.errorMessage = newLength <= 100 && allowedCharacters.isSuperset(of: characterSet) ? "" : "Enter Maximum 100 character"
            return newLength <= 100 && allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
}


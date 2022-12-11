//
//  CreateApprovalLevelViewController.swift
//  AtoCash
//
//  Created by user on 12/03/21.
//

import UIKit

class CreateApprovalLevelViewController: UIViewController {

    @IBOutlet weak var descError: UILabel!
    @IBOutlet weak var codeError: UILabel!
    @IBOutlet weak var txtApprovalGroupDesc: UITextField!
    @IBOutlet weak var txtApprovalGroupCode: UITextField!
    @IBOutlet weak var createBtn: UIButton!
    var editApprovalGroup : ApprovalLevelDTO?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if editApprovalGroup == nil {
            self.createBtn.setTitle("CREATE", for: .normal)
        }
        else{
            self.createBtn.setTitle("SAVE", for: .normal)
            self.txtApprovalGroupCode.text = "\(editApprovalGroup!.level!)"
            self.txtApprovalGroupDesc.text = editApprovalGroup?.levelDesc
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
            Loaf("Please Enter Approval Level Code", state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
        else if txtApprovalGroupDesc.text == "" {
            descError.isHidden = false
            Loaf("Please Enter Approval Level Description", state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
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
        ApprovalLevelsAPI.apiApprovalLevelsPost(body: ApprovalLevelDTO(_id: 0, level: Int(self.txtApprovalGroupCode.text!), levelDesc: self.txtApprovalGroupDesc.text)) { (result, error) in
            hideLoader()
            if error == nil {
                Loaf("Approval Level created successfully", state: .success, location: .top, sender: self).show(.short, completionHandler: nil)
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
        ApprovalLevelsAPI.apiApprovalLevelsIdPut(_id: self.editApprovalGroup!._id!, body: ApprovalLevelDTO(_id: self.editApprovalGroup!._id!, level: Int(self.txtApprovalGroupCode.text!), levelDesc: self.txtApprovalGroupDesc.text)) { (result, error) in
            hideLoader()
            if error == nil {
                Loaf("Approval Level updated successfully", state: .success, location: .top, sender: self).show(.short, completionHandler: nil)
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
extension CreateApprovalLevelViewController : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtApprovalGroupCode{
        guard let text = textField.text else { return true }
        let allowedCharacters = CharacterSet(charactersIn:"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")//Here change this characters based on your requirement
        let characterSet = CharacterSet(charactersIn: string)
        
        let newLength = text.utf16.count + string.utf16.count - range.length
            //txtApprovalGroupCode.errorMessage = newLength <= 20 && allowedCharacters.isSuperset(of: characterSet) ? "" : "Enter Maximum 20 character"
        return newLength <= 20 && allowedCharacters.isSuperset(of: characterSet)
        }
        else if(textField == txtApprovalGroupDesc){
            guard let text = textField.text else { return true }
            let allowedCharacters = CharacterSet(charactersIn:"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            
            let newLength = text.utf16.count + string.utf16.count - range.length
            //txtApprovalGroupDesc.errorMessage = newLength <= 100 && allowedCharacters.isSuperset(of: characterSet) ? "" : "Enter Maximum 100 character"
            return newLength <= 100 && allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
}


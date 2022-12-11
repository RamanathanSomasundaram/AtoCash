//
//  ForgetPasswordViewController.swift
//  AtoCash
//
//  Created by user on 17/03/21.
//

import UIKit
import Foundation
class ForgetPasswordViewController: UIViewController {

    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var lblEmailAddress: UILabel!
    @IBOutlet weak var forgetTitle: UILabel!
    @IBOutlet weak var txtEmailAddress: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //txtEmailAddress.textAlignment = .defaultAlignment
        self.setupUI()
    }
    override var prefersStatusBarHidden: Bool{
        return false
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setupUI(){
        self.txtEmailAddress.textAlignment = .defaultAlignment
        self.forgetTitle.text = NSLocalizedString("forget_title", comment: "")
        self.lblEmailAddress.text = NSLocalizedString("email", comment: "")
        self.submitBtn.setTitle(NSLocalizedString("submit", comment: ""), for: .normal)
    }
    
    @IBAction func submitAction(_ sender: Any) {
        if(txtEmailAddress.text == ""){
            //txtEmailAddress.errorMessage = "Please Enter email address"
            Loaf(NSLocalizedString("email_error", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
        else if(!UtilsManager.isValidEmail(self.txtEmailAddress!.text!)){
            //txtEmailAddress.errorMessage = "Please Enter valid email address"
            Loaf(NSLocalizedString("email_error", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
        else{
            resetPasswordAPI()
        }
    }
    func resetPasswordAPI(){
        
        showLoader()
        AccountAPI.apiAccountForgotPasswordPost(body: ForgotPasswordVM(email: self.txtEmailAddress!.text!)) { (result, error) in
            hideLoader()
            if error == nil {
                Loaf(NSLocalizedString("forgot_success", comment: ""), state: .success, location: .top, sender: self).show(.short, completionHandler: nil)
                self.view.isUserInteractionEnabled = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.view.isUserInteractionEnabled = true
                    self.dismiss(animated: true, completion: nil)                }
            }
            else{
                switch error as! ErrorResponse {
                case .error(let code, let result, let message):
                    print(code,result,message)

                        do{
                            let json = try JSONSerialization.jsonObject(with: result!, options: .allowFragments) as! [String: AnyObject]
                            Loaf((json["message"] as! String), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
                        }
                        catch{
                            Loaf(NSLocalizedString("email_error", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
                            print("json error \(error.localizedDescription)")
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
extension ForgetPasswordViewController : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return true
    }
}

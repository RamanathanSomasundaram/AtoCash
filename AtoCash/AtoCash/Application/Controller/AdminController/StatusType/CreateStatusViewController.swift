//
//  CreateStatusViewController.swift
//  AtoCash
//
//  Created by user on 19/04/21.
//

import UIKit

class CreateStatusViewController: UIViewController {

    var editApprovalStatus : StatusType?
    @IBOutlet weak var createBtn: UIButton!

    
    @IBOutlet weak var txtStatus: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        if editApprovalStatus == nil {
            self.createBtn.setTitle("CREATE", for: .normal)
        }
        else{
            self.createBtn.setTitle("SAVE", for: .normal)
            self.txtStatus.text = editApprovalStatus?.status
           
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func createAction(_ sender: Any) {
        
        if txtStatus.text == ""{
         //   txtApprovelStatusID.errorMessage = "Please Enter Approval Code"
            Loaf("Please Enter Employee Code", state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
       
       
        else{
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
//        StatusTypesAPI.apiStatusTypesPostStatusTypePost(body: <#T##StatusType?#>, completion: <#T##((StatusType?, Error?) -> Void)##((StatusType?, Error?) -> Void)##(StatusType?, Error?) -> Void#>)(body:  CurrencyType(_id: 0, currencyCode: self.txtStatusCode!.text!, currencyName: self.txtStatusName.text!, country: self.txtApprovalCountry.text!, statusType: StatusType(_id: self.selectedStatusType!._id!, status: self.selectedStatusType!.status), statusTypeId: self.selectedStatusType!._id!)) { (result, error) in
//            hideLoader()
//            if error == nil {
//                Loaf("Currency type created successfully", state: .success, location: .top, sender: self).show(.short, completionHandler: nil)
//                self.view.isUserInteractionEnabled = false
//                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//                    self.view.isUserInteractionEnabled = true
//                    self.navigationController?.popViewController(animated: true)
//                }
//            }
//            else{
//                switch error as! ErrorResponse {
//                case .error(let code, let result, let message):
//                    print(code,result,message)
//                    if code == 401 {
//                        DefaultsManager.shared.accesstoken = ""
//                        DefaultsManager.shared.userRole = ""
//                        DefaultsManager.shared.isRemoved = false
//                        AppDelegate.shared.setupRootViewController()
//                    }
//                    else{
//                        do{
//                            let json = try JSONSerialization.jsonObject(with: result!, options: .allowFragments) as! [String: AnyObject]
//                            Loaf((json["message"] as! String), state: .success, location: .top, sender: self).show(.short, completionHandler: nil)
//                        }
//                        catch{
//                            print("json error \(error.localizedDescription)")
//                        }
//                    }
//
//                }
//            }
//        }
    }
    
    func updateCostCenter(){
        showLoader()
        
//        CurrencyTypesAPI.apiCurrencyTypesPutCurrencyTypeIdPut(_id: self.editApprovalStatus!._id!, body: CurrencyTypeDTO(_id: self.editApprovalStatus!._id!, currencyCode: self.txtStatusCode.text!, currencyName: self.txtStatusName.text!, country: self.txtApprovalCountry.text!, statusTypeId: self.selectedStatusType!._id!)) { (result, error) in
//            hideLoader()
//            if error == nil {
//                Loaf("Currency type updated successfully", state: .success, location: .top, sender: self).show(.short, completionHandler: nil)
//                self.view.isUserInteractionEnabled = false
//                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//                    self.view.isUserInteractionEnabled = true
//                    self.navigationController?.popViewController(animated: true)
//                }
//            }
//            else{
//                switch error as! ErrorResponse {
//                case .error(let code, let result, let message):
//                    print(code,result,message)
//                    if code == 401 {
//                        DefaultsManager.shared.accesstoken = ""
//                        DefaultsManager.shared.userRole = ""
//                        DefaultsManager.shared.isRemoved = false
//                        AppDelegate.shared.setupRootViewController()
//                    }
//                    else{
//                        do{
//                            let json = try JSONSerialization.jsonObject(with: result!, options: .allowFragments) as! [String: AnyObject]
//                            Loaf((json["message"] as! String), state: .success, location: .top, sender: self).show(.short, completionHandler: nil)
//                        }
//                        catch{
//                            print("json error \(error.localizedDescription)")
//                        }
//                    }
//
//                }
//            }
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

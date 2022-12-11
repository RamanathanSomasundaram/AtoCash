//
//  CreateCurrencyViewController.swift
//  AtoCash
//
//  Created by user on 08/04/21.
//

import UIKit

class CreateCurrencyViewController: UIViewController {

    @IBOutlet weak var txtStatusCode: UITextField!
    @IBOutlet weak var txtStatusName: UITextField!
    @IBOutlet weak var txtApprovalCountry: UITextField!
    @IBOutlet weak var txtApprovelStatus: UITextField!
    @IBOutlet weak var createBtn: UIButton!
    var selectedStatusType : StatusType?

    var editApprovalStatus : CurrencyTypeDTO?
    var getCostCenter = [CostCenterVM]()
    var selectCostCenter : CostCenterDTO?
    var statusTypeList = [StatusTypeVM]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtApprovalCountry.setupRightPadview()
        self.txtApprovelStatus.setupRightPadview()
        // Do any additional setup after loading the view.
        self.getStatusType()
        if editApprovalStatus == nil {
            self.createBtn.setTitle("CREATE", for: .normal)
        }
        else{
            self.createBtn.setTitle("SAVE", for: .normal)
            self.txtStatusCode.text = editApprovalStatus?.currencyCode
            self.txtStatusName.text = editApprovalStatus?.country
            if editApprovalStatus?.statusTypeId == 1{
                self.txtApprovelStatus.text = "Active"

            }else{
                self.txtApprovelStatus.text = "InActive"

            }
        }
        StatusTypesAPI.apiStatusTypesGetStatusTypeIdGet(_id: editApprovalStatus!.statusTypeId!) { (status, error) in
            if error == nil{
                self.selectedStatusType = status
                self.txtStatusName.text = status?.status
            }
        }
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func createAction(_ sender: Any) {
        
        if txtStatusCode.text == ""{
         //   txtApprovelStatusID.errorMessage = "Please Enter Approval Code"
            Loaf("Please Enter Employee Code", state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
        else if txtStatusName.text == "" {
           // txtApprovalStatusDesc.errorMessage = "Please Enter Approval Group Description"
            Loaf("Please Enter Employee Type Description", state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
        else if txtApprovalCountry.text == "" {
            Loaf("Please select country", state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
        else if txtApprovelStatus.text == "" {
            Loaf("Please select approval status", state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
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
    
    
    func getStatusType(){
        StatusTypesAPI.apiStatusTypesStatusTypesForDropdownGet { (statusList, error) in
            if error == nil {
                self.statusTypeList = statusList ?? []
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
    
    func createCostCenter(){
       
        showLoader()
//        CurrencyTypesAPI.apiCurrencyTypesPostCurrencyTypePost(body:  CurrencyType(_id: 0, currencyCode: self.txtStatusCode!.text!, currencyName: self.txtStatusName.text!, country: self.txtApprovalCountry.text!, statusType: StatusType(_id: self.selectedStatusType!._id!, status: self.selectedStatusType!.status), statusTypeId: self.selectedStatusType!._id!)) { (result, error) in
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
//                             Loaf((json["message"] as! String), state: .error,location: .top, sender: self).show(.short, completionHandler: nil)
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
        
        CurrencyTypesAPI.apiCurrencyTypesPutCurrencyTypeIdPut(_id: self.editApprovalStatus!._id!, body: CurrencyTypeDTO(_id: self.editApprovalStatus!._id!, currencyCode: self.txtStatusCode.text!, currencyName: self.txtStatusName.text!, country: self.txtApprovalCountry.text!, statusTypeId: self.selectedStatusType!._id!)) { (result, error) in
            hideLoader()
            if error == nil {
                Loaf("Currency type updated successfully", state: .success, location: .top, sender: self).show(.short, completionHandler: nil)
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
    
  

}
extension CreateCurrencyViewController : UITextFieldDelegate{
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
     
        if txtApprovalCountry == textField{
            let simpleArray: [String] = nationality
            var simpleSelectedArray: [String] = []
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
            }
            
            // show searchbar with placeholder and barTintColor
            selectionMenu.showSearchBar(withPlaceHolder: "Search nationality", barTintColor: UIColor.lightGray.withAlphaComponent(0.2)) { (searchText) -> ([String]) in

                return simpleArray.filter({ $0.lowercased().starts(with: searchText.lowercased()) })
            }
            selectionMenu.show(style: .popover(sourceView: textField, size: CGSize(width: textField.frame.size.width, height: 230)), from: self)
            return false
        }
        if textField == txtApprovelStatus{
            var projectTitle = [String]()
            for dropDown in self.statusTypeList{
                projectTitle.append(dropDown.status!)
            }
            
            let simpleArray: [String] = projectTitle
            var simpleSelectedArray: [String] = selectedStatusType == nil ? [] : [selectedStatusType!.status]
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
                for drop in self.statusTypeList{
                    if drop.status == item!{
                        self.selectedStatusType = StatusType(_id: drop._id, status: drop.status!)
                        break
                    }
                }
                
            }
            
            // show searchbar with placeholder and barTintColor
            selectionMenu.showSearchBar(withPlaceHolder: "Search status type", barTintColor: UIColor.init(named: "NavBar")!.withAlphaComponent(0.2)) { (searchText) -> ([String]) in
                
                return simpleArray.filter({ $0.lowercased().contains(searchText.lowercased()) })
            }
            selectionMenu.show(style: .popover(sourceView: textField, size: CGSize(width: textField.frame.size.width, height: 230)), from: self)
            
            
            return false
        }
        return true
    }
    
    
   
}

//
//  CreateExpenseTypeViewController.swift
//  AtoCash
//
//  Created by user on 12/03/21.
//

import UIKit

class CreateExpenseTypeViewController: UIViewController {
    @IBOutlet weak var statusType: UITextField!

    @IBOutlet weak var statusError: UILabel!
    @IBOutlet weak var descError: UILabel!
    @IBOutlet weak var codeError: UILabel!
    @IBOutlet weak var txtExpenseTypeDesc: UITextField!
    @IBOutlet weak var txtExpenseType: UITextField!
    @IBOutlet weak var createBtn: UIButton!
    var editExpenseType : ExpenseTypeDTO?
    var selectedStatusType : StatusType?
    var statusTypeList = [StatusTypeVM]()
    override func viewDidLoad() {
        super.viewDidLoad()
        statusType.setupRightPadview()
        self.getStatusTypeList()
        // Do any additional setup after loading the view.
        if editExpenseType == nil {
            self.createBtn.setTitle("CREATE", for: .normal)
        }
        else{
            self.createBtn.setTitle("SAVE", for: .normal)
            self.txtExpenseType.text = editExpenseType?.expenseTypeName
            self.txtExpenseTypeDesc.text = editExpenseType?.expenseTypeDesc
            StatusTypesAPI.apiStatusTypesGetStatusTypeIdGet(_id: (self.editExpenseType?.statusTypeId)!) { (status, error) in
                if error == nil{
                    self.selectedStatusType = status
                    self.statusType.text = status?.status
                }
            }
        }

    }
    private func getStatusTypeList(){
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
    @IBAction func cancelAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func createAction(_ sender: Any) {
        codeError.isHidden = true
        descError.isHidden = true
        statusError.isHidden = true
        if txtExpenseType.text == "" && txtExpenseTypeDesc.text == "" && statusType.text == "" {
            codeError.isHidden = false
            descError.isHidden = false
            statusError.isHidden = false
        }
        else if txtExpenseType.text == ""{
            codeError.isHidden = false
            //txtExpenseType.errorMessage = "Please Enter Expense Type"
            Loaf("Please Enter Employee Code", state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
        else if txtExpenseTypeDesc.text == "" {
            descError.isHidden = false
           // txtExpenseTypeDesc.errorMessage = "Please Enter Expense type Description"
            Loaf("Please Enter Employee Type Description", state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
        else if(statusType.text == ""){
            statusError.isHidden = false
            // txtExpenseTypeDesc.errorMessage = "Please Enter Expense type Description"
             Loaf("Please select status type", state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
        else{
            if editExpenseType == nil {
                self.createCostCenter()
            }
            else{
                self.updateCostCenter()
            }
        }
    }
    
    func createCostCenter(){
        showLoader()
        ExpenseTypesAPI.apiExpenseTypesPostExpenseTypePost(body: ExpenseTypeDTO(_id: 0, expenseTypeName: self.txtExpenseType.text, expenseTypeDesc: self.txtExpenseTypeDesc.text, statusType: self.selectedStatusType!.status, statusTypeId: self.selectedStatusType?._id)) { (result, error) in
            hideLoader()
            if error == nil {
                Loaf("Expense type created successfully", state: .success, location: .top, sender: self).show(.short, completionHandler: nil)
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
        ExpenseTypesAPI.apiExpenseTypesPutExpenseTypeIdPut(_id: self.editExpenseType!._id!, body: ExpenseTypeDTO(_id: self.editExpenseType!._id!, expenseTypeName: self.txtExpenseType.text, expenseTypeDesc: self.txtExpenseTypeDesc.text, statusType: self.selectedStatusType?.status, statusTypeId: self.selectedStatusType?._id)) { (result, error) in
            hideLoader()
            if error == nil {
                Loaf("Expense type updated successfully", state: .success, location: .top, sender: self).show(.short, completionHandler: nil)
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
extension CreateExpenseTypeViewController : UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == statusType{
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
            if #available(iOS 13.0, *) {
                selectionMenu.searchBar?.searchTextField.textColor = .white
            } else {
                // Fallback on earlier versions
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

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtExpenseType{
        guard let text = textField.text else { return true }
        let allowedCharacters = CharacterSet(charactersIn:"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")//Here change this characters based on your requirement
        let characterSet = CharacterSet(charactersIn: string)
        
        let newLength = text.utf16.count + string.utf16.count - range.length
        return newLength <= 20 && allowedCharacters.isSuperset(of: characterSet)
        }
        else if(textField == txtExpenseTypeDesc){
            guard let text = textField.text else { return true }
            let allowedCharacters = CharacterSet(charactersIn:"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            
            let newLength = text.utf16.count + string.utf16.count - range.length
            return newLength <= 100 && allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
}

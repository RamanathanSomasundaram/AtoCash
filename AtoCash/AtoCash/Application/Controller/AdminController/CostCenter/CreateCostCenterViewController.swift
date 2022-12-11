//
//  CreateCostCenterViewController.swift
//  AtoCash
//
//  Created by user on 12/03/21.
//

import UIKit

class CreateCostCenterViewController: UIViewController {

    @IBOutlet weak var statusError: UILabel!
    @IBOutlet weak var codeIdError: UILabel!
    @IBOutlet weak var codeDescError: UILabel!
    @IBOutlet weak var statusType: UITextField!
    @IBOutlet weak var createBtn: UIButton!
    @IBOutlet weak var txtCostDesc: UITextField!
    @IBOutlet weak var txtCostId: UITextField!
    var editCostCenter : CostCenterDTO?
    var selectedStatusType : StatusType?
    var statusTypeList = [StatusTypeVM]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.getStatusTypeList()
        if editCostCenter == nil {
            self.createBtn.setTitle("CREATE", for: .normal)
        }
        else{
            self.createBtn.setTitle("SAVE", for: .normal)
            self.txtCostId.text = editCostCenter?.costCenterCode
            self.txtCostDesc.text = editCostCenter?.costCenterDesc
            StatusTypesAPI.apiStatusTypesGetStatusTypeIdGet(_id: (self.editCostCenter?.statusTypeId)!) { (status, error) in
                if error == nil{
                    self.selectedStatusType = status
                    self.statusType.text = status?.status
                }
            }
        }

        let rightView2 = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 40))
        statusType.rightViewMode = UITextField.ViewMode.always
        let imageView2 = UIImageView(frame: CGRect(x: 8, y: 10, width: 20, height: 20))
        let image2 = UIImage(named: "icons8-sort-down-100")
        imageView2.image = image2
        rightView2.addSubview(imageView2)
        statusType.rightView = rightView2
        statusType.rightViewMode = .always
    }
    @IBAction func cancelAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func createAction(_ sender: Any) {
        statusError.isHidden = true
        codeIdError.isHidden = true
        codeDescError.isHidden = true
        if txtCostId.text == "" && txtCostDesc.text == "" && statusType.text == "" {
            statusError.isHidden = false
            codeIdError.isHidden = false
            codeDescError.isHidden = false
        }
        if txtCostId.text == ""{
            codeIdError.isHidden = false
            Loaf("Please Enter Cost Center Code", state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
        else if txtCostDesc.text == "" {
            codeDescError.isHidden = false
            Loaf("Please Enter Cost Center Description", state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
        else if statusType.text == "" {
            statusError.isHidden = false
            Loaf("Please select status type", state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
        else{
            statusError.isHidden = true
            codeIdError.isHidden = true
            codeDescError.isHidden = true
            if editCostCenter == nil {
                self.createCostCenter()
            }
            else{
                self.updateCostCenter()
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
    
    private func createCostCenter(){
        showLoader()
        let params = CostCenterDTO(_id: self.editCostCenter == nil ? 0 : self.editCostCenter?._id, costCenterCode: self.txtCostId.text, costCenterDesc: self.txtCostDesc.text, statusTypeId: self.selectedStatusType?._id, statusType: self.selectedStatusType?.status)
        CostCentersAPI.apiCostCentersPostCostCenterPost(body: params) { (result, error) in
            hideLoader()
            if error == nil {
                if result?.status == "Success"{
                    Loaf(result?.message ?? "", state: .success, location: .top, sender: self).show(.short, completionHandler: nil)
                }
                else{
                    Loaf(result?.message ?? "", state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
                }
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
        
        CostCentersAPI.apiCostCentersPutCostCenterIdPut(_id: (self.editCostCenter?._id)!, body: CostCenterDTO(_id: self.editCostCenter?._id, costCenterCode: self.txtCostId.text, costCenterDesc: self.txtCostDesc.text, statusTypeId: self.selectedStatusType?._id, statusType: self.selectedStatusType?.status)) { (result, error) in
            hideLoader()
            if error == nil {
                if result?.status == "Success"{
                    Loaf(result?.message ?? "", state: .success, location: .top, sender: self).show(.short, completionHandler: nil)
                }
                else{
                    Loaf(result?.message ?? "", state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
                }
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
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
extension CreateCostCenterViewController : UITextFieldDelegate{
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
        if textField == txtCostId{
        guard let text = textField.text else { return true }
        let allowedCharacters = CharacterSet(charactersIn:"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")//Here change this characters based on your requirement
        let characterSet = CharacterSet(charactersIn: string)
        
        let newLength = text.utf16.count + string.utf16.count - range.length
           // txtCostId.errorMessage = newLength <= 20 && allowedCharacters.isSuperset(of: characterSet) ? "" : "Enter Maximum 20 character"
        return newLength <= 20 && allowedCharacters.isSuperset(of: characterSet)
        }
        else if textField == txtCostDesc{
            guard let text = textField.text else { return true }
            let allowedCharacters = CharacterSet(charactersIn:"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            
            let newLength = text.utf16.count + string.utf16.count - range.length
            //txtCostDesc.errorMessage = newLength <= 100 && allowedCharacters.isSuperset(of: characterSet) ? "" : "Enter Maximum 100 character"
            return newLength <= 100 && allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
}

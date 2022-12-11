//
//  CreateTaskViewController.swift
//  AtoCash
//
//  Created by user on 12/03/21.
//

import UIKit

class CreateTaskViewController: UIViewController {

    @IBOutlet weak var txtCostCenterID: InputTextFieldDesign!
    @IBOutlet weak var txtProjectDEsc: InputTextFieldDesign!
    @IBOutlet weak var txtProjectID: InputTextFieldDesign!
    @IBOutlet weak var createBtn: UIButton!
    var getCostCenter = [SubprojectModel]()
    var selectCostCenter : SubprojectModel?
    var editProjectModel : TaskModel?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Do any additional setup after loading the view.
        self.txtCostCenterID.setupRightPaddingView()
        if editProjectModel == nil {
            self.createBtn.setTitle("CREATE", for: .normal)
        }
        else{
            self.createBtn.setTitle("SAVE", for: .normal)
            self.txtProjectID.text = editProjectModel?.taskName
            self.txtProjectDEsc.text = editProjectModel?.taskDesc
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getAllCostCenters()
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func cancelAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func createAction(_ sender: Any) {
        if txtProjectID.text == ""{
            txtProjectID.errorMessage = "Please Enter Project Code"
            Loaf("Please Enter Project Code", state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
        else if txtProjectDEsc.text == "" {
            txtProjectDEsc.errorMessage = "Please Enter Department Description"
            Loaf("Please Enter Department Description", state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
        else if txtCostCenterID.text == "" {
            txtCostCenterID.errorMessage = "Please select cost center"
            Loaf("Please select cost center", state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
        else{
            txtProjectID.errorMessage = ""
            txtProjectDEsc.errorMessage = ""
            txtCostCenterID.errorMessage = ""
            if editProjectModel == nil {
                self.createCostCenter()
            }
            else{
                self.updateCostCenter()
            }
        }
    }
    
    func createCostCenter(){
//        showLoader()
//        let params = ["taskName": self.txtProjectID!.text!,
//                      "taskDesc": self.txtProjectDEsc!.text!,"subProjectId": self.selectCostCenter!.id!] as [String : Any]
//        networking.setAuthorizationHeader(token: DefaultsManager.shared.accesstoken ?? "")
//        networking.post(POST_WORKTASK, parameterType: .json, parameters: params) { (result) in
//            hideLoader()
//            do{
//            switch result {
//            case .success(let response):
//                print("responseModel \(response)")
//                Loaf("Cost center created successfully", state: .success, location: .bottom, sender: self).show(.short, completionHandler: nil)
//                self.view.isUserInteractionEnabled = false
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//                    self.view.isUserInteractionEnabled = true
//                    self.navigationController?.popViewController(animated: true)
//                }
//
//            break
//            case .failure(let error):
//                if error.statusCode == 401{
//                    DefaultsManager.shared.accesstoken = ""
//                    DefaultsManager.shared.userRole = ""
//                    AppDelegate.shared.setupRootViewController()
//                }
//                print("error \(error.fullResponse)")
//                break
//            }
//            }
//
//        }
    }
    
    func updateCostCenter(){
//        showLoader()
//        let params = ["id": self.editProjectModel!.id!,"taskName": self.txtProjectID!.text!,
//                      "taskDesc": self.txtProjectDEsc!.text!,"subProjectId": self.selectCostCenter!.id!] as [String : Any]
//        networking.setAuthorizationHeader(token: DefaultsManager.shared.accesstoken ?? "")
//            networking.put(PUT_WORKTASK + "\(self.editProjectModel!.id!)", parameterType: .json, parameters: params) { (result) in
//            hideLoader()
//            do{
//            switch result {
//            case .success(let response):
//                print("responseModel \(response)")
//                Loaf("Cost center updated successfully", state: .success, location: .bottom, sender: self).show(.short, completionHandler: nil)
//                self.view.isUserInteractionEnabled = false
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//                    self.view.isUserInteractionEnabled = true
//                    self.navigationController?.popViewController(animated: true)
//                }
//
//            break
//            case .failure(let error):
//                if error.statusCode == 401{
//                    DefaultsManager.shared.accesstoken = ""
//                    DefaultsManager.shared.userRole = ""
//                    AppDelegate.shared.setupRootViewController()
//                }
//                print("error \(error.fullResponse)")
//                break
//            }
//            }
//
//        }
    }
    
    
    private func getAllCostCenters(){
//        showLoader()
//        networking.setAuthorizationHeader(token: DefaultsManager.shared.accesstoken ?? "")
//        networking.get(SUBPROJECT) { result in
//            hideLoader()
//            switch result {
//            case .success(let response):
//                do{
//                let jsonDecoder = JSONDecoder()
//                    let responseModel = try jsonDecoder.decode([SubprojectModel].self, from: response.data)
//                    self.getCostCenter = responseModel
//                    if self.editProjectModel != nil {
//                        let cost = self.getCostCenter.filter({ (result) -> Bool in
//                            return result.id == self.editProjectModel?.subProjectId
//                        })
//                        self.txtCostCenterID.text = "\(cost.first!.subProjectName!) - \(cost.first!.subProjectDesc!)"
//                        self.selectCostCenter = cost.first
//                    }
//                }
//                catch {
//                    print("Decoding Error \(error)")
//                }
//                // Do something with JSON, you can also get arrayBody
//            case .failure(let response):
//                // Handle error
//            print("error \(response)")
//                if response.statusCode == 401{
//                    DefaultsManager.shared.accesstoken = ""
//                    DefaultsManager.shared.userRole = ""
//                    AppDelegate.shared.setupRootViewController()
//                }
//                self.getCostCenter = []
//                Loaf(response.fullResponse.description, state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
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
extension CreateTaskViewController : UITextFieldDelegate{
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtCostCenterID{
            var projectTitle = [String]()
            for dropDown in self.getCostCenter{
                projectTitle.append("\(dropDown.subProjectName!) - \(dropDown.subProjectDesc!)")
            }
            
            let simpleArray: [String] = projectTitle
            var simpleSelectedArray: [String] = selectCostCenter == nil ? [] : ["\(selectCostCenter!.subProjectName!) - \(selectCostCenter!.subProjectDesc!)"]
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
                for drop in self.getCostCenter{
                    if "\(drop.subProjectName!) - \(drop.subProjectDesc!)" == item!{
                        self.selectCostCenter = drop
                        break
                    }
                }
            }
            selectionMenu.show(style: .popover(sourceView: textField, size: CGSize(width: textField.frame.size.width, height: 230)), from: self)
            
            return false
        }
        return true
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtProjectID{
        guard let text = textField.text else { return true }
        let allowedCharacters = CharacterSet(charactersIn:"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")//Here change this characters based on your requirement
        let characterSet = CharacterSet(charactersIn: string)
        
        let newLength = text.utf16.count + string.utf16.count - range.length
            txtProjectID.errorMessage = newLength <= 20 && allowedCharacters.isSuperset(of: characterSet) ? "" : "Enter Maximum 20 character"
        return newLength <= 20 && allowedCharacters.isSuperset(of: characterSet)
        }
        else if(textField == txtProjectDEsc){
            guard let text = textField.text else { return true }
            let allowedCharacters = CharacterSet(charactersIn:"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            
            let newLength = text.utf16.count + string.utf16.count - range.length
            txtProjectDEsc.errorMessage = newLength <= 100 && allowedCharacters.isSuperset(of: characterSet) ? "" : "Enter Maximum 100 character"
            return newLength <= 100 && allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
}

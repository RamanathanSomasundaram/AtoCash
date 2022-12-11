//
//  CreateExpenseViewController.swift
//  AtoCash
//
//  Created by user on 18/04/21.
//

import UIKit

protocol createExpenseViewDelegate : NSObjectProtocol {
    func expenseViewUIupdate(_ info : [String : Any?])
}

class CreateExpenseViewController: UIViewController {

    @IBOutlet weak var createBtn: UIButton!
    @IBOutlet weak var txtTask: UITextField!
    @IBOutlet weak var txtSubProject: UITextField!
    @IBOutlet weak var txtProjectId: UITextField!
    @IBOutlet weak var txtCurrency: UITextField!

    @IBOutlet weak var txtExpense: UITextField!
    
    @IBOutlet weak var projectBaseView: UIStackView!
    @IBOutlet weak var taskView: UIView!
    @IBOutlet weak var subProjectView: UIView!
    
    weak var expenseDelegate : createExpenseViewDelegate?

    @IBOutlet weak var toggleSwitch: UISwitch!
    
    //UI Localization
    @IBOutlet weak var segmentToggle: UISegmentedControl!
    
    @IBOutlet weak var TexpenseLbl: UILabel!
    @IBOutlet weak var TcurrencyLbl: UILabel!
    @IBOutlet weak var Texpensetitle: UILabel!
    @IBOutlet weak var TenableTitle: UILabel!
    @IBOutlet weak var TworkTitle: UILabel!
    @IBOutlet weak var TsubTitle: UILabel!
    @IBOutlet weak var TprojectTitle: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
    
    var projectList = [ProjectVM]()
    var selectedProject : ProjectVM?
    
    var subProject = [SubProjectVM]()
    var selectSubproject : SubProjectVM?
    
    var workTask = [TaskModel]()
    var selectWorkTask : TaskModel?
    var viewDetailModel : [String : Any?]?
    var selectSegmentIndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        self.txtTask.setupRightPadview()
        self.txtSubProject.setupRightPadview()
        self.txtProjectId.setupRightPadview()
        self.txtCurrency.setupRightPadview()
        if selectSegmentIndex > 0 {
            self.TenableTitle.isHidden = true
            self.toggleSwitch.isHidden = true
        }
        else{
            self.toggleSwitch.isOn = true
            self.toggleSwitch.isUserInteractionEnabled = false
        }
        
        self.txtCurrency.text = DefaultsManager.shared.currencyType
        if viewDetailModel == nil{
            self.toggleSwitch.isOn = true
            self.toggleSwitch.isUserInteractionEnabled = false
            self.setupViewHideShow()
        }
        else{
            if (self.viewDetailModel!["type"] as! String) == "Project"{
                self.toggleSwitch.isUserInteractionEnabled = false
                self.toggleSwitch.isOn = true
                if let project = viewDetailModel!["project"] as? ProjectVM{
                    self.toggleSwitch.isOn = true
                    self.txtProjectId.text = project.projectName
                    self.selectedProject = project
                }
                if let subproject = viewDetailModel!["subProject"] as? SubProjectVM{
                    self.txtSubProject.text = subproject.subProjectName
                    self.subProjectView.isHidden = false
                    self.selectSubproject = subproject
                }
                if let task = viewDetailModel!["task"] as? TaskModel{
                    self.taskView.isHidden = false
                    self.txtTask.text = task.taskName
                    self.selectWorkTask = task
                }
//                self.toggleSwitch.isHidden = false
//                self.TenableTitle.isHidden = false
                
            }
            else if (self.viewDetailModel!["type"] as! String) == "Business Area" {
                segmentToggle.selectedSegmentIndex = 2
                self.toggleSwitch.isHidden = true
                self.TenableTitle.isHidden = true
                self.toggleSwitch.isOn = false
            }
            else{
                segmentToggle.selectedSegmentIndex = 1
                self.toggleSwitch.isHidden = true
                self.TenableTitle.isHidden = true
                self.toggleSwitch.isOn = false
            }
            self.setupViewHideShow()
            self.txtExpense.text = (viewDetailModel!["title"] as! String)
        }
        setupViewHideShow()
        //self.getCurrencyList()
        self.getAllProjects()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.islangauge(self.currentLanguage()){ return}
        self.setupUI()
    }
    
    private func setupUI(){
        self.TexpenseLbl.text = NSLocalizedString("create_expense_title", comment: "")
        self.TcurrencyLbl.text = NSLocalizedString("currency", comment: "")
        self.Texpensetitle.text = NSLocalizedString("expense_title", comment: "")
        self.TprojectTitle.text = NSLocalizedString("project", comment: "")
        self.TsubTitle.text = NSLocalizedString("subproject", comment: "")
        self.TworkTitle.text = NSLocalizedString("work_task", comment: "")
        self.TenableTitle.text = NSLocalizedString("enable_project", comment: "")
        self.cancelBtn.setTitle(NSLocalizedString("cancel", comment: ""), for: .normal)
        self.createBtn.setTitle(NSLocalizedString("create", comment: ""), for: .normal)
        self.txtTask.textAlignment = .defaultAlignment
        self.txtExpense.textAlignment = .defaultAlignment
        self.txtCurrency.textAlignment = .defaultAlignment
        self.txtProjectId.textAlignment = .defaultAlignment
        self.txtSubProject.textAlignment = .defaultAlignment
    }
    @IBAction func segmentAction(_ sender: UISegmentedControl) {
        self.selectSegmentIndex = sender.selectedSegmentIndex
        if selectSegmentIndex > 0 {
            self.TenableTitle.isHidden = true
            self.toggleSwitch.isHidden = true
        }else{
            self.TenableTitle.isHidden = false
            self.toggleSwitch.isHidden = false
        }
        setupViewHideShow()
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        //Pop to home view controller
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func toggleAction(_ sender: UISwitch) {
        if self.toggleSwitch.isOn{
            self.toggleSwitch.isOn = true
        }
        else{
            self.toggleSwitch.isOn = false
        }
        self.setupViewHideShow()
    }
    
    @IBAction func createAction(_ sender: Any) {
        if selectSegmentIndex == 0{
            if txtExpense.text == ""{
                
                Loaf(NSLocalizedString("expense_title_error", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
            }
            
            else if self.toggleSwitch.isOn {
                if txtProjectId.text == "" && self.selectedProject == nil {
                    
                    Loaf(NSLocalizedString("project_error", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
                }
                else  if txtSubProject.text == "" && self.selectSubproject != nil {
                    Loaf(NSLocalizedString("subproject_error", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
                }
                else if txtTask.text == "" && self.selectWorkTask != nil {
                    
                    Loaf(NSLocalizedString("task_error", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
                }
                else{
                    self.createAdvanceRequest()
                }
            }
        }
        else{
            if txtExpense.text == ""{
                
                Loaf(NSLocalizedString("expense_title_error", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
            }
            else{
                self.createAdvanceRequest()
            }
        }
    }
    
    func createAdvanceRequest(){
        //showLoader()
        var info = [String : Any?]()
        if (selectSegmentIndex == 0){
            info = ["title": txtExpense!.text!, "project" : self.selectedProject ?? nil, "subProject" : self.selectSubproject ?? nil, "task": self.selectWorkTask ?? nil, "type" : "Project"] as [String : Any?]
        }
        else{
            info = ["title": txtExpense!.text!, "project" : self.selectedProject ?? nil, "subProject" : self.selectSubproject ?? nil, "task": self.selectWorkTask ?? nil, "type" : selectSegmentIndex == 1 ? "Department" : "Business Area"] as [String : Any?]
        }
        self.dismiss(animated: true) {
            self.expenseDelegate?.expenseViewUIupdate(info)
        }
        
    }
    
    private func getCurrencyList(){
        

    }
//    private func getAllProjects(){
//
//        showLoader()
//        ProjectsAPI.apiProjectsProjectsForDropdownGet { (result, error) in
//            hideLoader()
//            if error == nil {
//                self.projectList = result ?? []
//                if self.viewDetailModel == nil {
//                    self.selectSubproject = nil
//                    self.selectWorkTask = nil
//                }
//                print("ProjectList \(self.projectList)")
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
//    }
    
    private func getAllProjects(){
        
        showLoader()
        
        ProjectsAPI.apiProjectsGetEmployeeAssignedProjectsIdGet(_id: Int(DefaultsManager.shared.userID!) ?? 0) { (result, error) in
            hideLoader()
            if error == nil {
                self.projectList = result ?? []
                if self.viewDetailModel == nil {
                    self.selectSubproject = nil
                    self.selectWorkTask = nil
                }
                print("ProjectList \(self.projectList)")
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
    private func getAllSubProjects(){
        showLoader()
        SubProjectsAPI.apiSubProjectsGetSubProjectsForProjectsIdGet(_id: self.selectedProject!._id!) { (result, error) in
            hideLoader()
            if error == nil {
                self.subProject = result ?? []
                if self.subProject.count > 0{
                    self.subProjectView.isHidden = false
                }
                else{
                    self.subProjectView.isHidden = true
                }
                print("SubProjectList \(self.subProject)")
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
    private func getAllTask(){
        showLoader()
        WorkTasksAPI.apiWorkTasksGetWorkTasksForSubProjectsIdGet(_id: self.selectSubproject!._id!) { (result, error) in
            hideLoader()
            if error == nil {
                self.workTask = result ?? []
                if self.workTask.count > 0{
                    self.taskView.isHidden = false
                }
                else{
                    self.taskView.isHidden = true
                }
                print(" Task ProjectList \(self.workTask)")
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
    
    func setupViewHideShow(){
        if selectSegmentIndex == 0 {
            
//            if !self.toggleSwitch.isOn{
//                self.projectBaseView.isHidden = true
//            }
//            else{
                self.projectBaseView.isHidden = false
//            }
        }
        else{
            self.projectBaseView.isHidden = true
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
extension CreateExpenseViewController : UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let searchPlace = NSLocalizedString("search", comment: "")
        if textField == txtProjectId{
            var projectTitle = [String]()
            for dropDown in self.projectList{
                projectTitle.append("\(dropDown.projectName ?? "")")
            }
            
            let simpleArray: [String] = projectTitle
            var simpleSelectedArray: [String] = selectedProject == nil ? [] : ["\(selectedProject!.projectName ?? "")"]
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
                if self.txtProjectId.text != item {
                    self.subProjectView.isHidden = true
                    self.taskView.isHidden = true
                    self.selectSubproject = nil
                    self.selectWorkTask = nil
                    self.txtSubProject.text = ""
                    self.txtTask.text = ""
                }
                textField.text = item!
                for drop in self.projectList{
                    if "\(drop.projectName ?? "")" == item!{
                        self.selectedProject = drop
                        self.getAllSubProjects()
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
            selectionMenu.showSearchBar(withPlaceHolder: searchPlace, barTintColor: UIColor.init(named: "NavBar")!.withAlphaComponent(0.2)) { (searchText) -> ([String]) in

                return simpleArray.filter({ $0.lowercased().contains(searchText.lowercased()) })
            }
            selectionMenu.show(style: .popover(sourceView: textField, size: CGSize(width: textField.frame.size.width, height: 230)), from: self)
            
            return false
            
        }
        if textField == txtSubProject{
            var projectTitle = [String]()
            for dropDown in self.subProject{
                projectTitle.append("\(dropDown.subProjectName ?? "")")
            }
            
            let simpleArray: [String] = projectTitle
            var simpleSelectedArray: [String] = selectSubproject == nil ? [] : ["\(selectSubproject!.subProjectName ?? "")"]
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
                if self.txtSubProject.text != item {
                    self.txtTask.text = ""
                    //self.getAllTask()
                }
                textField.text = item!
                for drop in self.subProject{
                    if "\(drop.subProjectName ?? "")" == item!{
                        self.selectSubproject = drop
                        self.getAllTask()
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
            selectionMenu.showSearchBar(withPlaceHolder: searchPlace, barTintColor: UIColor.init(named: "NavBar")!.withAlphaComponent(0.2)) { (searchText) -> ([String]) in

                return simpleArray.filter({ $0.lowercased().contains(searchText.lowercased()) })
            }
            selectionMenu.show(style: .popover(sourceView: textField, size: CGSize(width: textField.frame.size.width, height: 230)), from: self)
            
            return false
            
        }
        if textField == txtTask{
            var projectTitle = [String]()
            for dropDown in self.workTask{
                projectTitle.append("\(dropDown.taskName ?? "")")
            }
            
            let simpleArray: [String] = projectTitle
            var simpleSelectedArray: [String] = selectWorkTask == nil ? [] : ["\(selectWorkTask!.taskName ?? "")"]
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
                for drop in self.workTask{
                    if "\(drop.taskName ?? "")" == item!{
                        self.selectWorkTask = drop
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
            selectionMenu.showSearchBar(withPlaceHolder: searchPlace, barTintColor: UIColor.init(named: "NavBar")!.withAlphaComponent(0.2)) { (searchText) -> ([String]) in

                return simpleArray.filter({ $0.lowercased().contains(searchText.lowercased()) })
            }
            selectionMenu.show(style: .popover(sourceView: textField, size: CGSize(width: textField.frame.size.width, height: 230)), from: self)
            
            return false
        }
        return true
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtExpense{
        guard let text = textField.text else { return true }
        let allowedCharacters = CharacterSet(charactersIn:"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 .")//Here change this characters based on your requirement
        let characterSet = CharacterSet(charactersIn: string)
        
        let newLength = text.utf16.count + string.utf16.count - range.length
            
        return newLength <= 30 && allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
}

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
    @IBOutlet weak var businessTypeView: UIView!
    @IBOutlet weak var txtBusinessUnit: UITextField!
    @IBOutlet weak var txtBusinessType: UITextField!
    @IBOutlet weak var lblBusinessUnit: UILabel!
    @IBOutlet weak var lblBusinessType: UILabel!
    @IBOutlet weak var buinessUnitView: UIView!
    @IBOutlet weak var txtBusinessLocation: UITextField!
    @IBOutlet weak var lblBusinessLocation: UILabel!
    @IBOutlet weak var businessLocationView: UIView!
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
//    @IBOutlet weak var segmentToggle: UISegmentedControl!
    
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
    var businessTypeList = [BusinessTypeVM]()
    var businessUnitList = [BusinessUnitVM]()
    
    var selectedBusinessType : BusinessTypeVM?
    var selectedBusinessUnit : BusinessUnitVM?
    var selectedBusinessLocation : BusinessUnitLocationVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        self.txtTask.setupRightPadview()
        self.txtSubProject.setupRightPadview()
        self.txtProjectId.setupRightPadview()
        self.txtCurrency.setupRightPadview()
        self.txtBusinessType.setupRightPadview()
        self.txtBusinessUnit.setupRightPadview()
//        if selectSegmentIndex > 0 {
//            self.TenableTitle.isHidden = true
//            self.toggleSwitch.isHidden = true
//        }
//        else{
//            self.toggleSwitch.isOn = true
//            self.toggleSwitch.isUserInteractionEnabled = false
//        }
        
        self.txtCurrency.text = DefaultsManager.shared.currencyType
        if viewDetailModel == nil{
            self.toggleSwitch.isOn = false
            self.businessTypeView.isHidden = false
            self.buinessUnitView.isHidden = false
            self.businessLocationView.isHidden = false
            //self.toggleSwitch.isUserInteractionEnabled = true
            self.setupViewHideShow()
        }
        else{
            if (self.viewDetailModel!["type"] as! String) == "Project"{
                self.businessTypeView.isHidden = true
                self.buinessUnitView.isHidden = true
                self.businessLocationView.isHidden = true
                self.toggleSwitch.isOn = true
                self.setupViewHideShow()
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
            else{
//                "bussType": self.selectedBusinessType, "bussUnit": self.selectedBusinessUnit, "bussLoc": self.selectedBusinessLocation
//                self.toggleSwitch.isHidden = true
                self.TenableTitle.isHidden = true
                self.toggleSwitch.isOn = false
                self.projectBaseView.isHidden = true
                self.txtBusinessType.text = (viewDetailModel!["bussType"] as? BusinessTypeVM)?.businessTypeName ?? ""
                self.txtBusinessUnit.text = (viewDetailModel!["bussUnit"] as? BusinessUnitVM)?.businessUnitName ?? ""
                self.txtBusinessLocation.text = (viewDetailModel!["bussLoc"] as? BusinessUnitLocationVM)?.location ?? ""
                self.selectedBusinessType = (viewDetailModel!["bussType"] as? BusinessTypeVM)
                self.selectedBusinessUnit = (viewDetailModel!["bussUnit"] as? BusinessUnitVM)
                self.getBusinessLocation()
                self.businessTypeView.isHidden = false
                self.buinessUnitView.isHidden = false
                self.businessLocationView.isHidden = false
            }
//            else if (self.viewDetailModel!["type"] as! String) == "Business Area" {
//                segmentToggle.selectedSegmentIndex = 2
//                self.toggleSwitch.isHidden = true
//                self.TenableTitle.isHidden = true
//                self.toggleSwitch.isOn = false
//            }
//            else{
//                segmentToggle.selectedSegmentIndex = 1
//                self.toggleSwitch.isHidden = true
//                self.TenableTitle.isHidden = true
//                self.toggleSwitch.isOn = false
//            }
            
            self.txtExpense.text = (viewDetailModel!["title"] as! String)
        }
        setupViewHideShow()
        //self.getCurrencyList()
        self.getBusinessTypeDropDown()
        self.getAllProjects()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.islangauge(self.currentLanguage()){ return}
        self.setupUI()
    }
    
    private func setupUI(){
        self.lblBusinessType.text = NSLocalizedString("businesstype", comment: "")
        self.lblBusinessUnit.text = NSLocalizedString("businessunit", comment: "")
        self.lblBusinessLocation.text = NSLocalizedString("location1", comment: "")
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
        self.txtBusinessUnit.textAlignment = .defaultAlignment
        self.txtBusinessType.textAlignment = .defaultAlignment
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
        if self.toggleSwitch.isOn{
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
            if selectedBusinessType == nil {
                Loaf(NSLocalizedString("select_businesstype_error", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
            }
            else if selectedBusinessUnit == nil{
                Loaf(NSLocalizedString("select_businessunit_error", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
            }
            else if txtExpense.text == ""{
                
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
        if (self.toggleSwitch.isOn){
            info = ["title": txtExpense!.text!, "project" : self.selectedProject ?? nil, "subProject" : self.selectSubproject ?? nil, "task": self.selectWorkTask ?? nil,"bussType": nil, "bussUnit": nil, "bussLoc": nil, "type" : "Project"] as [String : Any?]
        }
        else{
            info = ["title": txtExpense!.text!, "project" : nil, "subProject" : nil, "task": nil, "type" : "Business Area", "bussType": self.selectedBusinessType, "bussUnit": self.selectedBusinessUnit, "bussLoc": self.selectedBusinessLocation] as [String : Any?]
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
    private func getBusinessTypeDropDown(){
        
        showLoader()
        
        ProjectsAPI.apiBusinessTypeGet(completion: { (result, error) in
            hideLoader()
            if error == nil {
                self.businessTypeList = result ?? []
                if self.viewDetailModel == nil {
                    self.selectedBusinessUnit = nil
                    self.selectedBusinessLocation = nil
                }
                print("Business DropDown \(self.businessTypeList)")
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
        })
    }
    private func getBusinessUnits(){
        
        showLoader()
        self.businessLocationView.isHidden = true
        ProjectsAPI.apiBusinessUnitPOST(body: BusinessUnitDTO(businessTypeId: self.selectedBusinessType?._id ?? 0,empId: DefaultsManager.shared.userID),completion: { (result, error) in
            hideLoader()
            if error == nil {
                self.businessUnitList = result ?? []
                if self.viewDetailModel == nil {
                    self.selectedBusinessUnit = nil
                    self.selectedBusinessLocation = nil
                }
                print("Business Units \(self.businessUnitList)")
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
        })
    }
    private func getBusinessLocation(){
        
        showLoader()
        
        ProjectsAPI.apiBusinessUnitLocationGet(_id: self.selectedBusinessUnit?._id ?? 0, completion: {  (result, error) in
            hideLoader()
            if error == nil {
                self.selectedBusinessLocation = result
                self.txtBusinessLocation.text = result?.location ?? ""
                let expenseTitles = (self.selectedBusinessUnit?.businessUnitName ?? "").components(separatedBy: ":")
                self.txtExpense.text = expenseTitles[0] + "-" + (result?.location ?? "") + "-" + "\(DefaultsManager.shared.expenseCount ?? 0)"
                print("business location \(self.selectedBusinessLocation)")
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
        })
    }
    
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
//        if selectSegmentIndex == 0 {
            
            if !self.toggleSwitch.isOn{
                self.txtExpense.text = ""
                self.businessTypeView.isHidden = false
                self.buinessUnitView.isHidden = true
                self.businessLocationView.isHidden = true
                self.projectBaseView.isHidden = true
            }
            else{
                self.txtExpense.text = ""
                self.businessTypeView.isHidden = true
                self.buinessUnitView.isHidden = true
                self.businessLocationView.isHidden = true
                self.projectBaseView.isHidden = false
                self.txtBusinessType.text = ""
                self.txtBusinessUnit.text = ""
                self.txtBusinessLocation.text = ""
                self.selectedBusinessType = nil
                self.selectedBusinessUnit = nil
                self.selectedBusinessLocation = nil
            }
//        }
//        else{
//            self.projectBaseView.isHidden = true
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
        if textField == txtBusinessType{
            var projectTitle = [String]()
            for dropDown in self.businessTypeList{
                projectTitle.append("\(dropDown.businessTypeName ?? "")")
            }
            
            let simpleArray: [String] = projectTitle
            var simpleSelectedArray: [String] = selectedBusinessType == nil ? [] : ["\(selectedBusinessType!.businessTypeName ?? "")"]
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
                for drop in self.businessTypeList{
                    if "\(drop.businessTypeName ?? "")" == item!{
                        self.selectedBusinessType = drop
                        self.txtExpense.text = ""
                        self.txtBusinessUnit.text = ""
                        self.txtBusinessLocation.text = ""
                        self.buinessUnitView.isHidden = false
                        self.getBusinessUnits()
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
        if textField == txtBusinessUnit{
            var projectTitle = [String]()
            for dropDown in self.businessUnitList{
                projectTitle.append("\(dropDown.businessUnitName ?? "")")
            }
            
            let simpleArray: [String] = projectTitle
            var simpleSelectedArray: [String] = selectedBusinessUnit == nil ? [] : ["\(selectedBusinessUnit!.businessUnitName ?? "")"]
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
                for drop in self.businessUnitList{
                    if "\(drop.businessUnitName ?? "")" == item!{
                        self.selectedBusinessUnit = drop
                        self.businessLocationView.isHidden = false
                        self.getBusinessLocation()
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
        let allowedCharacters = CharacterSet(charactersIn:"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 .-")//Here change this characters based on your requirement
        let characterSet = CharacterSet(charactersIn: string)
        
        let newLength = text.utf16.count + string.utf16.count - range.length
            
        return newLength <= 30 && allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
}

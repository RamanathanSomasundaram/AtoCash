//
//  CreatetravelRequestViewController.swift
//  AtoCash
//
//  Created by Vinothini on 17/04/21.
//

import UIKit

class CreatetravelRequestViewController: UIViewController {

    //UI Localization
    @IBOutlet weak var tStart: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var tWorktask: UILabel!
    @IBOutlet weak var tSubproject: UILabel!
    @IBOutlet weak var tProject: UILabel!
    @IBOutlet weak var tEnable: UILabel!
    @IBOutlet weak var tEnd: UILabel!
    @IBOutlet weak var tTravelPurpose: UILabel!
    @IBOutlet weak var createBtn: UIButton!
    @IBOutlet weak var txtTask: UITextField!
    @IBOutlet weak var txtSubProject: UITextField!
    @IBOutlet weak var txtProjectId: UITextField!
    @IBOutlet weak var txtEndDate: UITextField!

    @IBOutlet weak var txtStartDate: UITextField!
    @IBOutlet weak var txtTravelPurpose: UITextView!
    
    @IBOutlet weak var projectBaseView: UIStackView!
    @IBOutlet weak var taskView: UIView!
    @IBOutlet weak var subProjectView: UIView!
    

    @IBOutlet weak var toggleSwitch: UISwitch!

    
    var projectList = [ProjectVM]()
    var selectedProject : ProjectVM?
    
    var subProject = [SubProjectVM]()
    var selectSubproject : SubProjectVM?
    
    var workTask = [TaskModel]()
    var selectWorkTask : TaskModel?
    
    var viewDetailModel : TravelApprovalRequestDTO?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //Navigation Backbar button item
        let backBtn = UIBarButtonItem(image: UIImage.init(named: "back"), style: .plain, target: self, action: #selector(BackButtonTapped))
        backBtn.tintColor = .white
    
        self.navigationItem.leftBarButtonItem = backBtn
        
        self.txtTask.setupRightPadview()
        self.txtSubProject.setupRightPadview()
        self.txtProjectId.setupRightPadview()
        
        self.txtStartDate.setupDateRightPadview()
        self.txtEndDate.setupDateRightPadview()
        self.txtStartDate.setInputViewPickerWithMin(target: self, selector: #selector(startDate))
        self.txtEndDate.setInputViewPickerWithMin(target: self, selector: #selector(endDate))
        if viewDetailModel == nil{
            self.toggleSwitch.isOn = false
            self.setupViewHideShow()
            self.title = NSLocalizedString("create_travel_title", comment: "")
            self.createBtn.setTitle(NSLocalizedString("create", comment: ""), for: .normal)
        }
        else{
            self.title = NSLocalizedString("edit_travel_title", comment: "")
            self.createBtn.setTitle(NSLocalizedString("update_btn", comment: ""), for: .normal)
            self.toggleSwitch.isOn = (viewDetailModel?.projectId != 0) && (viewDetailModel?.projectId != nil) ? true : false
            self.setupViewHideShow()
            self.txtStartDate.text = UtilsManager.shared.systemDateStringFromUTC(utcDate: UtilsManager.shared.systemDatetoString(viewDetailModel!.travelStartDate!),formatOf: "dd MMM yyyy")
            self.txtEndDate.text = UtilsManager.shared.systemDateStringFromUTC(utcDate: UtilsManager.shared.systemDatetoString(viewDetailModel!.travelEndDate!),formatOf: "dd MMM yyyy")
            self.txtTravelPurpose.text = viewDetailModel!.travelPurpose
            self.txtProjectId.text = viewDetailModel?.project ?? ""
            self.txtSubProject.text = viewDetailModel?.subProject ?? ""
            self.txtTask.text = viewDetailModel?.workTask ?? ""
        }
        self.getAllProjects()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.islangauge(self.currentLanguage()){ return}
        self.viewUpdates()
        self.setupUI()
    }
    
    private func setupUI(){
        tStart.text = NSLocalizedString("start_date", comment: "")
        cancelBtn.setTitle(NSLocalizedString("cancel", comment: ""), for: .normal)
        tWorktask.text = NSLocalizedString("work_task", comment: "")
        tSubproject.text = NSLocalizedString("subproject", comment: "")
        tProject.text = NSLocalizedString("project", comment: "")
        tEnable.text = NSLocalizedString("enable_project", comment: "")
        tEnd.text = NSLocalizedString("end_date", comment: "")
        
        tTravelPurpose.text = NSLocalizedString("travel_purpose", comment: "")
        txtTask.textAlignment = .defaultAlignment
        txtSubProject.textAlignment = .defaultAlignment
        txtProjectId.textAlignment = .defaultAlignment
        txtEndDate.textAlignment = .defaultAlignment
        txtStartDate.textAlignment = .defaultAlignment
        txtTravelPurpose.textAlignment = .defaultAlignment
    }
    
    
    //DatePicker Action
    @objc func startDate(){
        if let datePicker = self.txtStartDate.inputView as? UIDatePicker { // 2-1
            let dateformatter = DateFormatter() // 2-2
            dateformatter.dateStyle = .long
            dateformatter.dateFormat = "dd-MMM-yyyy"
            if self.txtEndDate.text != "" {
                let end = UtilsManager.shared.UTCDateFromString2(date: self.txtEndDate.text!)
                let start = UtilsManager.shared.UTCDateFromString2(date: dateformatter.string(from: datePicker.date) )
                if start <= end
                {
                        self.txtStartDate.text = dateformatter.string(from: datePicker.date) //2-4
                }
                else{
                    
                    Loaf(NSLocalizedString("startdate_greater", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
                }
            }
            else{
                self.txtStartDate.text = dateformatter.string(from: datePicker.date) //2-4
            }
        }
        self.txtStartDate.resignFirstResponder() // 2-5
    }
    
    @objc func endDate(){
        if let datePicker = self.txtEndDate.inputView as? UIDatePicker { // 2-1
            let dateformatter = DateFormatter() // 2-2
            dateformatter.dateStyle = .long
            dateformatter.dateFormat = "dd-MMM-yyyy"
            if self.txtStartDate.text != "" {
                let start = UtilsManager.shared.UTCDateFromString2(date: self.txtStartDate.text!)
                let end = UtilsManager.shared.UTCDateFromString2(date: dateformatter.string(from: datePicker.date) )
                if start <= end
                {
                        self.txtEndDate.text = dateformatter.string(from: datePicker.date) //2-4
                }
                else{
                    Loaf(NSLocalizedString("enddate_greater", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
                }
            }
            else{
                Loaf(NSLocalizedString("start_error", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
            }
        }
        self.txtEndDate.resignFirstResponder() // 2-5
    }
    
        
    //BAckbutton Action
    @objc func BackButtonTapped(){
        //Pop to home view controller
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func cancelAction(_ sender: Any) {
        //Pop to home view controller
        self.navigationController?.popViewController(animated: true)
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
        
        if self.toggleSwitch.isOn {
            if txtStartDate.text == ""{
                
                Loaf(NSLocalizedString("start_error", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
            }
            else if txtEndDate.text == "" {
                Loaf(NSLocalizedString("end_error", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
            }
            else if txtTravelPurpose.text == "" {
                Loaf(NSLocalizedString("travel_purpose_error", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
            }
            else if txtProjectId.text == "" && self.selectedProject == nil {
                
                Loaf(NSLocalizedString("project_error", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
            }
            else  if txtSubProject.text == "" && self.selectSubproject != nil {
                Loaf(NSLocalizedString("subproject_error", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
            }
            else if txtTask.text == "" && self.selectWorkTask != nil {
                
                Loaf(NSLocalizedString("task_error", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
            }
            else{
                //self.createTravelRequest()
                self.viewDetailModel == nil ? self.createTravelRequest() : self.updateTravelRequest()
            }
        }
        else{
            if txtStartDate.text == ""{
                
                Loaf(NSLocalizedString("start_error", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
            }
            else if txtEndDate.text == "" {
                Loaf(NSLocalizedString("end_error", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
            }
            else if txtTravelPurpose.text == "" {
                Loaf(NSLocalizedString("travel_purpose_error", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
            }
            else{
                self.viewDetailModel == nil ? self.createTravelRequest() : self.updateTravelRequest()
            }
        }
    }
    
    func createTravelRequest(){
        showLoader()
        var params : TravelApprovalRequestDTO!
        let start = UtilsManager.shared.UTCDateFromString2(date: UtilsManager.shared.UTCDateFromString(date: self.txtStartDate.text!, format: "dd-MMM-yyyy"),format : "yyyy-MM-dd'T'HH:mm:ss.SSS")
        
        let end = UtilsManager.shared.UTCDateFromString2(date: UtilsManager.shared.UTCDateFromString(date: self.txtEndDate.text!, format: "dd-MMM-yyyy"),format : "yyyy-MM-dd'T'HH:mm:ss.SSS")
        if !self.toggleSwitch.isOn{
            params = TravelApprovalRequestDTO(_id: 0, employeeId: Int(DefaultsManager.shared.userID!), employeeName: DefaultsManager.shared.fName! + " " + DefaultsManager.shared.lName!, travelStartDate:start, travelEndDate: end, travelPurpose: self.txtTravelPurpose.text!, reqRaisedDate: nil, department: nil, departmentId: nil, projectId: nil, project: nil, subProjectId: nil, subProject: nil, workTaskId: nil, workTask: nil, approvalStatusTypeId: nil, approvalStatusType: nil, approvedDate: nil, showEditDelete: true)
        }
        else{
            let project = selectedProject == nil ? nil : self.selectedProject
            let subproject = selectSubproject == nil ? nil : self.selectSubproject
            let task = selectWorkTask == nil ? nil : self.selectWorkTask
            
            params = TravelApprovalRequestDTO(_id: 0, employeeId: Int(DefaultsManager.shared.userID!), employeeName: DefaultsManager.shared.fName! + " " + DefaultsManager.shared.lName!, travelStartDate: start, travelEndDate: end, travelPurpose: self.txtTravelPurpose.text!, reqRaisedDate: nil,  department: nil, departmentId: nil, projectId:  project == nil ? nil : project?._id, project: project == nil ? nil : project?.projectName, subProjectId: subproject == nil ? nil : subproject?._id, subProject:  subproject == nil ? nil : subproject?.subProjectName, workTaskId: task == nil ? nil : task?.id, workTask: task == nil ? nil : task?.taskName, approvalStatusTypeId: nil, approvalStatusType: nil, approvedDate: nil, showEditDelete: true)
            
        }
        
        TravelApprovalRequestsAPI.apiTravelApprovalRequestsPostTravelApprovalRequestPost(body: params) { (result, error) in
            hideLoader()
            if error == nil {
                print("success")
                Loaf(NSLocalizedString("travel_request_success", comment: ""), state: .success, location: .top, sender: self).show(.short, completionHandler: nil)
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
                            Loaf(NSLocalizedString("somthing_wrong", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
                            print("json error \(error.localizedDescription)")
                        }
                    }

                }
            }
        }
    }
    
    func updateTravelRequest(){
        showLoader()
        var params : TravelApprovalRequestDTO!
        let start = UtilsManager.shared.UTCDateFromString2(date: UtilsManager.shared.UTCDateFromString(date: self.txtStartDate.text!, format: "dd-MMM-yyyy"),format : "yyyy-MM-dd'T'HH:mm:ss.SSS")
        let end = UtilsManager.shared.UTCDateFromString2(date: UtilsManager.shared.UTCDateFromString(date: self.txtEndDate.text!, format: "dd-MMM-yyyy"),format : "yyyy-MM-dd'T'HH:mm:ss.SSS")
        if !self.toggleSwitch.isOn{
            params = TravelApprovalRequestDTO(_id: self.viewDetailModel!._id!, employeeId: Int(DefaultsManager.shared.userID!), employeeName: DefaultsManager.shared.fName! + " " + DefaultsManager.shared.lName!, travelStartDate: start, travelEndDate: end, travelPurpose: self.txtTravelPurpose.text!, reqRaisedDate: nil, department: nil, departmentId: nil, projectId: nil, project: nil, subProjectId: nil, subProject: nil, workTaskId: nil, workTask: nil, approvalStatusTypeId: nil, approvalStatusType: nil, approvedDate: nil, showEditDelete: true)
        }
        else{
            let project = selectedProject == nil ? nil : self.selectedProject
            let subproject = selectSubproject == nil ? nil : self.selectSubproject
            let task = selectWorkTask == nil ? nil : self.selectWorkTask
            
            params = TravelApprovalRequestDTO(_id: self.viewDetailModel!._id!, employeeId: Int(DefaultsManager.shared.userID!), employeeName: DefaultsManager.shared.fName! + " " + DefaultsManager.shared.lName!, travelStartDate: start, travelEndDate: end, travelPurpose: self.txtTravelPurpose.text!, reqRaisedDate: nil,  department: nil, departmentId: nil, projectId:  project == nil ? nil : project?._id, project: project == nil ? nil : project?.projectName, subProjectId: subproject == nil ? nil : subproject?._id, subProject:  subproject == nil ? nil : subproject?.subProjectName, workTaskId: task == nil ? nil : task?.id, workTask: task == nil ? nil : task?.taskName, approvalStatusTypeId: nil, approvalStatusType: nil, approvedDate: nil, showEditDelete: true)
            
        }
        TravelApprovalRequestsAPI.apiTravelApprovalRequestsPutTravelApprovalRequestIdPut(_id: self.viewDetailModel!._id!, body: params) { (result, error) in
            hideLoader()
            if error == nil {
                print("success")
                Loaf(NSLocalizedString("travel_request_update", comment: ""), state: .success, location: .top, sender: self).show(.short, completionHandler: nil)
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
                            Loaf(NSLocalizedString("somthing_wrong", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
                            print("json error \(error.localizedDescription)")
                        }
                    }

                }
            }
        }
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
                            Loaf(NSLocalizedString("somthing_wrong", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
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
                            Loaf((json["message"] as! String), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
                        }
                        catch{
                            Loaf(NSLocalizedString("somthing_wrong", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
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
                            Loaf((json["message"] as! String), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
                        }
                        catch{
                            Loaf(NSLocalizedString("somthing_wrong", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
                            print("json error \(error.localizedDescription)")
                        }
                    }

                }
            }
        }
    }
    
    func setupViewHideShow(){
        if !self.toggleSwitch.isOn{
            self.projectBaseView.isHidden = true
        }
        else{
            self.projectBaseView.isHidden = false
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
extension CreatetravelRequestViewController : UITextFieldDelegate, UITextViewDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    
        if textField == txtProjectId{
            var projectTitle = [String]()
            for dropDown in self.projectList{
                projectTitle.append("\(dropDown.projectName ?? "")")
            }
            
            let simpleArray: [String] = projectTitle
            var simpleSelectedArray: [String] = selectedProject == nil ? [] : ["\(selectedProject!.projectName ?? ""))"]
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
            selectionMenu.showSearchBar(withPlaceHolder: NSLocalizedString("search", comment: ""), barTintColor: UIColor.init(named: "NavBar")!.withAlphaComponent(0.2)) { (searchText) -> ([String]) in

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
            var simpleSelectedArray: [String] = selectSubproject == nil ? [] : ["\(selectSubproject!.subProjectName ?? ""))"]
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
            selectionMenu.showSearchBar(withPlaceHolder: NSLocalizedString("search", comment: ""), barTintColor: UIColor.init(named: "NavBar")!.withAlphaComponent(0.2)) { (searchText) -> ([String]) in

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
            var simpleSelectedArray: [String] = selectWorkTask == nil ? [] : ["\(selectWorkTask!.taskName ?? ""))"]
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
            selectionMenu.showSearchBar(withPlaceHolder: NSLocalizedString("search", comment: ""), barTintColor: UIColor.init(named: "NavBar")!.withAlphaComponent(0.2)) { (searchText) -> ([String]) in

                return simpleArray.filter({ $0.lowercased().contains(searchText.lowercased()) })
            }
            selectionMenu.show(style: .popover(sourceView: textField, size: CGSize(width: textField.frame.size.width, height: 230)), from: self)
            
            return false
        }
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let text1 = textView.text else { return true }
        let allowedCharacters = CharacterSet(charactersIn:"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 .")//Here change this characters based on your requirement
        let characterSet = CharacterSet(charactersIn: text)
        
        let newLength = text1.utf16.count + text.utf16.count - range.length
        return newLength <= 100 && allowedCharacters.isSuperset(of: characterSet)
    }
    
}


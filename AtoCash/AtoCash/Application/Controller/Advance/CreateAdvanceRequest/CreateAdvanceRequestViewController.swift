//
//  CreateAdvanceRequestViewController.swift
//  AtoCash
//
//  Created by user on 19/03/21.
//

import UIKit

class CreateAdvanceRequestViewController: UIViewController {
    @IBOutlet weak var txtBusinessLocation: UITextField!
    @IBOutlet weak var lblBusinessLocation: UILabel!
    @IBOutlet weak var businessLocationView: UIView!
    @IBOutlet weak var businessTypeView: UIView!
    @IBOutlet weak var txtBusinessUnit: UITextField!
    @IBOutlet weak var txtBusinessType: UITextField!
    @IBOutlet weak var lblBusinessUnit: UILabel!
    @IBOutlet weak var lblBusinessType: UILabel!
    @IBOutlet weak var buinessUnitView: UIView!
    //UI Localization
    @IBOutlet weak var tPettyAmount: UILabel!
    @IBOutlet weak var tWorktask: UILabel!
    @IBOutlet weak var tSubproject: UILabel!
    @IBOutlet weak var tProject: UILabel!
    @IBOutlet weak var tEnable: UILabel!
    @IBOutlet weak var tCurrency: UILabel!
    @IBOutlet weak var tPettyDesc: UILabel!
    @IBOutlet weak var createBtn: UIButton!
    
    @IBOutlet weak var cencelBtn: UIButton!
    @IBOutlet weak var txtTask: UITextField!
    @IBOutlet weak var txtSubProject: UITextField!
    @IBOutlet weak var txtProjectId: UITextField!
    @IBOutlet weak var txtCurrency: UITextField!

    @IBOutlet weak var txtPettyCash: UITextField!
    @IBOutlet weak var txtPettyDesc: UITextView!
    
    @IBOutlet weak var projectBaseView: UIStackView!
    @IBOutlet weak var taskView: UIView!
    @IBOutlet weak var subProjectView: UIView!
    
    var viewDetailModel : PettyCashRequestDTO?

    @IBOutlet weak var toggleSwitch: UISwitch!
    
    
    var currenyList = [CurrencyTypeVM]()
    var selectedCurrency : CurrencyTypeVM?
    
    var projectList = [ProjectVM]()
    var selectedProject : ProjectVM?
    
    var subProject = [SubProjectVM]()
    var selectSubproject : SubProjectVM?
    
    var workTask = [TaskModel]()
    var selectWorkTask : TaskModel?
    
    var businessTypeList = [BusinessTypeVM]()
    var selectedBusinessType : BusinessTypeVM?
    var businessUnitList = [BusinessUnitVM]()
    var selectedBusinessUnit : BusinessUnitVM?
    var selectedBusinessLocation : BusinessUnitLocationVM?
    
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
        self.txtCurrency.setupRightPadview()
        self.txtBusinessType.setupRightPadview()
        self.txtBusinessUnit.setupRightPadview()
        if viewDetailModel == nil{
            self.toggleSwitch.isOn = false
            self.setupViewHideShow()
            self.title = NSLocalizedString("petty_title", comment: "")
            self.createBtn.setTitle(NSLocalizedString("create", comment: ""), for: .normal)
        }
        else{
            self.title = NSLocalizedString("edit_petty_cash_title", comment: "")
            self.createBtn.setTitle(NSLocalizedString("update_btn", comment: ""), for: .normal)
            self.setupViewHideShow()
            self.txtPettyCash.text = "\(viewDetailModel!.cashAdvanceAmount!)"
            self.txtPettyDesc.text = viewDetailModel?.cashAdvanceRequestDesc
            
            if let project = viewDetailModel?.project, project != ""{
                self.tEnable.isHidden = false
                self.toggleSwitch.isHidden = false
                self.txtProjectId.text = project
                self.toggleSwitch.isOn = true
                self.selectedProject = ProjectVM(_id: viewDetailModel?.projectId, projectName: project)
                self.getAllSubProjects()
            }
            else{
                self.toggleSwitch.isOn = false
                self.tEnable.isHidden = true
                self.toggleSwitch.isHidden = true
                self.projectBaseView.isHidden = true
                self.txtBusinessType.text = viewDetailModel?.businessType
                self.txtBusinessUnit.text = viewDetailModel?.businessUnit
                self.txtBusinessLocation.text = viewDetailModel?.location
                self.selectedBusinessType = BusinessTypeVM(_id: viewDetailModel?.businessTypeId,businessTypeName: viewDetailModel?.businessType)
                self.selectedBusinessUnit = BusinessUnitVM(_id:viewDetailModel?.businessUnitId,businessUnitName: viewDetailModel?.businessUnit)
                self.getBusinessLocation()
                self.businessTypeView.isHidden = false
                self.buinessUnitView.isHidden = false
                self.businessLocationView.isHidden = false
            }
            
            if let subProject = viewDetailModel?.subProject, subProject != ""{
                self.txtSubProject.text = subProject
                self.selectSubproject = SubProjectVM(_id: viewDetailModel?.subProjectId, subProjectName: subProject)
                self.getAllTask()
                
            }
            if let taskProject = viewDetailModel?.workTask, taskProject != ""{
                self.txtTask.text = taskProject
                self.selectWorkTask = TaskModel(_id: viewDetailModel?.workTaskId, taskName: taskProject, taskDesc: nil)
            }
            
        }
        self.txtCurrency.text = DefaultsManager.shared.currencyType
        self.getBusinessTypeDropDown()
        self.getAllProjects()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.islangauge(self.currentLanguage()) { return}
        self.viewUpdates()
        self.setupUI()
    }
    
    private func setupUI(){
        self.lblBusinessType.text = NSLocalizedString("businesstype", comment: "")
        self.lblBusinessUnit.text = NSLocalizedString("businessunit", comment: "")
        self.lblBusinessLocation.text = NSLocalizedString("location1", comment: "")
        tPettyAmount.text = NSLocalizedString("petty_amount", comment: "")
        tWorktask.text = NSLocalizedString("work_task", comment: "")
        tSubproject.text = NSLocalizedString("subproject", comment: "")
        tProject.text = NSLocalizedString("project", comment: "")
        tEnable.text = NSLocalizedString("enable_project", comment: "")
        tCurrency.text = NSLocalizedString("currency", comment: "")
        tPettyDesc.text = NSLocalizedString("petty_desc", comment: "")
        cencelBtn.setTitle(NSLocalizedString("cancel", comment: ""), for: .normal)
        txtTask.textAlignment = .defaultAlignment
        txtSubProject.textAlignment = .defaultAlignment
        txtProjectId.textAlignment = .defaultAlignment
        txtCurrency.textAlignment = .defaultAlignment
        txtPettyCash.textAlignment = .defaultAlignment
        txtPettyDesc.textAlignment = .defaultAlignment
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
            if txtPettyCash.text == ""{
                
                Loaf(NSLocalizedString("pettycash_amount_error", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
            }
            else if txtPettyDesc.text == "" {
                Loaf(NSLocalizedString("pettycash_desc_error", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
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
                if viewDetailModel == nil {
                    self.createAdvanceRequest()
                }
                else{
                    self.updateAdvanceRequest()
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
            else if txtPettyCash.text == ""{
                
                Loaf(NSLocalizedString("pettycash_amount_error", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
            }
            else if txtPettyDesc.text == "" {
                Loaf(NSLocalizedString("pettycash_desc_error", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
            }
            else{
                
                if viewDetailModel == nil{
                    
                    self.createAdvanceRequest()
                }
                else{
                    self.updateAdvanceRequest()
                }
            }
        }
    }
    
    func createAdvanceRequest(){
        showLoader()
        var params : PettyCashRequestDTO!
        if !self.toggleSwitch.isOn{
            params = PettyCashRequestDTO(_id: 0, employeeName: DefaultsManager.shared.fName! + " " + DefaultsManager.shared.lName!, employeeId: Int(DefaultsManager.shared.userID!) ?? 0,businessTypeId: self.selectedBusinessType?._id ?? 0,businessUnitId: self.selectedBusinessUnit?._id ?? 0, currencyType: DefaultsManager.shared.currencyType, currencyTypeId:  Int(DefaultsManager.shared.currencyId!) ?? 0, pettyClaimAmount: Double(self.txtPettyCash!.text!) ?? 0, pettyClaimRequestDesc: self.txtPettyDesc.text!, cashReqDate: Date(), department: nil, departmentId: nil, project: nil, projectId: nil, subProject: nil, subProjectId: nil, workTask: nil, workTaskId: nil, approvalStatusType: nil, approvalStatusTypeId: nil, approvedDate: nil, showEditDelete: true)
        }
        else{
            let project = selectedProject == nil ? nil : self.selectedProject
            let subproject = selectSubproject == nil ? nil : self.selectSubproject
            let task = selectWorkTask == nil ? nil : self.selectWorkTask
            params = PettyCashRequestDTO(_id: 0, employeeName: DefaultsManager.shared.fName! + " " + DefaultsManager.shared.lName!, employeeId: Int(DefaultsManager.shared.userID!) ?? 0, businessTypeId: nil,businessUnitId: nil,currencyType: DefaultsManager.shared.currencyType, currencyTypeId:  Int(DefaultsManager.shared.currencyId!) ?? 0, pettyClaimAmount: Double(self.txtPettyCash!.text!) ?? 0, pettyClaimRequestDesc: self.txtPettyDesc.text!, cashReqDate: Date(), department: nil, departmentId: nil, project: project == nil ? nil : project?.projectName, projectId:  project == nil ? nil : project?._id, subProject:  subproject == nil ? nil : subproject?.subProjectName, subProjectId: subproject == nil ? nil : subproject?._id, workTask: task == nil ? nil : task?.taskName, workTaskId: task == nil ? nil : task?.id, approvalStatusType: nil, approvalStatusTypeId: nil, approvedDate: nil, showEditDelete: true)
            
        }
        PettyCashRequestsAPI.apiPettyCashRequestsPostPettyCashRequestPost(body: params) { (result, error) in
            hideLoader()
            if error == nil {
                print("success")
                Loaf(NSLocalizedString("pettycash_success", comment: ""), state: .success, location: .top, sender: self).show(.short, completionHandler: nil)
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
    
    func updateAdvanceRequest(){
        showLoader()
        var params : PettyCashRequestDTO!
        if !self.toggleSwitch.isOn{
            params = PettyCashRequestDTO(_id: viewDetailModel?._id, employeeName: DefaultsManager.shared.fName! + " " + DefaultsManager.shared.lName!, employeeId: Int(DefaultsManager.shared.userID!) ?? 0,businessTypeId: self.selectedBusinessType?._id ?? 0,businessUnitId: self.selectedBusinessUnit?._id ?? 0, currencyType: DefaultsManager.shared.currencyType, currencyTypeId:  Int(DefaultsManager.shared.currencyId!) ?? 0, pettyClaimAmount: Double(self.txtPettyCash!.text!) ?? 0, pettyClaimRequestDesc: self.txtPettyDesc.text!, cashReqDate: nil, department: nil, departmentId: nil, project: nil, projectId: nil, subProject: nil, subProjectId: nil, workTask: nil, workTaskId: nil, approvalStatusType: nil, approvalStatusTypeId: nil, approvedDate: nil, showEditDelete: true)
        }
        else{
            let project = selectedProject == nil ? nil : self.selectedProject
            let subproject = selectSubproject == nil ? nil : self.selectSubproject
            let task = selectWorkTask == nil ? nil : self.selectWorkTask
            params = PettyCashRequestDTO(_id: viewDetailModel?._id, employeeName: DefaultsManager.shared.fName! + " " + DefaultsManager.shared.lName!, employeeId: Int(DefaultsManager.shared.userID!) ?? 0,businessTypeId: nil,businessUnitId: nil, currencyType: DefaultsManager.shared.currencyType, currencyTypeId:  Int(DefaultsManager.shared.currencyId!) ?? 0, pettyClaimAmount: Double(self.txtPettyCash!.text!) ?? 0, pettyClaimRequestDesc: self.txtPettyDesc.text!, cashReqDate: viewDetailModel?.cashReqDate, department: viewDetailModel?.department, departmentId: viewDetailModel?.departmentId, project: project == nil ? nil : project?.projectName, projectId:  project == nil ? nil : project?._id, subProject:  subproject == nil ? nil : subproject?.subProjectName, subProjectId: subproject == nil ? nil : subproject?._id, workTask: task == nil ? nil : task?.taskName, workTaskId: task == nil ? nil : task?.id, approvalStatusType: viewDetailModel?.approvalStatusType, approvalStatusTypeId: viewDetailModel?.approvalStatusTypeId, approvedDate: viewDetailModel?.approvedDate, showEditDelete: true)
        }
        
        PettyCashRequestsAPI.apiPettyCashRequestsPutPettyCashRequestIdPut(_id: (viewDetailModel?._id)!, body: params) { (result, error) in
            hideLoader()
            if error == nil {
                print("success")
                Loaf(NSLocalizedString("peetycash_update", comment: ""), state: .success, location: .top, sender: self).show(.short, completionHandler: nil)
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
    
    private func getCurrencyList(){
        showLoader()
        CurrencyTypesAPI.apiCurrencyTypesCurrencyTypesForDropdownGet { (result, error) in
            hideLoader()
            if error == nil {
                self.currenyList = result ?? []
                print("CurrencyList \(self.currenyList)")
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
                            print("json error \(error.localizedDescription)")
                        }
                    }

                }
            }
        }
    }
    
    func setupViewHideShow(){
        if !self.toggleSwitch.isOn{
            self.businessTypeView.isHidden = false
            self.buinessUnitView.isHidden = true
            self.businessLocationView.isHidden = true
            self.projectBaseView.isHidden = true
        }
        else{
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
extension CreateAdvanceRequestViewController : UITextFieldDelegate, UITextViewDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let searchPlace = NSLocalizedString("search", comment: "")
        if textField == txtCurrency {
            var projectTitle = [String]()
            for dropDown in self.currenyList{
                projectTitle.append(dropDown.currencyCode!)
            }
            
            let simpleArray: [String] = projectTitle
            var simpleSelectedArray: [String] = selectedCurrency == nil ? [] : [selectedCurrency!.currencyCode!]
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
                for drop in self.currenyList{
                    if drop.currencyCode == item!{
                        self.selectedCurrency = drop
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
            selectionMenu.showSearchBar(withPlaceHolder: NSLocalizedString("search", comment: ""), barTintColor: UIColor.init(named: "NavBar")!.withAlphaComponent(0.2)) { (searchText) -> ([String]) in

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
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let text1 = textView.text else { return true }
        let allowedCharacters = CharacterSet(charactersIn:"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 .")//Here change this characters based on your requirement
        let characterSet = CharacterSet(charactersIn: text)
        
        let newLength = text1.utf16.count + text.utf16.count - range.length
        return newLength <= 100 && allowedCharacters.isSuperset(of: characterSet)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtPettyCash{
        guard let text = textField.text else { return true }
        let allowedCharacters = CharacterSet(charactersIn:"0123456789")//Here change this characters based on your requirement
        let characterSet = CharacterSet(charactersIn: string)
        
        let newLength = text.utf16.count + string.utf16.count - range.length
            
        return newLength <= 20 && allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
}

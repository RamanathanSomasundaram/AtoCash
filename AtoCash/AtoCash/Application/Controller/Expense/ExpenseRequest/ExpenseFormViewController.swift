//
//  ExpenseFormViewController.swift
//  AtoCash
//
//  Created by user on 20/04/21.
//

import UIKit

class ExpenseFormViewController: UIViewController, createExpenseViewDelegate,addItemDelegate,ExpenseSubmitDelegate {
    
    //UI Localization
    
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var draftBtn: UIButton!
    @IBOutlet weak var addItemBtn: UIButton!
    @IBOutlet weak var updateExpenseBtn: UIButton!
    @IBOutlet weak var Tamount: UILabel!
    @IBOutlet weak var tExpenseTitle: UILabel!
    @IBOutlet weak var tExpenseType: UILabel!
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var txtTotalAmount: UILabel!
    @IBOutlet weak var txtExpenseType: UILabel!
    @IBOutlet weak var txtExpenseTitle: UILabel!
    var UIInfo : [String:Any?]!
    var itemsList = [addItemInfo]()
    var expenseBusinessList = [ExpenseBusinessDTO]()
    
    var editExpense : ExpenseReimburseRequestDTO?
    var isRealmSave = false
    
    var selectedProject : ProjectVM?
    var selectSubproject : SubProjectVM?
    var selectWorkTask : TaskModel?
    
    var isOffline : Bool = false
    var editOfflineData : offlineData?
    var editOfflineDataIndex : Int?
    var isBusiness = false
    var isProject = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //Navigation Backbar button item
        let backBtn = UIBarButtonItem(image: UIImage.init(named: "back"), style: .plain, target: self, action: #selector(BackButtonTapped))
        backBtn.tintColor = .white
        self.navigationItem.leftBarButtonItem = backBtn
        tblView.tableFooterView = UIView()
        tblView.register(UINib(nibName: "ExpenseClaimCell", bundle: nil), forCellReuseIdentifier: "expenseClaimCell")
        self.getBusinessList()
        self.isProject = false
        if !isOffline{
        if editExpense == nil {
            self.title = NSLocalizedString("create_expenses", comment: "")
            self.txtExpenseTitle.text = (UIInfo["title"] as! String)
            if let project = UIInfo["project"] as? ProjectVM{
                self.isProject = true
                self.txtExpenseType.text = NSLocalizedString("proj", comment: "")
                print(project)
                self.isBusiness = false
            }
            else if ((UIInfo["type"] as! String) == "Business Area"){
                self.txtExpenseType.text = NSLocalizedString("business", comment: "")
                self.isBusiness = true
            }
            else{
                self.txtExpenseType.text = NSLocalizedString("dept", comment: "")
                self.isBusiness = false
            }
            self.txtTotalAmount.text = "0.0"
            self.addItemAction(nil)
        }
        else{
            self.title = NSLocalizedString("edit_expense", comment: "")
            self.txtExpenseTitle.text = editExpense?.expenseReportTitle
            if let project = editExpense?.project, project != ""{
                self.isProject = true
                self.txtExpenseType.text = NSLocalizedString("proj", comment: "")
                self.selectedProject = ProjectVM(_id: editExpense?.projectId, projectName: project)
                if let subProject = editExpense?.subProject, subProject != ""{
                    self.selectSubproject = SubProjectVM(_id: editExpense?.subProjectId, subProjectName: subProject)
                    
                }
                if let taskProject = editExpense?.workTask, taskProject != ""{
                    self.selectWorkTask = TaskModel(_id: editExpense?.workTaskId, taskName: taskProject, taskDesc: nil)
                }
                let info = ["title": txtExpenseTitle!.text!, "project" : self.selectedProject ?? nil, "subProject" : self.selectSubproject ?? nil, "task": self.selectWorkTask ?? nil, "type" : "Project"] as [String : Any?]
                self.UIInfo = info
                self.isBusiness = false
            }
            else if((self.UIInfo["type"] as! String) == "Business Area"){
                self.txtExpenseType.text = NSLocalizedString("dept", comment: "")
                let info = ["title": txtExpenseTitle!.text!, "project" : self.selectedProject ?? nil, "subProject" : self.selectSubproject ?? nil, "task": self.selectWorkTask ?? nil,"type" : "Business Area"] as [String : Any?]
                self.UIInfo = info
                self.isBusiness = true
            }
            else {
                self.txtExpenseType.text = NSLocalizedString("dept", comment: "")
                let info = ["title": txtExpenseTitle!.text!, "project" : self.selectedProject ?? nil, "subProject" : self.selectSubproject ?? nil, "task": self.selectWorkTask ?? nil,"type" : "Department"] as [String : Any?]
                self.UIInfo = info
                self.isBusiness = false
            }
            self.txtTotalAmount.text = "\(editExpense?.totalClaimAmount ?? 0.0)"
            
            self.getExpenseSubclamisList()
            
            //
        }
        }
        else{
            if let expense = self.editOfflineData{
                self.title = NSLocalizedString("edit_draft", comment: "")
                self.txtExpenseTitle.text = expense.expenseTitle
                if let project = expense.project, project.projectName != ""{
                    self.isProject = true
                    self.txtExpenseType.text = NSLocalizedString("proj", comment: "")
                    self.selectedProject = ProjectVM(_id: expense.project?._id, projectName: expense.project?.projectName)
                    if let subProject = expense.subProjct, subProject.subProjectName != ""{
                        self.selectSubproject = SubProjectVM(_id: expense.subProjct?._id, subProjectName: expense.subProjct?.subProjectName)
                        
                    }
                    if let taskProject = expense.task, taskProject.taskName != ""{
                        self.selectWorkTask = TaskModel(_id: expense.task?.id, taskName: expense.task?.taskName, taskDesc: nil)
                    }
                    let info = ["title": expense.expenseTitle, "project" : expense.project ?? nil, "subProject" : expense.subProjct ?? nil, "task": expense.task ?? nil,"type" : "Project"] as [String : Any?]
                    self.UIInfo = info
                    self.isBusiness = false
                }
                else if expense.isBusiness ?? false{
                    self.txtExpenseType.text = NSLocalizedString("business", comment: "")
                    let info = ["title": expense.expenseTitle, "project" : expense.project ?? nil, "subProject" : expense.subProjct ?? nil, "task": expense.task ?? nil,"type" : "Business Area"] as [String : Any?]
                    self.isBusiness = true
                    self.UIInfo = info
                }
                else{
                    self.txtExpenseType.text = NSLocalizedString("dept", comment: "")
                    let info = ["title": expense.expenseTitle, "project" : expense.project ?? nil, "subProject" : expense.subProjct ?? nil, "task": expense.task ?? nil,"type" : "Department"] as [String : Any?]
                    self.UIInfo = info
                    self.isBusiness = false
                }
                self.txtTotalAmount.text = "\(expense.totalAmount ?? 0.0)"
                self.itemsList = expense.itemsList ?? []
                self.tblView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.islangauge(self.currentLanguage()){return}
        self.setupUI()
        self.viewUpdates()
    }
    
    
    private func setupUI(){
        self.submitBtn.setTitle(NSLocalizedString("submit", comment: ""), for: .normal)
        self.draftBtn.setTitle(NSLocalizedString("save_draft", comment: ""), for: .normal)
        self.addItemBtn.setTitle(NSLocalizedString("add_item", comment: ""), for: .normal)
        self.updateExpenseBtn.setTitle(NSLocalizedString("update_exp", comment: ""), for: .normal)
        self.Tamount.text = NSLocalizedString("total_amount", comment: "")
        self.tExpenseType.text = NSLocalizedString("expense_type", comment: "")
        self.tExpenseTitle.text = NSLocalizedString("expense_title", comment: "")
    }
    
    //BAckbutton Action
    @objc func BackButtonTapped(){
        //Pop to home view controller
        self.navigationController?.popViewController(animated: true)
    }
    
    private func getBusinessList(){
        showLoader()
        ExpenseSubClaimsAPI.apiExpenseIsBusinessDropDownGet(_isBusiness: self.isBusiness, completion: { (result, error) in
            hideLoader()
            if error == nil {
                self.expenseBusinessList = result ?? []
                DispatchQueue.main.async {
                    self.tblView.reloadData()
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
        })
    }
    //https://fwserver.atocash.com/api/ExpenseTypes/ExpenseTypesForExpenseCategoryId/103
    //[{id: 1018, expenseTypeName: "LOCAL PURCHASES CASH VENDOR:LOCAL PURCHASES CASH VENDOR"}]
    //https://fwserver.atocash.com/api/VATRate/GetVATPercentage/
    //{id: 1, vatPercentage: 15}
    
    //https://fwserver.atocash.com/api/ExpenseReimburseRequests/PostExpenseReimburseRequest
    
    /*
     {"expenseReportTitle":"vgfvgvgv","projectId":null,"subProjectId":null,"workTaskId":null,"expensefor":"Business Area","employeeId":"10004","currencyTypeId":1,"isBusinessAreaReq":true,"expenseSubClaims":[{"expenseCategoryId":101,"invoiceNo":"1234","invoiceDate":"2022-12-10T20:00:01.166Z","expenseTypeId":1001,"expenseReimbClaimAmount":100,"location":"Madurai","vendor":"taj","description":"Madurai","taxNo":"12345","NoOfDaysDate":["2022-11-08T20:00:16.953Z","2022-12-08T20:00:16.953Z"],"isVAT":true,"tax":15,"taxAmount":15,"expStrtDate":"2022-11-08T20:00:16.953Z","expEndDate":"2022-12-08T20:00:16.953Z","expNoOfDays":31,"documentIds":"45"}]}
     */
    private func getExpenseSubclamisList(){
        showLoader()
        ExpenseSubClaimsAPI.apiExpenseSubClaimsGetExpenseSubClaimsByExpenseIdIdGet(_id: (self.editExpense?._id)!) { (result, error) in
            hideLoader()
            if error == nil {
                let expenseSubClaims = result ?? []
                for item in expenseSubClaims{
                    let selectDoc = (item.documentIDs ?? "").components(separatedBy: ",")
                    var uploadImg = [imageUpload]()
                    for docs in selectDoc{
                        let inbox = imageUpload(fileName: docs, fileData: nil, fileType: nil, filePath: nil, fileExtension: nil)
                        uploadImg.append(inbox)
                    }
                    //Fix
                    var selectBusiness: ExpenseBusinessDTO?
                    for drop in self.expenseBusinessList{
                        if (item.expenseCategoryId ?? 0) == drop._id!{
                            selectBusiness = drop
                            break
                        
                        }
                    }
                    
                    let addItem = addItemInfo(_id: item._id, expenseReimbClaimAmount: item.expenseReimbClaimAmount, documentIDs: item.documentIDs, expReimReqDate: item.expReimReqDate, invoiceNo: item.invoiceNo, invoiceDate: item.invoiceDate, tax: item.tax, taxAmount: item.taxAmount, vendor: item.vendor, location: item.location, _description: item._description, expenseTypeId: item.expenseTypeId, expenseType: item.expenseType, selectDocument: uploadImg, isDuplicate: false,expCategory: "\(item.expenseCategoryId ?? 0)",startDate: item.expStrtDate,endDate: item.expEndDate,noDays: "\(item.expNoOfDays ?? 0)",taxNo: item.taxNo,isVAT: item.isVAT, businessExpenseId: selectBusiness?._id,buinessCategoryName:selectBusiness?.expenseCategoryName)
                    self.itemsList.append(addItem)
                }
                DispatchQueue.main.async {
                    self.tblView.reloadData()
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
    
    
    
    @IBAction func updateExpense(_ sender: Any){
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "CreateExpenseViewController") as! CreateExpenseViewController
        vc.modalPresentationStyle = .overCurrentContext
        vc.expenseDelegate = self
        vc.viewDetailModel = UIInfo
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func addItemAction(_ sender: Any?){
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "AddItemViewController") as! AddItemViewController
        vc.modalPresentationStyle = .fullScreen
        vc.selectedIndex = nil
        vc.editInfo = nil
        vc.delegate = self
        vc.isBusiness = self.isBusiness
        vc.expenseBusinessList = self.expenseBusinessList
        self.present(vc, animated: true, completion: nil)
    }
    
    func expenseViewUIupdate(_ info: [String : Any?]) {
        self.UIInfo = info
        self.txtExpenseTitle.text = (UIInfo["title"] as! String)
        self.isProject = false
        if let project = UIInfo["project"] as? ProjectVM{
            self.isProject = true
            self.txtExpenseType.text = NSLocalizedString("proj", comment: "")
            print(project)
        }
        else if((UIInfo["type"] as! String) == "Business Area"){
            self.isBusiness = true
            self.txtExpenseType.text = NSLocalizedString("business", comment: "")
        }
        else{
            self.isBusiness = false
            self.txtExpenseType.text = NSLocalizedString("dept", comment: "")
        }
        self.getBusinessList()
    }
    
    func addItemsList(_ info: addItemInfo, selectIndex: Int?) {
        if selectIndex == nil {
            self.itemsList.append(info)
        }
        else{
            self.itemsList.remove(at: selectIndex!)
            self.itemsList.insert(info, at: selectIndex!)
        }
        DispatchQueue.main.async {
            self.tblView.reloadData()
        }
        self.calculateTotalAmount()
    }
    
    
    func calculateTotalAmount(){
        var total = 0.0
        for items in self.itemsList{
            total = total + ((items.expenseReimbClaimAmount ?? 0.0) + (items.taxAmount ?? 0.0))
        }
        self.txtTotalAmount.text = String(format: "%.2f", total)
    }
    
    @IBAction func saveDraftAction(_ sender: Any) {
      
        if self.itemsList.count > 0{
            var isAttachment = false
            for item in self.itemsList{
                if item.selectDocument == nil || item.selectDocument?.count == 0{
                    isAttachment = true
                    break
                }
            }
            if !isAttachment{
            
                if let expenseData = DefaultsManager.shared.expenseRequest?.keys.first{
                    if self.editOfflineDataIndex != nil {
                            DefaultsManager.shared.expenseRequest?[DefaultsManager.shared.userID!]?.remove(at: self.editOfflineDataIndex!)
                        let offline = offlineData(expenseTitle: self.txtExpenseTitle.text, project: self.selectedProject, subProjct: self.selectSubproject, task: self.selectWorkTask, empId: Int(DefaultsManager.shared.userID!), totalAmount: Double(self.txtTotalAmount.text ?? "0.0"), expenseDate: Date(), itemsList: self.itemsList, isBusiness: !self.isProject, isDepart: self.isBusiness)
                            DefaultsManager.shared.expenseRequest?[DefaultsManager.shared.userID!]?.insert(offline, at: self.editOfflineDataIndex!)
                    }
                    else{
                    
                    if var expense = DefaultsManager.shared.expenseRequest![expenseData], expense.count > 0{
                        
                        expense.removeAll()
                        let offline = offlineData(expenseTitle: self.txtExpenseTitle.text, project: self.selectedProject, subProjct: self.selectSubproject, task: self.selectWorkTask, empId: Int(DefaultsManager.shared.userID!), totalAmount: Double(self.txtTotalAmount.text ?? "0.0"), expenseDate: Date(), itemsList: self.itemsList, isBusiness: !self.isProject, isDepart: self.isBusiness)
                        DefaultsManager.shared.expenseRequest?[DefaultsManager.shared.userID!]?.append(offline)
                    }
                    else{
                        let offline = offlineData(expenseTitle: self.txtExpenseTitle.text, project: self.selectedProject, subProjct: self.selectSubproject, task: self.selectWorkTask, empId: Int(DefaultsManager.shared.userID!), totalAmount: Double(self.txtTotalAmount.text ?? "0.0"), expenseDate: Date(), itemsList: self.itemsList, isBusiness: !self.isProject, isDepart: self.isBusiness)
                        DefaultsManager.shared.expenseRequest?[DefaultsManager.shared.userID!]?.append(offline)
                    }
                    }

                }
                else{
                    let offline = offlineData(expenseTitle: self.txtExpenseTitle.text, project: self.selectedProject, subProjct: self.selectSubproject, task: self.selectWorkTask, empId: Int(DefaultsManager.shared.userID!), totalAmount: Double(self.txtTotalAmount.text ?? "0.0"), expenseDate: Date(), itemsList: self.itemsList, isBusiness: !self.isProject, isDepart: self.isBusiness)
                    DefaultsManager.shared.expenseRequest?[DefaultsManager.shared.userID!]?.append(offline)
                }
                Loaf(NSLocalizedString("save_draft1", comment: ""), state: .success, location: .top, sender: self).show(.short, completionHandler: nil)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    self.navigationController?.popViewController(animated: true)
                }
                
            }
            else{
                Loaf(NSLocalizedString("attchment_error", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
            }
        }
        else{
            Loaf(NSLocalizedString("exp_submit", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
        

        //Loaf("Local save process pending", state: .warning, location: .top, sender: self).show(.short, completionHandler: nil)
    }
    @IBAction func createAction(_ sender: Any) {
        if self.itemsList.count > 0{
            var isAttachment = false
            for item in self.itemsList{
                if item.selectDocument == nil || item.selectDocument?.count == 0{
                    isAttachment = true
                    break
                }
            }
            if !isAttachment{
                DispatchQueue.main.async {
                let vc = mainStoryboard.instantiateViewController(withIdentifier: "ExpenseSubmitViewController") as! ExpenseSubmitViewController
                vc.itemsList = self.itemsList
                vc.totalAmount = self.txtTotalAmount.text
                vc.charge = self.txtExpenseType.text
                vc.delegate = self
                vc.modalPresentationStyle = .overCurrentContext
                self.present(vc, animated: true, completion: nil)
                }
            }
            else{
                Loaf(NSLocalizedString("attchment_error", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
            }
        }
        else{
            Loaf(NSLocalizedString("exp_submit", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
    }
    
    func submitExpense() {
        self.submitProcessAPI()
    }
    
    func submitProcessAPI(){
        showLoader()
        
        var params : ExpenseReimburseRequestDTO!
        var expenseList = [ExpenseSubClaimDTO]()
        
            for items in self.itemsList{
                expenseList.append(ExpenseSubClaimDTO(_id: items._id, employeeName: nil, employeeId: nil, expenseReimbClaimAmount: items.expenseReimbClaimAmount, documentIDs: items.documentIDs, expReimReqDate: items.expReimReqDate, invoiceNo: items.invoiceNo, invoiceDate: items.invoiceDate, tax: items.tax, taxAmount: items.taxAmount, vendor: items.vendor, location: items.location, _description: items._description, currencyTypeId: nil, currencyType: nil, expenseTypeId: items.expenseTypeId, expenseType: items.expenseType, department: nil, departmentId: nil, project: nil, projectId: nil, subProject: nil, subProjectId: nil, workTask: nil, workTaskId: nil, approvalStatusType: nil, approvalStatusTypeId: nil, approvedDate: nil,expenseCategoryId: items.businessExpenseId,taxNo: items.taxNo, NoOfDaysDate: [items.startDate,items.endDate], isVAT: items.isVat,expStrtDate: items.endDate, expEndDate: items.endDate,expNoOfDays: Int(items.noDays ?? "0") ?? 0))
            }
        
        if let project = UIInfo["project"] as? ProjectVM{
            let subproject = (UIInfo["subProject"] as? SubProjectVM) == nil ? nil : (UIInfo["subProject"] as? SubProjectVM)
            let task = (UIInfo["task"] as? TaskModel) == nil ? nil : (UIInfo["task"] as? TaskModel)
            params = ExpenseReimburseRequestDTO(_id: 0, expenseReportTitle: self.txtExpenseTitle.text, employeeId: Int(DefaultsManager.shared.userID!), employeeName: DefaultsManager.shared.fName! + " " + DefaultsManager.shared.lName!, currencyTypeId: Int(DefaultsManager.shared.currencyId!), totalClaimAmount: Double(self.txtTotalAmount.text!), expReimReqDate: Date(), department: nil, departmentId: nil, project: project.projectName, projectId: project._id, subProject: subproject == nil ? nil : subproject?.subProjectName, subProjectId: subproject == nil ? nil : subproject?._id, workTask: task == nil ? nil : task?.taskName, workTaskId: task == nil ? nil : task?.id, approvalStatusTypeId: nil, approvalStatusType: nil, approvedDate: nil, showEditDelete: true, expenseSubClaims: expenseList,expensefor: "Project",isBusinessAreaReq: nil)
        }
        else if((self.UIInfo["type"] as! String) == "Business Area"){
            params = ExpenseReimburseRequestDTO(_id: 0, expenseReportTitle: self.txtExpenseTitle.text, employeeId: Int(DefaultsManager.shared.userID!), employeeName: DefaultsManager.shared.fName! + " " + DefaultsManager.shared.lName!, currencyTypeId: Int(DefaultsManager.shared.currencyId!), totalClaimAmount: Double(self.txtTotalAmount.text!), expReimReqDate: Date(), department: nil, departmentId: nil, project: nil, projectId: nil, subProject: nil, subProjectId: nil, workTask: nil, workTaskId: nil, approvalStatusTypeId: nil, approvalStatusType: nil, approvedDate: nil, showEditDelete: true, expenseSubClaims: expenseList, expensefor: "Business Area",isBusinessAreaReq: true)
        }
        else{
            params = ExpenseReimburseRequestDTO(_id: 0, expenseReportTitle: self.txtExpenseTitle.text, employeeId: Int(DefaultsManager.shared.userID!), employeeName: DefaultsManager.shared.fName! + " " + DefaultsManager.shared.lName!, currencyTypeId: Int(DefaultsManager.shared.currencyId!), totalClaimAmount: Double(self.txtTotalAmount.text!), expReimReqDate: Date(), department: nil, departmentId: nil, project: nil, projectId: nil, subProject: nil, subProjectId: nil, workTask: nil, workTaskId: nil, approvalStatusTypeId: nil, approvalStatusType: nil, approvedDate: nil, showEditDelete: true, expenseSubClaims: expenseList,expensefor: "Department",isBusinessAreaReq: false)
        }
        
        ExpenseReimburseRequestsAPI.apiExpenseReimburseRequestsPostExpenseReimburseRequestPost(body: params) { (result, error) in
            hideLoader()
            if error == nil {
                print("success")
                if self.editOfflineDataIndex != nil {
                        DefaultsManager.shared.expenseRequest?[DefaultsManager.shared.userID!]?.remove(at: self.editOfflineDataIndex!)
                }
                Loaf(NSLocalizedString("expense_success", comment: ""), state: .success, location: .top, sender: self).show(.short, completionHandler: nil)
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

extension ExpenseFormViewController : UITableViewDataSource,UITableViewDelegate, ExpenseClaimDelegate{
    func moreActionTag(_ sender: Int) {
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemsList.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "expenseClaimCell") as! ExpenseClaimCell
        let claims = self.itemsList[indexPath.row]
        cell.tInvoiceDate.text = NSLocalizedString("invoice_date", comment: "")
        cell.tClaimAmount.text = NSLocalizedString("claim_amount", comment: "")
        cell.moreInfoBtn.setTitle(NSLocalizedString("moreinfo", comment: ""), for: .normal)
        
        let docsString = (claims.selectDocument?.count ?? 0) > 1 ? NSLocalizedString("documents_attach", comment: "") : NSLocalizedString("document_attach", comment: "")
        cell.attchmentFiles.text = "\(claims.selectDocument?.count ?? 0) \(docsString)"
        cell.lblInvoiceNo.text = " " + claims.invoiceNo! + " "
        cell.lblDesc.text = claims._description
        let total = (claims.expenseReimbClaimAmount ?? 0.0) + (claims.taxAmount ?? 0.0)
        cell.lblClaimAmount.text = String(format: "%.2f", total)
        cell.lblInvoiceDate.text = UtilsManager.shared.systemDateStringFromUTC(utcDate: UtilsManager.shared.systemDatetoString(claims.invoiceDate!),formatOf: "dd MMM yyyy")
        cell.deleteBtn.tag = indexPath.row
        cell.editBtn.tag = indexPath.row
        cell.copyBtn.tag = indexPath.row
        cell.moreInfoBtn.isHidden = true
        cell.claimDelegate = self
        
        if let doc = claims.selectDocument{
            if doc.count > 0{
                cell.baseView.borderColor = UIColor.green
                cell.baseView.borderWidth = 1.0
                cell.statusIcon.image = UIImage(named: "approveAccept")
                cell.statusIcon.backgroundColor = .clear
                cell.statusIcon.tintColor = .clear
            }
            else{
                cell.baseView.borderColor = UIColor.red
                cell.baseView.borderWidth = 1.0
                cell.statusIcon.image = UIImage(named: "Close-1")
                //cell.statusIcon.isHighlighted = true
                cell.statusIcon.backgroundColor = UIColor.red
                cell.statusIcon.tintColor = .white
            }
        }
        else{
            cell.baseView.borderColor = UIColor.red
            cell.baseView.borderWidth = 1.0
            cell.statusIcon.image = UIImage(named: "Close-1")
            cell.statusIcon.backgroundColor = UIColor.red
            cell.statusIcon.tintColor = .white
        }
        
        return cell
    }
    
    func editActionTag(_ sender: Int) {
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "AddItemViewController") as! AddItemViewController
        vc.modalPresentationStyle = .fullScreen
        vc.selectedIndex = sender
        vc.editInfo = self.itemsList[sender]
        vc.delegate = self
        vc.isBusiness = self.isBusiness
        vc.expenseBusinessList = self.expenseBusinessList
        vc.isProject = self.isProject
        self.present(vc, animated: true, completion: nil)
        
    }
    func deleteActionTag(_ sender: Int) {
        let alert = UIAlertController(title: NSLocalizedString("delete", comment: ""), message: NSLocalizedString("delete_alert", comment: ""), preferredStyle: .alert)
        let okAlert = UIAlertAction(title: NSLocalizedString("yes", comment: ""), style: .destructive) { (action) in
            self.itemsList.remove(at: sender)
            self.calculateTotalAmount()
            DispatchQueue.main.async {
                self.tblView.reloadData()
            }
        }
        let cancelAlert = UIAlertAction(title: NSLocalizedString("no", comment: ""), style: .cancel, handler: nil)
        alert.addAction(okAlert)
        alert.addAction(cancelAlert)
        self.present(alert, animated: true, completion: nil)
    }
    func copyActionTag(_ sender: Int) {
        let items = self.itemsList[sender]
        let copyItems = addItemInfo(_id: items._id, expenseReimbClaimAmount: items.expenseReimbClaimAmount, documentIDs: "", expReimReqDate: items.expReimReqDate, invoiceNo: items.invoiceNo, invoiceDate: items.invoiceDate, tax: items.tax, taxAmount: items.taxAmount, vendor: items.vendor, location: items.location, _description: items._description, expenseTypeId: items.expenseTypeId, expenseType: items.expenseType, selectDocument: nil, isDuplicate: true,expCategory: items.expenseCategory,startDate: items.startDate,endDate: items.endDate,noDays: items.noDays,taxNo: items.taxNo,isVAT: items.isVat,businessExpenseId: items.businessExpenseId,buinessCategoryName: items.buinessCategoryName)
        self.itemsList.append(copyItems)
        self.calculateTotalAmount()
        DispatchQueue.main.async {
            self.tblView.reloadData()
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//
//  AddItemViewController.swift
//  AtoCash
//
//  Created by user on 20/04/21.
//

import UIKit
import MobileCoreServices

struct imageUpload : Codable{
    var fileName : String?
    var fileData : Data?
    var fileType : String?
    var filePath : String?
    var fileExtension : String?
    
    init(fileName : String?,fileData : Data?,fileType : String?,filePath : String?,fileExtension : String? ){
        self.fileName = fileName
        self.fileData = fileData
        self.fileType = fileType
        self.filePath = filePath
        self.fileExtension = fileExtension
    }
    enum CodingKeys: String, CodingKey,CaseIterable {
        case fileName
        case fileData
        case fileType
        case filePath
        case fileExtension
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        fileName = try values.decodeIfPresent(String.self, forKey: .fileName)
        fileData = try values.decodeIfPresent(Data.self, forKey: .fileData)
        fileType = try values.decodeIfPresent(String.self, forKey: .fileType)
        filePath = try values.decodeIfPresent(String.self, forKey: .filePath)
        fileExtension = try values.decodeIfPresent(String.self, forKey: .fileExtension)
    }
}

struct addItemInfo : Codable{
     var _id: Int?
    var expenseCategory : String?
    var startDate : Date?
    var endDate: Date?
    var noDays : String?
    var taxNo : String?
    var isVat : Bool?
     var expenseReimbClaimAmount: Double?
     var documentIDs: String?
     var expReimReqDate: Date?
     var invoiceNo: String?
     var invoiceDate: Date?
     var tax: Float?
     var taxAmount: Double?
     var vendor: String?
     var location: String?
     var _description: String?
     var expenseTypeId: Int?
     var expenseType: String?
     var selectDocument : [imageUpload]?
     var isDuplicate : Bool? = false
    var selectedVendorId :Int?
    var selectedVendorOthers : String?
    var businessExpenseId : Int?
    var buinessCategoryName : String?
    init( _id: Int?,expenseReimbClaimAmount: Double?,documentIDs: String?,expReimReqDate: Date?,invoiceNo: String?,invoiceDate: Date?,tax: Float?,taxAmount: Double?,vendor: String?,location: String?,_description: String?, expenseTypeId: Int?,expenseType: String?,selectDocument : [imageUpload]?,isDuplicate : Bool? = false, expCategory : String?, startDate: Date?, endDate : Date?, noDays : String?, taxNo : String?, isVAT : Bool?, businessExpenseId : Int?,buinessCategoryName : String?, selectedVendorId :Int?,selectedVendorOthers : String?){
        self._id = _id
        self.expenseReimbClaimAmount = expenseReimbClaimAmount
        self.documentIDs = documentIDs
        self.expReimReqDate = expReimReqDate
        self.invoiceNo = invoiceNo
        self.invoiceDate = invoiceDate
        self.tax = tax
        self.taxAmount = taxAmount
        self.vendor = vendor
        self.location = location
        self._description = _description
        self.expenseTypeId = expenseTypeId
        self.expenseType = expenseType
        self.selectDocument = selectDocument
        self.isDuplicate = isDuplicate
        self.expenseCategory = expCategory
        self.startDate = startDate
        self.endDate = endDate
        self.noDays = noDays
        self.taxNo = taxNo
        self.isVat = isVAT
        self.businessExpenseId = businessExpenseId
        self.buinessCategoryName = buinessCategoryName
        self.selectedVendorId = selectedVendorId
        self.selectedVendorOthers = selectedVendorOthers
    }
    
    
    enum CodingKeys: String, CodingKey,CaseIterable {
        
        case _id
        case expenseReimbClaimAmount
        case documentIDs
        case expReimReqDate
        case invoiceNo
        case invoiceDate
        case tax
        case taxAmount
        case vendor
        case location
        case _description
        case expenseTypeId
        case expenseType
        case selectDocument
        case isDuplicate
        case expenseCategory
        case startDate
        case endDate
        case noDays
        case taxNo
        case isVat
        case businessExpenseId
        case buinessCategoryName
        case selectedVendorId
        case selectedVendorOthers
        
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(Int.self, forKey: ._id)
        expenseReimbClaimAmount = try values.decodeIfPresent(Double.self, forKey: .expenseReimbClaimAmount)
        documentIDs = try values.decodeIfPresent(String.self, forKey: .documentIDs)
        expReimReqDate = try values.decodeIfPresent(Date.self, forKey: .expReimReqDate)
        invoiceNo = try values.decodeIfPresent(String.self, forKey: .invoiceNo)
        invoiceDate = try values.decodeIfPresent(Date.self, forKey: .invoiceDate)
        tax = try values.decodeIfPresent(Float.self, forKey: .tax)
        taxAmount = try values.decodeIfPresent(Double.self, forKey: .taxAmount)
        vendor = try values.decodeIfPresent(String.self, forKey: .vendor)
        location = try values.decodeIfPresent(String.self, forKey: .location)
        _description = try values.decodeIfPresent(String.self, forKey: ._description)
        expenseTypeId = try values.decodeIfPresent(Int.self, forKey: .expenseTypeId)
        expenseType = try values.decodeIfPresent(String.self, forKey: .expenseType)
        selectDocument = try values.decodeIfPresent([imageUpload].self, forKey: .selectDocument)
        isDuplicate = try values.decodeIfPresent(Bool.self, forKey: .isDuplicate)
        expenseCategory = try values.decodeIfPresent(String.self, forKey: .expenseCategory)
        startDate = try values.decodeIfPresent(Date.self, forKey: .startDate)
        endDate = try values.decodeIfPresent(Date.self, forKey: .endDate)
        noDays = try values.decodeIfPresent(String.self, forKey: .noDays)
        taxNo = try values.decodeIfPresent(String.self, forKey: .taxNo)
        isVat = try values.decodeIfPresent(Bool.self, forKey: .isVat)
        businessExpenseId = try values.decodeIfPresent(Int.self, forKey: .businessExpenseId)
        selectedVendorId = try values.decodeIfPresent(Int.self, forKey: .selectedVendorId)
        selectedVendorOthers = try values.decodeIfPresent(String.self, forKey: .selectedVendorOthers)
        buinessCategoryName = try values.decodeIfPresent(String.self, forKey: .buinessCategoryName)
    }
}
let SCREEN_WIDTH = UIScreen.main.bounds.width
let SCREEN_HEIGHT = UIScreen.main.bounds.height
protocol addItemDelegate: NSObjectProtocol {
    func addItemsList(_ info : addItemInfo, selectIndex : Int?)
}

class AddItemViewController: UIViewController {
    
    @IBOutlet weak var vendorOthersView: UIView!
    @IBOutlet weak var txtOthersVendor: UITextField!
    @IBOutlet weak var lblOthers: UILabel!
    @IBOutlet weak var lblTaxNo: UILabel!
    @IBOutlet weak var txtStartDates: UITextField!
    @IBOutlet weak var lblStartDate: UILabel!
    @IBOutlet weak var isVatToggle: UISwitch!
    @IBOutlet weak var isVatLabel: UILabel!
    @IBOutlet weak var isVatView: UIView!
    @IBOutlet weak var noDaysView: UIView!
    @IBOutlet weak var endDateView: UIView!
    @IBOutlet weak var startDateView: UIView!
    @IBOutlet weak var expenseCategoryView: UIView!
    //UI Localization
    @IBOutlet weak var tAddExpenseTitle: UILabel!
    
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var uploadBtn: UIButton!
    @IBOutlet weak var tTaxAmount: UILabel!
    @IBOutlet weak var tVendor: UILabel!
    @IBOutlet weak var tExpenseAmount: UILabel!
    @IBOutlet weak var tInvoiceDate: UILabel!
    @IBOutlet weak var tInvoiceNo: UILabel!
    @IBOutlet weak var tExpenseTitle: UILabel!
    
    @IBOutlet weak var tDocument: UILabel!
    @IBOutlet weak var tDescription: UILabel!
    @IBOutlet weak var tLocation: UILabel!
    @IBOutlet weak var tTax: UILabel!
    
    @IBOutlet weak var createBtn: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var txtDesc: UITextView!
    @IBOutlet weak var txtLocation: UITextField!
    @IBOutlet weak var txtTaxAmountCal: UITextField!
    @IBOutlet weak var txtTax: UITextField!
    @IBOutlet weak var txtExpenseAmount: UITextField!
    @IBOutlet weak var txtVendor: UITextField!
    @IBOutlet weak var txtExpenseType: UITextField!
    @IBOutlet weak var txtInvoiceDate: UITextField!
    @IBOutlet weak var txtInvoiceNo: UITextField!
    var collectionFlowLayout : UICollectionViewFlowLayout!
    var expenseTypeList = [ExpenseTypeDTO]()
    @IBOutlet weak var txtEndDate: UITextField!
    @IBOutlet weak var txtTaxNo: UITextField!
    var selectedExpenseType : ExpenseTypeDTO?
    var selectedBusinessExpense : ExpenseBusinessDTO?
    var selectedBusinessCategory : ExpenseBusinessCategoryDTO?
    
    @IBOutlet weak var taxNoView: UIView!
    @IBOutlet weak var txtExpenseCategory: UITextField!
    @IBOutlet weak var lblExpenseCategory: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    var selectDocument = [imageUpload]()
    weak var delegate : addItemDelegate?
    var selectedIndex : Int?
    var expenseBusinessList = [ExpenseBusinessDTO]()
    var expenseBusinessCetegoryList = [ExpenseBusinessCategoryDTO]()
    var expenseVAT : ExpenseVATDTO?
    @IBOutlet weak var txtDays: UITextField!
    @IBOutlet weak var noDaysLabel: UILabel!
    var editInfo : addItemInfo?
    var isBusiness = false
    var isNewTaxAmount = ""
    var isProject = false
    
    var vendorList = [ExpenseVendorDTO]()
    var selectedVendor : ExpenseVendorDTO?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.getBusinessList()
        self.getVATPercentage()
        self.getVendorList()
        self.vendorOthersView.isHidden = true
        self.txtExpenseType.setupRightPadview()
        self.txtExpenseCategory.setupRightPadview()
        self.txtInvoiceDate.setupDateRightPadview()
        self.txtStartDates.setupDateRightPadview()
        self.txtEndDate.setupDateRightPadview()
        self.txtVendor.setupRightPadview()
        self.txtInvoiceDate.setInputViewPicker(nil, target: self, selector: #selector(invoiceDate))
        self.txtStartDates.setInputViewPicker(nil, target: self, selector: #selector(startDatess))
        self.txtEndDate.setInputViewPicker(nil, target: self, selector: #selector(endDatess))
        
        //self.collectionView.isHidden = true
        self.collectionView.register(UINib(nibName: "MediaSelectionCell", bundle: nil), forCellWithReuseIdentifier: "mediaCell")
        setupCollectionView()
        self.getExpenseType()
        if let edit = editInfo, self.selectedIndex != nil && !(edit.isDuplicate!){
            self.selectDocument = [imageUpload]()
//            self.selectDocument = edit.selectDocument!
            self.txtExpenseType.text = edit.expenseType
            self.txtInvoiceNo.text = edit.invoiceNo
            self.txtInvoiceDate.text =  UtilsManager.shared.systemDateStringFromUTC(utcDate: UtilsManager.shared.systemDatetoString(edit.invoiceDate!),formatOf: "dd-MMM-yyyy")
            self.txtExpenseAmount.text = "\(edit.expenseReimbClaimAmount ?? 0)"
            self.txtVendor.text = edit.vendor
            self.selectedVendor = ExpenseVendorDTO(_id: edit.selectedVendorId,vendorName: edit.vendor)
            if(edit.vendor == "Other Vendors"){
                self.vendorOthersView.isHidden = false
                self.txtOthersVendor.text = edit.selectedVendorOthers
            }
            else{
                self.vendorOthersView.isHidden = true
                self.txtOthersVendor.text = ""
            }
            self.txtTax.text = "\(edit.tax ?? 0)"
            self.txtTaxAmountCal.text = "\(edit.taxAmount ?? 0)"
            self.txtLocation.text = edit.location
            self.txtDesc.text = edit._description
            if !self.isProject{
                self.selectedBusinessCategory = ExpenseBusinessCategoryDTO(_id: edit.expenseTypeId,expenseTypeName: edit.expenseCategory)
            }
            else{
                self.selectedExpenseType = ExpenseTypeDTO(_id: edit.expenseTypeId, expenseTypeName: edit.expenseType, expenseTypeDesc: nil, statusType: nil, statusTypeId: nil)
            }
            self.selectedBusinessExpense = ExpenseBusinessDTO(_id: edit.businessExpenseId,expenseCategoryName: edit.buinessCategoryName)
            self.txtExpenseCategory.text = edit.buinessCategoryName ?? ""
            if edit.startDate != nil {
                self.txtStartDates.text = UtilsManager.shared.systemDateStringFromUTC(utcDate: UtilsManager.shared.systemDatetoString(edit.startDate!),formatOf: "dd-MMM-yyyy")
            }
            if edit.endDate != nil {
                self.txtEndDate.text = UtilsManager.shared.systemDateStringFromUTC(utcDate: UtilsManager.shared.systemDatetoString(edit.endDate!),formatOf: "dd-MMM-yyyy")
            }
            self.txtDays.text = edit.noDays ?? ""
            self.txtTaxNo.text = edit.taxNo ?? ""
            self.isVatToggle.isOn = edit.isVat ?? false
            
            self.createBtn.setTitle("UPDATE", for: .normal)
        }
        else if self.selectedIndex == nil && self.editInfo == nil{
            self.selectDocument = [imageUpload]()
            self.createBtn.setTitle(NSLocalizedString("create", comment: ""), for: .normal)
        }
        else{
            if let edit = editInfo, edit.isDuplicate!{
                self.selectDocument = [imageUpload]()
                if !self.isProject{
                    self.selectedBusinessCategory = ExpenseBusinessCategoryDTO(_id: edit.expenseTypeId,expenseTypeName: edit.expenseCategory)
                }
                else{
                    self.selectedExpenseType = ExpenseTypeDTO(_id: edit.expenseTypeId, expenseTypeName: edit.expenseType, expenseTypeDesc: nil, statusType: nil, statusTypeId: nil)
                }
//                self.selectedExpenseType = ExpenseTypeDTO(_id: edit.expenseTypeId, expenseTypeName: edit.expenseType, expenseTypeDesc: nil, statusType: nil, statusTypeId: nil)
                self.txtExpenseType.text = edit.expenseType
                self.txtInvoiceNo.text = edit.invoiceNo
                self.txtInvoiceDate.text =  UtilsManager.shared.systemDateStringFromUTC(utcDate: UtilsManager.shared.systemDatetoString(edit.invoiceDate!),formatOf: "dd-MMM-yyyy")
                self.txtExpenseAmount.text = "\(edit.expenseReimbClaimAmount ?? 0)"
                self.txtVendor.text = edit.vendor
                self.selectedVendor = ExpenseVendorDTO(_id: edit.selectedVendorId,vendorName: edit.vendor)
                if(edit.vendor == "Other Vendors"){
                    self.vendorOthersView.isHidden = false
                    self.txtOthersVendor.text = edit.selectedVendorOthers
                }
                else{
                    self.vendorOthersView.isHidden = true
                    self.txtOthersVendor.text = ""
                }
                self.txtTax.text = "\(edit.tax ?? 0)"
                self.txtTaxAmountCal.text = "\(edit.taxAmount ?? 0)"
                self.txtLocation.text = edit.location
                self.txtDesc.text = edit._description
                self.selectedBusinessExpense = ExpenseBusinessDTO(_id: edit.businessExpenseId,expenseCategoryName: edit.buinessCategoryName)
                self.txtExpenseCategory.text = edit.buinessCategoryName ?? ""
                if edit.startDate != nil{
                    self.txtStartDates.text = UtilsManager.shared.systemDateStringFromUTC(utcDate: UtilsManager.shared.systemDatetoString(edit.startDate!),formatOf: "dd-MMM-yyyy")
                }
                if edit.endDate != nil {
                    self.txtEndDate.text = UtilsManager.shared.systemDateStringFromUTC(utcDate: UtilsManager.shared.systemDatetoString(edit.endDate!),formatOf: "dd-MMM-yyyy")
                }
                self.txtDays.text = edit.noDays ?? ""
                self.txtTaxNo.text = edit.taxNo ?? ""
                self.isVatToggle.isOn = edit.isVat ?? false
                self.createBtn.setTitle(NSLocalizedString("update_btn", comment: ""), for: .normal)
            }
            
        }
        self.collectionView.reloadData()
        AttachmentHandler.shared.authorisationStatus(attachmentTypeEnum: .camera, vc: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.islangauge(self.currentLanguage()){ return}
        self.viewUpdates()
        self.setupUI()
    }
    
    private func setupUI(){
        if (self.isProject){
            self.expenseCategoryView.isHidden = true
            self.startDateView.isHidden = true
            self.endDateView.isHidden = true
            self.noDaysView.isHidden = true
            self.isVatView.isHidden = true
            self.taxNoView.isHidden = true
        }

        cancelBtn.setTitle(NSLocalizedString("cancel", comment: ""), for: .normal)
        uploadBtn.setTitle(NSLocalizedString("upload", comment: ""), for: .normal)
        tAddExpenseTitle.text = NSLocalizedString("add_expense", comment: "")
        tTaxAmount.text = NSLocalizedString("tax_amt", comment: "")
        tVendor.text = NSLocalizedString("vend", comment: "")
        tExpenseAmount.text = NSLocalizedString("exp_amount", comment: "")
        tInvoiceDate.text = NSLocalizedString("inv_date", comment: "")
        tInvoiceNo.text = NSLocalizedString("inv_no", comment: "")
        tExpenseTitle.text = NSLocalizedString("expense_cr", comment: "")
        tDocument.text = NSLocalizedString("doc", comment: "")
        tDescription.text = NSLocalizedString("desc", comment: "")
        tLocation.text = NSLocalizedString("loc", comment: "")
        tTax.text = NSLocalizedString("tax_", comment: "")
        lblStartDate.text = NSLocalizedString("start_date", comment: "")
        endDateLabel.text = NSLocalizedString("end_date", comment: "")
        noDaysLabel.text = NSLocalizedString("no_days", comment: "")
        isVatLabel.text = NSLocalizedString("is_vat", comment: "")
        lblExpenseCategory.text = NSLocalizedString("expense_category", comment: "")
        lblTaxNo.text = NSLocalizedString("txt_no", comment: "")

        txtDesc.textAlignment = .defaultAlignment
        txtLocation.textAlignment = .defaultAlignment
        txtTaxAmountCal.textAlignment = .defaultAlignment
        txtTax.textAlignment = .defaultAlignment
        txtExpenseAmount.textAlignment = .defaultAlignment
        txtVendor.textAlignment = .defaultAlignment
        txtExpenseType.textAlignment = .defaultAlignment
        txtInvoiceDate.textAlignment = .defaultAlignment
        txtInvoiceNo.textAlignment = .defaultAlignment
        txtExpenseCategory.textAlignment = .defaultAlignment
        txtStartDates.textAlignment = .defaultAlignment
        txtEndDate.textAlignment = .defaultAlignment
        txtDays.textAlignment = .defaultAlignment
        txtTaxNo.textAlignment = .defaultAlignment
        
        if isVatToggle.isOn{
            self.txtTax.text = self.expenseVAT == nil ? "15" : "\(self.expenseVAT?.vatPercentage ?? 0)"
            self.txtTax.isUserInteractionEnabled = false
        }
        else{
            self.txtTax.isUserInteractionEnabled = true
        }
    }
    //Vendor
    private func getVendorList(){
        showLoader()
        ExpenseSubClaimsAPI.apiExpenseVendorDropDownGet(completion: { (result, error) in
            hideLoader()
            if error == nil {
                self.vendorList = result ?? []
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
    
    //Buiness
    private func getBusinessList(){
        showLoader()
        ExpenseSubClaimsAPI.apiExpenseIsBusinessDropDownGet(_isBusiness: self.isBusiness, completion: { (result, error) in
            hideLoader()
            if error == nil {
                self.expenseBusinessList = result ?? []
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
    private func getVATPercentage(){
        showLoader()
        ExpenseSubClaimsAPI.apiExpenseIsVATDropDownGet(_id: 0, completion: { (result, error) in
            hideLoader()
            if error == nil {
                self.expenseVAT = result
                if(self.isVatToggle.isOn){
                    self.txtTax.text = self.expenseVAT == nil ? "15" : "\(self.expenseVAT?.vatPercentage ?? 0)"
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
    private func getBusinessCategoryDropdown(businessId : Int){
        showLoader()
        ExpenseSubClaimsAPI.apiExpenseIsBusinessCategoryDropDownGet(_id: businessId, completion: { (result, error) in
            hideLoader()
            if error == nil {
                self.expenseBusinessCetegoryList = result ?? []
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
    
    @IBAction func isVatAction(_ sender: UISwitch) {
        if isVatToggle.isOn{
            isVatToggle.isOn = sender.isOn
            self.txtTax.text = self.expenseVAT == nil ? "15" : "\(self.expenseVAT?.vatPercentage ?? 0)"
            self.txtTax.isUserInteractionEnabled = false
            let amount = Double(self.txtExpenseAmount.text!) ?? 0.0
            let taxPercentage = Double(self.txtTax.text!) ?? 0.0
            self.txtTaxAmountCal.text = NSString.init(format: "%.2f", ((amount * taxPercentage) / 100)) as String
        }
        else{
            isVatToggle.isOn = sender.isOn
            self.txtTax.text = ""
            self.txtTax.isUserInteractionEnabled = true
            let amount = Double(self.txtExpenseAmount.text!) ?? 0.0
            let taxPercentage = Double(self.txtTax.text!) ?? 0.0
            self.txtTaxAmountCal.text = NSString.init(format: "%.2f", ((amount * taxPercentage) / 100)) as String
        }
    }
    
    @objc func invoiceDate(){
        if let datePicker = self.txtInvoiceDate.inputView as? UIDatePicker { // 2-1
            let dateformatter = DateFormatter() // 2-2
            dateformatter.dateStyle = .long
            dateformatter.dateFormat = "dd-MMM-yyyy"
            self.txtInvoiceDate.text = dateformatter.string(from: datePicker.date) //2-4
        }
        self.txtInvoiceDate.resignFirstResponder() // 2-5
    }
    
    @objc func startDatess(){
        if let datePicker = self.txtStartDates.inputView as? UIDatePicker { // 2-1
            let dateformatter = DateFormatter() // 2-2
            dateformatter.dateStyle = .long
            dateformatter.dateFormat = "dd-MMM-yyyy"
            if self.txtEndDate.text != "" {
                let end = UtilsManager.shared.UTCDateFromString2(date: self.txtEndDate.text!)
                let start = UtilsManager.shared.UTCDateFromString2(date: dateformatter.string(from: datePicker.date) )
                if start <= end
                {
                        self.txtStartDates.text = dateformatter.string(from: datePicker.date) //2-4
                    let startDates = UtilsManager.shared.UTCDateFromString2(date: UtilsManager.shared.UTCDateFromString(date: self.txtStartDates.text!, format: "dd-MMM-yyyy"),format : "yyyy-MM-dd'T'HH:mm:ss.SSS")
                    let endDates = UtilsManager.shared.UTCDateFromString2(date: UtilsManager.shared.UTCDateFromString(date: self.txtEndDate.text!, format: "dd-MMM-yyyy"),format : "yyyy-MM-dd'T'HH:mm:ss.SSS")
                    let differenceDate = self.daysBetween(start: startDates, end: endDates)
                    self.txtDays.text = "\(differenceDate)"
                }
                else{
                    
                    Loaf(NSLocalizedString("startdate_greater", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
                }
            }
            else{
                self.txtStartDates.text = dateformatter.string(from: datePicker.date) //2-4
            }
        }
        self.txtStartDates.resignFirstResponder() // 2-5
    }
    
    @objc func endDatess(){
        if let datePicker = self.txtEndDate.inputView as? UIDatePicker { // 2-1
            let dateformatter = DateFormatter() // 2-2
            dateformatter.dateStyle = .long
            dateformatter.dateFormat = "dd-MMM-yyyy"
            if self.txtStartDates.text != "" {
                let start = UtilsManager.shared.UTCDateFromString2(date: self.txtStartDates.text!)
                let end = UtilsManager.shared.UTCDateFromString2(date: dateformatter.string(from: datePicker.date) )
                if start <= end
                {
                        self.txtEndDate.text = dateformatter.string(from: datePicker.date) //2-4
                    let startDates = UtilsManager.shared.UTCDateFromString2(date: UtilsManager.shared.UTCDateFromString(date: self.txtStartDates.text!, format: "dd-MMM-yyyy"),format : "yyyy-MM-dd'T'HH:mm:ss.SSS")
                    let endDates = UtilsManager.shared.UTCDateFromString2(date: UtilsManager.shared.UTCDateFromString(date: self.txtEndDate.text!, format: "dd-MMM-yyyy"),format : "yyyy-MM-dd'T'HH:mm:ss.SSS")
                    let differenceDate = self.daysBetween(start: startDates, end: endDates)
                    self.txtDays.text = "\(differenceDate)"
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
    
    //MARK:- daysBetween
        func daysBetween(start: Date, end: Date) -> Int {
            return (Calendar.current.dateComponents([.day], from: start, to: end).day!) + 1
        }
    
    func setupCollectionView()
    {
        collectionFlowLayout = UICollectionViewFlowLayout()
        collectionFlowLayout.itemSize = CGSize(width: (SCREEN_WIDTH - 40) / 3, height: 110)
        collectionFlowLayout.minimumLineSpacing = 1
        collectionFlowLayout.minimumInteritemSpacing = 1
        collectionFlowLayout.scrollDirection = .horizontal
        self.collectionView.collectionViewLayout = collectionFlowLayout
        self.collectionView.reloadData()
    }
    
    @IBAction func createAction(_ sender: Any) {
        self.view.endEditing(true)
        if txtExpenseCategory.text == "" && !isProject {
            Loaf(NSLocalizedString("expense_category_error", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
        else if txtExpenseType.text == "" {
            Loaf(NSLocalizedString("expense_type_error", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
        else if(txtInvoiceNo.text == ""){
            Loaf(NSLocalizedString("invno_error", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
        else if(txtInvoiceDate.text == ""){
            Loaf(NSLocalizedString("invdate_error", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
        else if(txtStartDates.text == "" && !isProject){
            Loaf(NSLocalizedString("start_error", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
        else if(txtEndDate.text == "" && !isProject){
            Loaf(NSLocalizedString("end_error", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
        else if(txtTaxNo.text == "" && !isProject){
            Loaf(NSLocalizedString("txt_error", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
        else if(txtExpenseAmount.text == ""){
            Loaf(NSLocalizedString("amount_error", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }else if(txtVendor.text == "" && vendorOthersView.isHidden){
            Loaf(NSLocalizedString("vendor_select_error", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }else if(txtVendor.text != "" && txtOthersVendor.text == "" && !vendorOthersView.isHidden){
            Loaf(NSLocalizedString("vendor_select_other_error", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
        else if(txtTax.text == "" && !isVatToggle.isOn && !isProject){
            Loaf(NSLocalizedString("tax_error", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }else if(txtTax.text == "" && isProject){
            Loaf(NSLocalizedString("tax_error", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }else if(txtLocation.text == ""){
            Loaf(NSLocalizedString("loc_error", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }else if(txtDesc.text == ""){
            Loaf(NSLocalizedString("desc_error", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
        else if(self.selectDocument.count == 0){
            Loaf(NSLocalizedString("doc_error", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
        else{
            self.createExpenseItems()
        }
        //self.createExpenseItems()
        
    }
    @IBAction func uploadFIleAction(_ sender: Any) {
        
        self.view.endEditing(true)
        AttachmentHandler.shared.showAttachmentActionSheet(vc: self)
        AttachmentHandler.shared.imagePickedBlock = { (image) in
        /* get your image here */
            print("Image Picker", image)
            if let imgData = image.resizeImage()!.jpegData(compressionQuality: 1.0) {
                let imageName = UUID().uuidString
                DownloadManager.saveImage(imageName, data: imgData)
                if let path = DownloadManager.pathImage(imageName) {
                    if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                        
                        let imageLoad = imageUpload(fileName: imageName + ".jpg", fileData: data, fileType: "image",filePath: path,fileExtension: "jpg")
                        self.selectDocument.append(imageLoad)
                        self.collectionView.reloadData()
                    }
                }
            }
        }
        AttachmentHandler.shared.videoPickedBlock = { (video) in
            print("Video Picker", video)
        }
        AttachmentHandler.shared.filePickedBlock = { (fileURL) in
            print("file Picker", fileURL)
            if let filedata = try? Data(contentsOf: fileURL) {
                let fileName = UUID().uuidString
                let splitName = fileURL.lastPathComponent.components(separatedBy: ".")
                DownloadManager.saveFile(fileName, data: filedata, ext: splitName.last!)
                if let path = DownloadManager.pathFile(fileName, ext: splitName[1]) {
                    if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                        let fileLoad = imageUpload(fileName: fileName + ".\(splitName[1])", fileData: data, fileType: "file",filePath: path,fileExtension: splitName[1])
                        self.selectDocument.append(fileLoad)
                        self.collectionView.reloadData()
                    }
                }
            }
        }
        
    }
    
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    func getExpenseType(){
        showLoader()
        ExpenseTypesAPI.apiExpenseTypesGetExpenseTypesGet { (result, error) in
            hideLoader()
            if error == nil {
                self.expenseTypeList = result ?? []
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
                            Loaf(NSLocalizedString("somthing_wrong", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
                            print("json error \(error.localizedDescription)")
                        }
                    }
                    
                }
            }
        }
    }
    
    fileprivate func mimeType(forPath path: String) -> String {
        // get a mime type for an extension using MobileCoreServices.framework
        let url = NSURL(fileURLWithPath: path)
        let pathExtension = url.pathExtension
        
        if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension! as NSString, nil)?.takeRetainedValue() {
            if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
                return mimetype as String
            }
        }
        return "application/octet-stream"
    }
    func createExpenseItems(){
        showLoader()
        let headers: HTTPHeaders
        headers = ["Content-type": "multipart/form-data",
                   "Content-Disposition" : "form-data",
                   "Authorization":"bearer \(DefaultsManager.shared.accesstoken ?? "")"]
        // Start Alamofire
        Alamofire.upload(multipartFormData: { multipartFormData in
            for file in self.selectDocument{
                multipartFormData.append(file.fileData!, withName: "documents", fileName: file.fileName!,mimeType: self.mimeType(forPath: file.filePath!))
                print(multipartFormData.boundary)
            }
       },
        usingThreshold: UInt64.init(),
       to: BASEURL + "/api/ExpenseReimburseRequests/PostDocuments",
       method: .post,headers: headers,
       encodingCompletion: { encodingResult in
        
       switch encodingResult {
         case .success(let upload, _, _):
            upload.responseJSON { (response) in
                hideLoader()
                do{
                    if let data = response.data{
                        let jsonDecoder = JSONDecoder()
                        let responseModel = try jsonDecoder.decode([FileDocumentDTO].self, from: data)
                        print("responseModel \(responseModel)")
                        var fileId = [Int]()
                        for model in responseModel {
                            fileId.append(model._id!)
                        }
                        
                        let formattedArray = (fileId.map{String($0)}).joined(separator: ",")
                        print("Documents Number",formattedArray);
                        let invoiceDate = UtilsManager.shared.UTCDateFromString2(date: UtilsManager.shared.UTCDateFromString(date: self.txtInvoiceDate.text!, format: "dd-MMM-yyyy"),format : "yyyy-MM-dd'T'HH:mm:ss.SSS")
                        let startDates = UtilsManager.shared.UTCDateFromString2(date: UtilsManager.shared.UTCDateFromString(date: self.txtStartDates.text!, format: "dd-MMM-yyyy"),format : "yyyy-MM-dd'T'HH:mm:ss.SSS")
                        let endDates = UtilsManager.shared.UTCDateFromString2(date: UtilsManager.shared.UTCDateFromString(date: self.txtEndDate.text!, format: "dd-MMM-yyyy"),format : "yyyy-MM-dd'T'HH:mm:ss.SSS")
                        
                        let addItem = addItemInfo(_id: self.editInfo == nil ? 0 : self.editInfo!._id, expenseReimbClaimAmount: Double(self.txtExpenseAmount.text!), documentIDs: formattedArray, expReimReqDate: nil, invoiceNo: self.txtInvoiceNo.text, invoiceDate: invoiceDate, tax: Float(self.txtTax.text!), taxAmount: Double(self.txtTaxAmountCal.text!), vendor: self.txtVendor.text, location: self.txtLocation.text, _description: self.txtDesc.text,expenseTypeId: !self.isProject ? self.selectedBusinessCategory?._id : self.selectedExpenseType?._id, expenseType: self.txtExpenseType.text, selectDocument: self.selectDocument, isDuplicate: false,expCategory: self.txtExpenseCategory.text,startDate: startDates,endDate: endDates,noDays: self.txtDays.text,taxNo: self.txtTaxNo.text,isVAT: self.isVatToggle.isOn, businessExpenseId: self.selectedBusinessExpense?._id, buinessCategoryName: self.selectedBusinessExpense?.expenseCategoryName,selectedVendorId: self.selectedVendor?._id ?? 0, selectedVendorOthers: self.txtOthersVendor.text)
                        self.delegate?.addItemsList(addItem,selectIndex: self.selectedIndex)
                        self.dismiss(animated: true, completion: nil)
                    }
                    
                }
                catch{
                    print("json error")
                }
                print(response)
            }
         case .failure(let encodingError):
                hideLoader()
              print(encodingError)
         }
       })

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

extension AddItemViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.selectDocument.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mediaCell", for: indexPath) as! MediaSelectionCell
        cell.contentView.backgroundColor = .clear
        cell.backgroundColor = .clear
        cell.lblFileName.text = self.selectDocument[indexPath.row].fileName
        cell.lblExtension.text = self.selectDocument[indexPath.row].fileExtension?.uppercased()
        cell.closeBtn.tag = indexPath.row
        cell.closeBtn.addTarget(self, action: #selector(removeSelectDocument(_:)), for: .touchUpInside)
        return cell
    }
    
    @objc func removeSelectDocument(_ sender : UIButton){
        self.selectDocument.remove(at: sender.tag)
        self.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    
}
extension AddItemViewController : UITextFieldDelegate,UITextViewDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtExpenseCategory{
            var projectTitle = [String]()
            for dropDown in self.expenseBusinessList{
                projectTitle.append(dropDown.expenseCategoryName ?? "")
            }
            
            let simpleArray: [String] = projectTitle
            var simpleSelectedArray: [String] = selectedBusinessExpense == nil ? [] : [selectedBusinessExpense?.expenseCategoryName ?? ""]
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
                for drop in self.expenseBusinessList{
                    if (drop.expenseCategoryName ?? "") == item!{
                        self.selectedBusinessExpense = drop
                        break
                    }
                }
                self.getBusinessCategoryDropdown(businessId: self.selectedBusinessExpense?._id ?? 0)
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
        if textField == txtExpenseType{
            if !self.isProject{
                var projectTitle = [String]()
                for dropDown in self.expenseBusinessCetegoryList{
                    projectTitle.append(dropDown.expenseTypeName ?? "")
                }

                let simpleArray: [String] = projectTitle
                var simpleSelectedArray: [String] = selectedBusinessCategory == nil ? [] : [selectedBusinessCategory?.expenseTypeName ?? ""]
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
                    for drop in self.expenseBusinessCetegoryList{
                        if (drop.expenseTypeName ?? "") == item!{
                            self.selectedBusinessCategory = drop
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
            else{
                var projectTitle = [String]()
                for dropDown in self.expenseTypeList{
                    projectTitle.append("\(dropDown.expenseTypeName!)")
                }
                
                let simpleArray: [String] = projectTitle
                var simpleSelectedArray: [String] = selectedExpenseType == nil ? [] : ["\(selectedExpenseType!.expenseTypeName!)"]
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
                    for drop in self.expenseTypeList{
                        if "\(drop.expenseTypeName!)" == item!{
                            self.selectedExpenseType = drop
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
            
        }
        if textField == txtVendor{
            var projectTitle = [String]()
            for dropDown in self.vendorList{
                projectTitle.append(dropDown.vendorName ?? "")
            }
            
            let simpleArray: [String] = projectTitle
            var simpleSelectedArray: [String] = selectedVendor == nil ? [] : [selectedVendor?.vendorName ?? ""]
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
                for drop in self.vendorList{
                    if (drop.vendorName ?? "") == item!{
                        self.selectedVendor = drop
                        if(item == "Other Vendors"){
                            self.vendorOthersView.isHidden = false
                        }
                        else{
                            self.vendorOthersView.isHidden = true
                        }
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
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == txtTax{
            if let taxTotal = self.txtExpenseAmount.text, taxTotal != "" && txtTax.text != "" {
                let amount = Double(self.txtExpenseAmount.text!) ?? 0.0
                let taxPercentage = Double(self.txtTax.text!) ?? 0.0
                self.txtTaxAmountCal.text = NSString.init(format: "%.2f", ((amount * taxPercentage) / 100)) as String
            }
            else{
                Loaf("Please enter total Expense Amount", state: .success, location: .top, sender: self).show(.short, completionHandler: nil)
            }
        }
        if textField == txtExpenseAmount{
            if let taxTotal = self.txtTax.text, taxTotal != "" && self.txtExpenseAmount.text != ""{
                let amount = Double(self.txtExpenseAmount.text!) ?? 0.0
                let taxPercentage = Double(self.txtTax.text!) ?? 0.0
                self.txtTaxAmountCal.text = NSString.init(format: "%.2f", ((amount * taxPercentage) / 100)) as String
            }
            else{
                self.txtTaxAmountCal.text = ""
            }
        }
        if let taxTotal = self.txtTax.text, taxTotal != "" && self.txtExpenseAmount.text != ""{
            let amount = Double(self.txtExpenseAmount.text ?? "0") ?? 0.0
            let taxPercentage = Double(self.txtTax.text ?? "0") ?? 0.0
            self.txtTaxAmountCal.text = NSString.init(format: "%.2f", ((amount * taxPercentage) / 100)) as String
        }
        else{
            self.txtTaxAmountCal.text = ""
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == txtInvoiceNo || textField == txtLocation || textField == txtTaxNo{
        guard let text = textField.text else { return true }
        let allowedCharacters = CharacterSet(charactersIn:"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 .-")//Here change this characters based on your requirement
        let characterSet = CharacterSet(charactersIn: string)
        
        let newLength = text.utf16.count + string.utf16.count - range.length
            
        return newLength <= 30 && allowedCharacters.isSuperset(of: characterSet)
        }
        
        if textField == txtTax {
        guard let text = textField.text else { return true }
        let allowedCharacters = CharacterSet(charactersIn:"0123456789.")//Here change this characters based on your requirement
        let characterSet = CharacterSet(charactersIn: string)
        
        let newLength = text.utf16.count + string.utf16.count - range.length
            
        return newLength <= 10 && allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
}

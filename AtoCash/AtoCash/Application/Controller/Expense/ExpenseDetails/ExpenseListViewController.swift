//
//  ExpenseListViewController.swift
//  AtoCash
//
//  Created by user on 22/04/21.
//

import UIKit

class ExpenseListViewController: UIViewController {
    
    //UI Localization
    
    @IBOutlet weak var tTotalAmount: UILabel!
    @IBOutlet weak var tExpenseType: UILabel!
    @IBOutlet weak var tExpenseTitle: UILabel!
    
    @IBOutlet weak var lblTotalAmount: UILabel!
    @IBOutlet weak var txtExpenseType: UILabel!
    @IBOutlet weak var lblExpenseTitle: UILabel!
    @IBOutlet weak var tblView: UITableView!
    var expenseRequestId : Int = 0
    var expenseData : ExpenseReimburseRequestDTO?
    var expenseSubClaimData = [ExpenseSubClaimDTO]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //Navigation Backbar button item
        let backBtn = UIBarButtonItem(image: UIImage.init(named: "back"), style: .plain, target: self, action: #selector(BackButtonTapped))
        backBtn.tintColor = .white
        self.title = NSLocalizedString("expense_details", comment: "")
        self.navigationItem.leftBarButtonItem = backBtn
        tblView.tableFooterView = UIView()
        tblView.register(UINib(nibName: "ExpenseClaimCell", bundle: nil), forCellReuseIdentifier: "expenseClaimCell")
    }
    
    private func setupUI(){
        self.viewUpdates()
        self.tTotalAmount.text = NSLocalizedString("total_amount", comment: "")
        self.tExpenseType.text = NSLocalizedString("expense_type", comment: "")
        self.tExpenseTitle.text = NSLocalizedString("expense_title", comment: "")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.islangauge(self.currentLanguage()) { return}
        self.viewUpdates()
        self.setupUI()
        getExpenseClaimStatus()
    }
    //BAckbutton Action
    @objc func BackButtonTapped(){
        //Pop to home view controller
        self.navigationController?.popViewController(animated: true)
    }
    
    private func getExpenseClaimStatus(){
        showLoader()
        //https://atocashdev.ml/api/ExpenseReimburseRequests/GetExpenseReimburseRequest/
        ExpenseReimburseRequestsAPI.apiExpenseReimburseRequestsGetExpenseReimburseRequestIdGet(_id: self.expenseRequestId) { (result, error) in
            hideLoader()
            if error == nil {
                self.expenseData = result
                DispatchQueue.main.async {
                    
                    self.lblExpenseTitle.text = self.expenseData!.expenseReportTitle ?? ""
                    self.lblTotalAmount.text = "\(self.expenseData!.totalClaimAmount ?? 0)"
                    if let project = self.expenseData?.project{
                        self.txtExpenseType.text = NSLocalizedString("proj", comment: "")
                    }
                    else if let dep = self.expenseData?.department{
                        self.txtExpenseType.text = NSLocalizedString("dept", comment: "")
                    }
                    else{
                        self.txtExpenseType.text = NSLocalizedString("business", comment: "")
                    }
                    
                    self.expenseSubClaims()
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
    
    private func expenseSubClaims(){
        showLoader()
        ExpenseSubClaimsAPI.apiExpenseSubClaimsGetExpenseSubClaimsByExpenseIdIdGet(_id: self.expenseRequestId, completion: { (result, error) in
            hideLoader()
            if error == nil {
                self.expenseSubClaimData = result ?? []
                DispatchQueue.main.async {
                    //self.lblExpenseTitle.text = self.expenseData!.
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension ExpenseListViewController: UITableViewDelegate,UITableViewDataSource,ExpenseClaimDelegate{
    func copyActionTag(_ sender: Int) {
        
    }
    
    func deleteActionTag(_ sender: Int) {
        
    }
    
    func editActionTag(_ sender: Int) {
        
    }
    
    func moreActionTag(_ sender: Int) {
        let claimRecord = self.expenseSubClaimData[sender]
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "ExpenseFileViewController") as! ExpenseFileViewController
        vc.detailClaimData = claimRecord
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.expenseSubClaimData.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "expenseClaimCell") as! ExpenseClaimCell
        cell.moreInfoBtn.isHidden = false
        cell.moreInfoBtn.tag = indexPath.row
        cell.editDeleteView.isHidden = true
        cell.viewHeightConstraint.constant = 0
        cell.tInvoiceDate.text = NSLocalizedString("invoice_date", comment: "")
        cell.tClaimAmount.text = NSLocalizedString("claim_amount", comment: "")
        cell.moreInfoBtn.setTitle(NSLocalizedString("moreinfo", comment: ""), for: .normal)
        let claims = self.expenseSubClaimData[indexPath.row]
            let selectDoc = (claims.documentIDs ?? "").components(separatedBy: ",")
        let docsString = selectDoc.count > 1 ? NSLocalizedString("documents_attach", comment: "") : NSLocalizedString("document_attach", comment: "")
            cell.attchmentFiles.text = "\(selectDoc.count ) \(docsString)"
            cell.lblInvoiceNo.text = " " + claims.invoiceNo! + " "
            cell.lblDesc.text = claims._description
            let total = (claims.expenseReimbClaimAmount ?? 0.0) + (claims.taxAmount ?? 0.0)
            cell.lblClaimAmount.text = String(format: "%.2f", total)
            cell.lblInvoiceDate.text = UtilsManager.shared.systemDateStringFromUTC(utcDate: UtilsManager.shared.systemDatetoString(claims.invoiceDate!),formatOf: "dd MMM yyyy")
            cell.deleteBtn.tag = indexPath.row
            cell.editBtn.tag = indexPath.row
            cell.copyBtn.tag = indexPath.row
        cell.claimDelegate = self
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
    }
}

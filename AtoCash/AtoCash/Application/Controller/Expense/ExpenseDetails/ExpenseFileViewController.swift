//
//  ExpenseFileViewController.swift
//  AtoCash
//
//  Created by user on 23/04/21.
//

import UIKit
import WebKit
import QuickLook
class ExpenseFileViewController: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    var detailClaimData : ExpenseSubClaimDTO?
    var documentsList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //Navigation Backbar button item
        let backBtn = UIBarButtonItem(image: UIImage.init(named: "back"), style: .plain, target: self, action: #selector(BackButtonTapped))
        backBtn.tintColor = .white
        //self.title = "Expense Sub Claim Details"
        self.navigationItem.leftBarButtonItem = backBtn
        
        tblView.tableFooterView = UIView()
        tblView.register(UINib(nibName: "ExpenseDetailCell", bundle: nil), forCellReuseIdentifier: "expenseDetailCell")
        tblView.register(UINib(nibName: "ExpenseDocumentCell", bundle: nil), forCellReuseIdentifier: "expenseDocumentCell")
        
    }
    
    func setupUI(){
        self.title = NSLocalizedString("expense_subclaim_title", comment: "")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.islangauge(self.currentLanguage()){ return}
        self.viewUpdates()
        self.setupUI()
        self.getDocumentsArray()
    }
    //BAckbutton Action
    @objc func BackButtonTapped(){
        //Pop to home view controller
        self.navigationController?.popViewController(animated: true)
    }
    
    private func getDocumentsArray(){
        showLoader()
        ExpenseReimburseRequestsAPI.apiExpenseReimburseRequestsGetDocumentsBySubClaimsIdIdGet(_id: self.detailClaimData!._id!) { (result, error) in
            hideLoader()
            if error == nil {
                self.documentsList = result ?? []
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension ExpenseFileViewController : UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1{
            return self.documentsList.count
        }
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00001
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50))
        let label = UILabel(frame: CGRect(x: 10, y: 5, width: tableView.frame.size.width - 40, height: 40))
        if section == 0{
            label.text = NSLocalizedString("expense_details", comment: "")
        }
        else{
            label.text = NSLocalizedString("document_list", comment: "")
        }
        headerView.addSubview(label)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "expenseDetailCell") as! ExpenseDetailCell
            
            cell.tInvoiceNo.text = NSLocalizedString("invoice_no", comment: "")
            cell.tInvoiceDate.text = NSLocalizedString("invoice_dt", comment: "")
            cell.tExpenseType.text = NSLocalizedString("expense_ty", comment: "")
            cell.tVendor.text = NSLocalizedString("vendor", comment: "")
            cell.tTax.text = NSLocalizedString("tax", comment: "")
            cell.tTaxAmount.text = NSLocalizedString("tax_amount", comment: "")
            cell.tEsxpenseAmount.text = NSLocalizedString("expense_amount", comment: "")
            cell.tDescription.text = NSLocalizedString("description", comment: "")
            cell.tLocation.text = NSLocalizedString("location", comment: "")
            
            cell.lblInvoiceNo.text = self.detailClaimData?.invoiceNo ?? ""
            cell.lblInvoiceDate.text =  UtilsManager.shared.systemDateStringFromUTC(utcDate: UtilsManager.shared.systemDatetoString(self.detailClaimData!.invoiceDate!),formatOf: "dd MMM yyyy")
            cell.lblExpenseType.text = self.detailClaimData?.expenseType ?? ""
            cell.lblVendor.text = self.detailClaimData?.vendor ?? ""
            cell.lblExpenseAmount.text = "\(self.detailClaimData?.expenseReimbClaimAmount ?? 0)"
            cell.lblTax.text = "\(self.detailClaimData?.tax ?? 0)"
            cell.lblTaxAmount.text = "\(self.detailClaimData?.taxAmount ?? 0)"
            cell.lblDesc.text = self.detailClaimData?._description ?? ""
            cell.lblLocation.text = self.detailClaimData?.location ?? ""
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "expenseDocumentCell") as! ExpenseDocumentCell
            cell.lblDocumentName.text = (self.documentsList[indexPath.row]).components(separatedBy: "/").last
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 1 {
            let vc = mainStoryboard.instantiateViewController(withIdentifier: "DocumentViewController") as! DocumentViewController
            vc.isImage = ((self.documentsList[indexPath.row].components(separatedBy: "/").last?.components(separatedBy: ".").last?.lowercased() == "jpg") || (self.documentsList[indexPath.row].components(separatedBy: "/").last?.components(separatedBy: ".").last?.lowercased() == "png")) ? true : false
            vc.chatURL = BASEURL + self.documentsList[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }

    }
    
    
    
}

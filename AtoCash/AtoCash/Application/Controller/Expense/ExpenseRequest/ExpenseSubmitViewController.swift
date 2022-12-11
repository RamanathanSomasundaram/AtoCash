//
//  ExpenseSubmitViewController.swift
//  AtoCash
//
//  Created by user on 24/04/21.
//

import UIKit
protocol ExpenseSubmitDelegate : NSObjectProtocol {
    func submitExpense()
}
class ExpenseSubmitViewController: UIViewController {

    @IBOutlet weak var tChargeLbl: UILabel!
    
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var tAlertText: UILabel!
    @IBOutlet weak var tSubClaims: UILabel!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var lblCharge: UILabel!
   // var tblView : UITableView!
    weak var delegate : ExpenseSubmitDelegate?
    var itemsList : [addItemInfo]?
    var totalAmount : String?
    var charge : String?
    //@IBOutlet weak var submitListTableview: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.lblCharge.text = self.charge
        tblView.register(UINib(nibName: "ExpenseSubmitCell", bundle: nil), forCellReuseIdentifier: "expenseSubmitCell")
        tblView.tableFooterView = UIView()
        self.tblView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tblView.reloadData()
    }
    
    @IBAction func cloasAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submitAction(_ sender: Any) {
        self.delegate?.submitExpense()
        self.dismiss(animated: true, completion: nil)
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
extension ExpenseSubmitViewController : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = self.itemsList?.count{
            return count + 1
        }
        return [].count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "expenseSubmitCell") as! ExpenseSubmitCell
        if ((self.itemsList?.count ?? [].count)) == indexPath.row {
            cell.lblTitle.text = NSLocalizedString("total_amount", comment: "")
            cell.lblAmount.text = self.totalAmount
        }
        else{
            let result = self.itemsList![indexPath.row]
            cell.lblTitle.text = result.expenseType
            //cell.lblAmount.text = "\((result.expenseReimbClaimAmount ?? 0.0) + (result.taxAmount ?? 0.0))"
            cell.lblAmount.text = "\(result.expenseReimbClaimAmount ?? 0.0)"
        }
        //cell.backgroundColor = UIColor.yellow
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

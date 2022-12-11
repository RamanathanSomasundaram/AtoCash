//
//  ExpenseDetailCell.swift
//  AtoCash
//
//  Created by user on 22/04/21.
//

import UIKit

class ExpenseDetailCell: UITableViewCell {

    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblVendor: UILabel!
    @IBOutlet weak var lblTaxAmount: UILabel!
    @IBOutlet weak var lblTax: UILabel!
    @IBOutlet weak var lblExpenseAmount: UILabel!
    @IBOutlet weak var lblExpenseType: UILabel!
    @IBOutlet weak var lblInvoiceDate: UILabel!
    @IBOutlet weak var lblInvoiceNo: UILabel!
    
    //UI Localization
    @IBOutlet weak var tInvoiceNo: UILabel!
    @IBOutlet weak var tDescription: UILabel!
    @IBOutlet weak var tVendor: UILabel!
    @IBOutlet weak var tLocation: UILabel!
    @IBOutlet weak var tTaxAmount: UILabel!
    @IBOutlet weak var tTax: UILabel!
    @IBOutlet weak var tEsxpenseAmount: UILabel!
    @IBOutlet weak var tExpenseType: UILabel!
    @IBOutlet weak var tInvoiceDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblDesc.textAlignment = .defaultAlignment
        lblLocation.textAlignment = .defaultAlignment
        lblVendor.textAlignment = .defaultAlignment
        lblTaxAmount.textAlignment = .defaultAlignment
        lblTax.textAlignment = .defaultAlignment
        lblExpenseAmount.textAlignment = .defaultAlignment
        lblExpenseType.textAlignment = .defaultAlignment
        lblInvoiceDate.textAlignment = .defaultAlignment
        lblInvoiceNo.textAlignment = .defaultAlignment
        tInvoiceNo.textAlignment = .defaultAlignment
        tDescription.textAlignment = .defaultAlignment
        tVendor.textAlignment = .defaultAlignment
        tLocation.textAlignment = .defaultAlignment
        tTaxAmount.textAlignment = .defaultAlignment
        tTax.textAlignment = .defaultAlignment
        tEsxpenseAmount.textAlignment = .defaultAlignment
        tExpenseType.textAlignment = .defaultAlignment
        tInvoiceDate.textAlignment = .defaultAlignment
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

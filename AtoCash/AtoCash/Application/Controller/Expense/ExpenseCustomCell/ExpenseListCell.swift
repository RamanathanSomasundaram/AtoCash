//
//  ExpenseListCell.swift
//  AtoCash
//
//  Created by user on 20/04/21.
//

import UIKit


protocol expenseListDelegate : NSObjectProtocol {
    func deleteActionTag(_ sender : Int)
    func editActionTag(_ sender : Int)
    func viewActionTag(_ sender : Int)
    func viewDetailsExpense(_ sender : Int)
}

class ExpenseListCell: UITableViewCell {

    @IBOutlet weak var tCurrentStatus: UILabel!
    @IBOutlet weak var ttotalAmount: UILabel!
    @IBOutlet weak var viewEye: UIButton!
    @IBOutlet weak var trackBtn: UIButton!
    @IBOutlet weak var editVIewHeight: NSLayoutConstraint!
    @IBOutlet weak var editDeleteView: UIStackView!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblClaimAmount: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblLink: UILabel!
    @IBOutlet weak var lblExpenseTitle: UILabel!
    
    weak var explistDelegate : expenseListDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tCurrentStatus.textAlignment = .defaultAlignment
        ttotalAmount.textAlignment = .defaultAlignment
        viewEye.titleLabel?.textAlignment = .defaultAlignment
        trackBtn.titleLabel?.textAlignment = .defaultAlignment
        deleteBtn.titleLabel?.textAlignment = .defaultAlignment
        editBtn.titleLabel?.textAlignment = .defaultAlignment
        lblDesc.textAlignment = .defaultAlignment
        lblClaimAmount.textAlignment = .defaultAlignment
        lblStatus.textAlignment = .defaultAlignment
        lblLink.textAlignment = .defaultAlignment
        lblExpenseTitle.textAlignment = .defaultAlignment
        
    }

    @IBAction func viewExpenseAction(_ sender: UIButton) {
        if explistDelegate != nil {
            self.explistDelegate?.viewDetailsExpense(sender.tag)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func trackAction(_ sender: UIButton) {
        if explistDelegate != nil {
            self.explistDelegate?.viewActionTag(sender.tag)
        }
    }
    @IBAction func deleteAction(_ sender: UIButton) {
        if explistDelegate != nil {
            self.explistDelegate?.deleteActionTag(sender.tag)
        }
    }
    
    @IBAction func editAction(_ sender: UIButton) {
        if explistDelegate != nil {
            self.explistDelegate?.editActionTag(sender.tag)
        }
    }
    
}

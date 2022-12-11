//
//  ExpenseClaimCell.swift
//  AtoCash
//
//  Created by user on 20/04/21.
//

import UIKit


protocol ExpenseClaimDelegate : NSObjectProtocol {
    func copyActionTag(_ sender : Int)
    func deleteActionTag(_ sender : Int)
    func editActionTag(_ sender : Int)
    func moreActionTag(_ sender : Int)
}

class ExpenseClaimCell: UITableViewCell {
    @IBOutlet weak var tDocuments: UILabel!
    @IBOutlet weak var tClaimAmount: UILabel!
    @IBOutlet weak var tInvoiceDate: UILabel!
    @IBOutlet weak var statusIcon: UIImageView!
    @IBOutlet weak var baseView: CSCustomViewCell!
    @IBOutlet weak var moreInfoBtn: UIButton!
    @IBOutlet weak var editDeleteView: UIStackView!
    @IBOutlet weak var copyBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var lblClaimAmount: UILabel!
    @IBOutlet weak var lblInvoiceDate: UILabel!
    @IBOutlet weak var attchmentFiles: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblInvoiceNo: UILabel!
    
    @IBOutlet weak var viewHeightConstraint: NSLayoutConstraint!
    weak var claimDelegate : ExpenseClaimDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tDocuments.textAlignment = .defaultAlignment
        tClaimAmount.textAlignment = .defaultAlignment
        tInvoiceDate.textAlignment = .defaultAlignment
        moreInfoBtn.titleLabel?.textAlignment = .defaultAlignment
        copyBtn.titleLabel?.textAlignment = .defaultAlignment
        deleteBtn.titleLabel?.textAlignment = .defaultAlignment
        editBtn.titleLabel?.textAlignment = .defaultAlignment
        lblClaimAmount.textAlignment = .defaultAlignment
        lblInvoiceDate.textAlignment = .defaultAlignment
        attchmentFiles.textAlignment = .defaultAlignment
        lblDesc.textAlignment = .defaultAlignment
        lblInvoiceNo.textAlignment = .defaultAlignment
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func deleteAction(_ sender: UIButton) {
        if self.claimDelegate != nil {
            self.claimDelegate?.deleteActionTag(sender.tag)
        }
    }
    @IBAction func copyAction(_ sender: UIButton) {
        if self.claimDelegate != nil {
            self.claimDelegate?.copyActionTag(sender.tag)
        }
    }
    @IBAction func editAction(_ sender: UIButton) {
        if self.claimDelegate != nil {
            self.claimDelegate?.editActionTag(sender.tag)
        }
    }
    @IBAction func moreAction(_ sender: UIButton) {
        if self.claimDelegate != nil {
            self.claimDelegate?.moreActionTag(sender.tag)
        }
    }
    
}

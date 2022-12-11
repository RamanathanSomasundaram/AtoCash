//
//  MyInboxCell.swift
//  AtoCash
//
//  Created by user on 19/03/21.
//

import UIKit
protocol myInboxDetailDelegate : NSObjectProtocol {
    func acceptTagAction(_ sender : Int)
    func rejectTagAction(_ sender : Int)
    func deleteTagAction(_ sender : Int)
    func eyeTagAction(_ sender : Int)
    
}
class MyInboxCell: UITableViewCell {

    @IBOutlet weak var eyeBtn: UIButton!
    @IBOutlet weak var stackHeight: NSLayoutConstraint!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var rejectBtn: UIButton!
    @IBOutlet weak var approveBtn: UIButton!
    @IBOutlet weak var amountStackView: UIStackView!
    @IBOutlet weak var lblReqAmount: UILabel!
    @IBOutlet weak var lblReqDate: UILabel!
    @IBOutlet weak var lblEmpName: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    weak var inboxDelegate : myInboxDetailDelegate?
    
    @IBOutlet weak var ytRequestDate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        deleteBtn.titleLabel?.textAlignment = .defaultAlignment
        rejectBtn.titleLabel?.textAlignment = .defaultAlignment
        approveBtn.titleLabel?.textAlignment = .defaultAlignment
        lblReqAmount.textAlignment = .defaultAlignment
        lblReqDate.textAlignment = .defaultAlignment
        lblEmpName.textAlignment = .defaultAlignment
        lblTitle.textAlignment = .defaultAlignment
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func eyeAction(_ sender: UIButton) {
        if inboxDelegate != nil {
            self.inboxDelegate?.eyeTagAction(sender.tag)
        }
    }
    @IBAction func rejectAction(_ sender: UIButton) {
        if inboxDelegate != nil {
            self.inboxDelegate?.rejectTagAction(sender.tag)
        }
    }
    @IBAction func approveAction(_ sender: UIButton) {
        if inboxDelegate != nil {
            self.inboxDelegate?.acceptTagAction(sender.tag)
        }
    }
    @IBAction func deleteAction(_ sender: UIButton) {
        if inboxDelegate != nil {
            self.inboxDelegate?.deleteTagAction(sender.tag)
        }
    }
}

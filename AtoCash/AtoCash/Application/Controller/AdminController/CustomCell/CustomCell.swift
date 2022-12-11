//
//  CustomCell.swift
//  AtoCash
//
//  Created by user on 13/03/21.
//

import UIKit

protocol customCellButtonActionDelegate : NSObjectProtocol {
    func editActionTag(_ sender : Int)
    func deleteActionTag (_ sender : Int)
}

class CustomCell: UITableViewCell {

    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var lblDetailDesc: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var lblProductId: UILabel!
    @IBOutlet weak var statusIcon: UIView!
    
    weak var customActionDelegate : customCellButtonActionDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.statusIcon.layer.cornerRadius = 7.5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func deleteAction(_ sender: UIButton) {
        if customActionDelegate != nil {
            self.customActionDelegate?.deleteActionTag(sender.tag)
        }
    }
    @IBAction func editAction(_ sender: UIButton) {
        if customActionDelegate != nil {
            self.customActionDelegate?.editActionTag(sender.tag)
        }
        
    }
}

//
//  CustomCellDropDown.swift
//  AtoCash
//
//  Created by user on 14/03/21.
//

import UIKit

protocol customCellDropdownDelegate : NSObjectProtocol {
    func editActionTag(_ sender : Int)
    func deleteActionTag(_ sender : Int)
}

class CustomCellDropDown: UITableViewCell {

    @IBOutlet weak var linkIcon: UIImageView!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var lblSelectDescDetail: UILabel!
    @IBOutlet weak var lblDescDetail: UILabel!
    @IBOutlet weak var lblProductId: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var statusIcon: UIView!
    
    weak var customDropDownDelegate : customCellDropdownDelegate?
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
        if customDropDownDelegate != nil {
            self.customDropDownDelegate?.deleteActionTag(sender.tag)
        }
    }
    @IBAction func editAction(_ sender: UIButton) {
        if customDropDownDelegate != nil {
            self.customDropDownDelegate?.editActionTag(sender.tag)
        }
    }
}

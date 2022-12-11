//
//  AdminCell.swift
//  AtoCash
//
//  Created by user on 14/03/21.
//

import UIKit

protocol adminCellDelegate : NSObjectProtocol {
    func editActionTag(_ sender : Int)
    func deleteActionTag(_ sender : Int)
}

class AdminCell: UITableViewCell {

    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var userIcon: UIImageView!
    weak var adminDelegate : adminCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func deleteAction(_ sender: UIButton) {
        if adminDelegate != nil {
            self.adminDelegate?.deleteActionTag(sender.tag)
        }
    }
    @IBAction func editAction(_ sender: UIButton) {
        if adminDelegate != nil {
            self.adminDelegate?.editActionTag(sender.tag)
        }
    }
}

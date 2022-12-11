//
//  TrackCell.swift
//  AtoCash
//
//  Created by user on 18/04/21.
//

import UIKit


enum trackImageName : String {
    case pending = "pending"
    case approval = "approveAccept"
    case reject = "ApproveReject"
    case initative = "Initial"
}

class TrackCell: UITableViewCell {

    @IBOutlet weak var lblLine: UILabel!
    @IBOutlet weak var lblApprovalName: UILabel!
    @IBOutlet weak var lblRoleName: UILabel!
    @IBOutlet weak var statusIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblApprovalName.textAlignment = .defaultAlignment
        lblRoleName.textAlignment = .defaultAlignment
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

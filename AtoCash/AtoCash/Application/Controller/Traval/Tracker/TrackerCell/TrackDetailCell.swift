//
//  TrackDetailCell.swift
//  AtoCash
//
//  Created by user on 18/04/21.
//

import UIKit

class TrackDetailCell: UITableViewCell {
    @IBOutlet weak var stackHeight: NSLayoutConstraint!
    
    @IBOutlet weak var requestStactHeight: NSLayoutConstraint!
    @IBOutlet weak var lblRequestAmount: UILabel!
    @IBOutlet weak var lblRequestId: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var lbltitle: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblDept: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblEnddate: UILabel!
    @IBOutlet weak var lblStartDate: UILabel!
    @IBOutlet weak var lblEmpName: UILabel!
    
    @IBOutlet weak var tTrackTitle: UILabel!
    
    @IBOutlet weak var tRequestDate: UILabel!
    @IBOutlet weak var tRequestId: UILabel!
    @IBOutlet weak var tEndDate: UILabel!
    @IBOutlet weak var tStartDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        tStartDate.textAlignment = .defaultAlignment
    lblRequestAmount.textAlignment = .defaultAlignment
    lblRequestId.textAlignment = .defaultAlignment
    lbltitle.textAlignment = .defaultAlignment
    lblStatus.textAlignment = .defaultAlignment
    lblDept.textAlignment = .defaultAlignment
    lblDesc.textAlignment = .defaultAlignment
    lblEnddate.textAlignment = .defaultAlignment
    lblStartDate.textAlignment = .defaultAlignment
    lblEmpName.textAlignment = .defaultAlignment
    tTrackTitle.textAlignment = .defaultAlignment
    tRequestDate.textAlignment = .defaultAlignment
    tRequestId.textAlignment = .defaultAlignment
    tEndDate.textAlignment = .defaultAlignment
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

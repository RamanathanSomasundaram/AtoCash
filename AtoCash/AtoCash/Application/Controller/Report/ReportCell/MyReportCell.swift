//
//  MyReportCell.swift
//  AtoCash
//
//  Created by user on 05/05/21.
//

import UIKit
protocol myReportDelegate : NSObjectProtocol {
    func moreTagAction(_ sender : Int)
    func eyeTagAction(_ sender : Int)
    
}
class MyReportCell: UITableViewCell {

    @IBOutlet weak var moreBtn: UIButton!
    @IBOutlet weak var lblEndDate: UILabel!
    @IBOutlet weak var lblStartDate: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblReqId: UILabel!
    @IBOutlet weak var lblReqDate: UILabel!
    @IBOutlet weak var endDateView: UIStackView!
    @IBOutlet weak var startDateView: UIStackView!
    @IBOutlet weak var eyeBtn: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tEndDate: UILabel!
    @IBOutlet weak var tStartDate: UILabel!
    @IBOutlet weak var tStatusType: UILabel!
    @IBOutlet weak var tRequestDate: UILabel!
    @IBOutlet weak var tRequestID: UILabel!
    weak var reportDelegate : myReportDelegate?
    @IBOutlet weak var lblName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        moreBtn.titleLabel?.textAlignment = .defaultAlignment
        lblEndDate.textAlignment = .defaultAlignment
        lblStartDate.textAlignment = .defaultAlignment
        lblStatus.textAlignment = .defaultAlignment
        lblReqId.textAlignment = .defaultAlignment
        eyeBtn.titleLabel?.textAlignment = .defaultAlignment
        lblTitle.textAlignment = .defaultAlignment
        tEndDate.textAlignment = .defaultAlignment
        tStartDate.textAlignment = .defaultAlignment
        tStatusType.textAlignment = .defaultAlignment
        tRequestID.textAlignment = .defaultAlignment
        tRequestDate.textAlignment = .defaultAlignment
        lblName.textAlignment = .defaultAlignment
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func moreAction(_ sender: UIButton) {
        if reportDelegate != nil {
            self.reportDelegate?.moreTagAction(sender.tag)
        }
    }
    @IBAction func eyeAction(_ sender: UIButton) {
        if reportDelegate != nil {
            self.reportDelegate?.eyeTagAction(sender.tag)
        }
    }
}

//
//  MyRequestCell.swift
//  AtoCash
//
//  Created by user on 19/03/21.
//

import UIKit

protocol myRequestDetailDelegate : NSObjectProtocol {
    func viewDetailsTagAction(_ sender : Int)
    func editDetailsTagAction(_ sender : Int)
    func deleteDetailsTagAction(_ sender : Int)
}

class MyRequestCell: UITableViewCell {

    @IBOutlet weak var deleteAction: UIButton!
    @IBOutlet weak var editBtnAction: UIButton!
    @IBOutlet weak var editDeleteView: UIStackView!
    @IBOutlet weak var linkStatus: UILabel!
    @IBOutlet weak var linkIcon: UIImageView!
    @IBOutlet weak var lblCurrency: UILabel!
    @IBOutlet weak var viewDetailBtn: UIButton!
    @IBOutlet weak var lblReqDate: UILabel!
    @IBOutlet weak var lblReqAmount: UILabel!
    @IBOutlet weak var lblReqName: UILabel!
    weak var requestDelegate : myRequestDetailDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.viewDetailBtn.setTitle(NSLocalizedString("track_status", comment: ""), for: .normal)
        deleteAction.titleLabel?.textAlignment = .defaultAlignment
    editBtnAction.titleLabel?.textAlignment = .defaultAlignment
        linkStatus.textAlignment = .defaultAlignment
    lblCurrency.textAlignment = .defaultAlignment
        viewDetailBtn.titleLabel?.textAlignment = .defaultAlignment
    lblReqDate.textAlignment = .defaultAlignment
    lblReqAmount.textAlignment = .defaultAlignment
    lblReqName.textAlignment = .defaultAlignment
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func deleteBtnAction(_ sender: UIButton) {
        if requestDelegate != nil {
            self.requestDelegate?.deleteDetailsTagAction(sender.tag)
        }
    }
    @IBAction func editBtnAction(_ sender: UIButton) {
        if requestDelegate != nil {
            self.requestDelegate?.editDetailsTagAction(sender.tag)
        }
    }
    @IBAction func viewDetailAction(_ sender: UIButton) {
        if requestDelegate != nil{
            self.requestDelegate?.viewDetailsTagAction(sender.tag)
        }
    }
}

//
//  ExpenseDocumentCell.swift
//  AtoCash
//
//  Created by user on 23/04/21.
//

import UIKit

class ExpenseDocumentCell: UITableViewCell {

    @IBOutlet weak var lblDocumentName: UILabel!
    @IBOutlet weak var documentIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.lblDocumentName.textAlignment = .defaultAlignment
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

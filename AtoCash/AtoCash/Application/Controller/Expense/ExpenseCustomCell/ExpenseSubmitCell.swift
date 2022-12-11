//
//  ExpenseSubmitCell.swift
//  AtoCash
//
//  Created by User on 26/07/21.
//

import UIKit

class ExpenseSubmitCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.lblTitle.textAlignment = .defaultAlignment
        self.lblAmount.textAlignment = .defaultAlignment
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

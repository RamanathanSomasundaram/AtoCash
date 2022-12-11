//
//  SubCell.swift
//  expandable list
//
//  Created by user on 11/03/21.
//

import UIKit

class SubCell: UITableViewCell {
    
    @IBOutlet weak var leftImg: UIImageView!
    @IBOutlet weak var subHeader: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        self.subHeader.textAlignment = .defaultAlignment
    }
}

//
//  HeaderCell.swift
//  expandable list
//
//  Created by user on 11/03/21.
//

import UIKit

class HeaderCell: UITableViewCell {

    @IBOutlet weak var rightImg: UIImageView!
    @IBOutlet weak var leftImg: UIImageView!
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var selectionButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        header.textAlignment = .defaultAlignment
    }
    
}

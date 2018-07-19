//
//  MyTableCell.swift
//  MapSample
//
//  Created by Neil Smyth on 10/9/16.
//  Copyright © 2016 eBookFrenzy. All rights reserved.
//

import UIKit

class MyTableCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

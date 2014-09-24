//
//  DropDownTableViewCell.swift
//  pleY Guide
//
//  Created by Sahil Arora on 9/23/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

import UIKit

class DropDownTableViewCell: UITableViewCell {

    @IBOutlet weak var filterName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

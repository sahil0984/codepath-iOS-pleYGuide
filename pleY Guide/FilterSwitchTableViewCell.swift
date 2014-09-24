//
//  FilterSwitchTableViewCell.swift
//  pleY Guide
//
//  Created by Sahil Arora on 9/22/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

import UIKit

protocol FilterSwitchCellDelegate {
    func filterSwitchCell(filterSwitchCell: FilterSwitchTableViewCell, didChangeValue value: Bool) -> Void
}

class FilterSwitchTableViewCell: UITableViewCell {

    @IBOutlet weak var filterName: UILabel!
    @IBOutlet weak var filterIsOn: UISwitch!
    var delegate: FilterSwitchCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func onSwitchValueChanged(sender: AnyObject) {
        println("value changed")
        delegate?.filterSwitchCell(self, didChangeValue: filterIsOn.on)
    }
    

}

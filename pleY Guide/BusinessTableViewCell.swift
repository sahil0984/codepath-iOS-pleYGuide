//
//  BusinessTableViewCell.swift
//  pleY Guide
//
//  Created by Sahil Arora on 9/18/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

import UIKit

class BusinessTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var businessImageView: UIImageView!
    @IBOutlet weak var reviewCountLabel: UILabel!
    
    @IBOutlet weak var distanceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setBusinessCell (b : Business) {
        self.nameLabel.text = b.name
        self.addressLabel.text = b.address
        
        //let nf = NSNumberFormatter()
        //nf.numberStyle = .DecimalStyle
        //self.ratingLabel.text = nf.stringFromNumber(b.rating)
        
        //thumbnailImageURL
        if b.thumbnailImageURL != nil {
            businessImageView.setImageWithURL(NSURL(string: b.thumbnailImageURL!))
        }
        
        
        
        self.ratingImageView.setImageWithURL(NSURL(string: b.ratingURL!))
        
        self.reviewCountLabel.text = "\(b.reviewCount!)"

        var categoriesString = ","
        for cat in b.categories {
            categoriesString =  categoriesString + ", " + cat
        }
        self.categoriesLabel.text = categoriesString.stringByReplacingOccurrencesOfString(",, ", withString: "")
        
    }

}
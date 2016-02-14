//
//  BusinessCell.swift
//  Yelp
//
//  Created by Edwin M. Rivera on 2/13/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessCell: UITableViewCell {

    var business: Business!{
        didSet {
            nameLabel.text = business.name
            thumbView.setImageWithURL(business.imageURL!)
            tagsLabel.text = business.categories
            addressLabel.text = business.address
            reviewsLabel.text = "\(business.reviewCount!) Reviews"
            ratingView.setImageWithURL(business.ratingImageURL!)
            distanceLabel.text = business.distance
            
        }
    }
    
    
    
   
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var reviewsLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingView: UIImageView!
    @IBOutlet weak var thumbView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        thumbView.layer.cornerRadius = 10
        thumbView.clipsToBounds = true
        
        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

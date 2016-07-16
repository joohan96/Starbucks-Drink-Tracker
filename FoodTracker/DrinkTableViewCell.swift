//
//  DrinkTableViewCell.swift
//  StarbucksDrinkTracker
//
//  Created by Joohan Oh on 2016-03-01.
//  Copyright © 2016 Joohan Oh. All rights reserved.
//

import UIKit

class DrinkTableViewCell: UITableViewCell {
    
    //Mark: Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

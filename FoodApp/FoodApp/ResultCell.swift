//
//  ResultCell.swift
//  FoodApp
//
//  Created by Michael Rojas on 8/6/18.
//  Copyright © 2018 Michael Rojas. All rights reserved.
//

import UIKit

class ResultCell: UITableViewCell {
    @IBOutlet var title: UILabel!
    @IBOutlet var transportationTime: UILabel!
    @IBOutlet var distance: UILabel!
    @IBOutlet var textView: UITextView!
    @IBOutlet var imageHint: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

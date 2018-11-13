//
//  LabelAndImageTableViewCell.swift
//  FoodApp
//
//  Created by Michael Rojas on 11/12/18.
//  Copyright © 2018 Michael Rojas. All rights reserved.
//

import UIKit

class LabelAndImageTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageVIew: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageVIew.backgroundColor = .gray
        self.imageVIew.layer.masksToBounds = false
        self.imageVIew.layer.cornerRadius = self.imageVIew.frame.height / 2
        self.imageVIew.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

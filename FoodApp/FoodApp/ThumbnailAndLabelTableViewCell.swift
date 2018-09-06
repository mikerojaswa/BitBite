//
//  ThumbnailAndLabelTableViewCell.swift
//  FoodApp
//
//  Created by Michael Rojas on 8/4/18.
//  Copyright © 2018 Michael Rojas. All rights reserved.
//

import UIKit

protocol URLRepresentable  {
    var url: String { get set }
}

protocol TextRepresentable {
    var text: String { get set }
}

class ThumbnailAndLabelTableViewCell: UITableViewCell {
    
    @IBOutlet private var thumbnailImage: UIImageView!
    @IBOutlet public var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        thumbnailImage.layer.masksToBounds = false
        thumbnailImage.layer.cornerRadius = thumbnailImage.frame.size.width/2
        thumbnailImage.clipsToBounds = true
        titleLabel.layer.shadowColor = UIColor.black.cgColor
        titleLabel.layer.shadowOffset = CGSize(width: 0, height: 1)
        titleLabel.layer.shadowOpacity = 1
        titleLabel.layer.shadowRadius = 1.0
        titleLabel.clipsToBounds = false
    }
    

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.textColor = .black
    }
}

extension ThumbnailAndLabelTableViewCell: DataBindable {
    typealias DataType = URLRepresentable & TextRepresentable
    func bind(model: DataType) {
        thumbnailImage.downloadedFrom(link: model.url)
        titleLabel.text = model.text
    }
}

protocol DataBindable {
    associatedtype DataType
    func bind(model: DataType)
}


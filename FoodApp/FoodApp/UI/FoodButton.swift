//
//  FoodButton.swift
//  FoodApp
//
//  Created by Michael Rojas on 12/24/17.
//  Copyright © 2017 Michael Rojas. All rights reserved.
//

import UIKit

@IBDesignable
class FoodButton: UIButton {
    @IBInspectable override var backgroundColor: UIColor? {
        didSet {
            layer.backgroundColor = backgroundColor?.cgColor
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 10.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
}


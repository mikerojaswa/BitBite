//
//  CustomTableView.swift
//  FoodApp
//
//  Created by Michael Rojas on 8/4/18.
//  Copyright © 2018 Michael Rojas. All rights reserved.
//

import UIKit
class CustomTableView: UITableView {
    override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners([.topLeft, .topRight], radius: 10)
    }
}

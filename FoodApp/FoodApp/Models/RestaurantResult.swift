//
//  RestaurantResult.swift
//  FoodApp
//
//  Created by Michael Rojas on 8/4/18.
//  Copyright © 2018 Michael Rojas. All rights reserved.
//

import Foundation

struct RestaurantResult {
    var text: String
    var url: String = ""
    var coordinates: Coordinates
    var isClosed: Bool
    let categories: [Categories]
    
    init(text: String, url: String?, coordinates: Coordinates, isClosed: Bool, categories: [Categories]) {
        self.text = text
        self.coordinates = coordinates
        self.isClosed = isClosed
        self.categories = categories
        guard let urlString = url else { return }
        self.url = urlString
    }
}

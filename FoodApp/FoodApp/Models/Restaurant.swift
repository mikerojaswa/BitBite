//
//  Restaurant.swift
//  BitBite
//
//  Created by Michael Rojas on 12/16/17.
//  Copyright © 2017 Michael Rojas. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

struct Restaurant: Decodable {
    let coordinates: Coordinates
    let name: String
    let url: String
    let image_url: String
    let is_closed: Bool
    let categories: [Categories]
}

struct Coordinates: Decodable {
    let longitude: Double?
    let latitude: Double?
}
struct RestaurantResponse: Decodable {
    let businesses: [Restaurant]
}

struct Categories: Decodable {
    let title: String
}

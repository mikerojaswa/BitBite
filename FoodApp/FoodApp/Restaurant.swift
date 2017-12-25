//
//  Restaurant.swift
//  BitBite
//
//  Created by Michael Rojas on 12/16/17.
//  Copyright © 2017 Michael Rojas. All rights reserved.
//

import Foundation
import CoreLocation

struct Restaurant {
    let coordinate: CLLocationCoordinate2D?
    let description: String?
    let name: String?
    let menu: Menu?
}

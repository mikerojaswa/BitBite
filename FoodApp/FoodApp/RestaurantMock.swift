//
//  RestaurantMock.swift
//  BitBite
//
//  Created by Michael Rojas on 12/16/17.
//  Copyright © 2017 Michael Rojas. All rights reserved.
//

import CoreLocation

enum RestaurantMockType {
    case mcDonalds
}

class RestaurantMock {
    fileprivate var mockType: RestaurantMockType?
    
    init(mockType: RestaurantMockType) {
        self.mockType = mockType
    }
    
    public func mockData() -> Restaurant{
        let coordinates = CLLocationCoordinate2D(latitude: 33.394448, longitude: -111.909529)
        let menu = Menu(foodList: ["Burgers", "Fries", "Milkshakes"])
        let restaurant = Restaurant(coordinate: coordinates, description: "Fast food chain with burgers, fries, milkshakes", name: "McDonalds", menu: menu)
        return restaurant
    }
}

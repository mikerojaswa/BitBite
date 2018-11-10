//
//  AppDependencies.swift
//  FoodApp
//
//  Created by Michael Rojas on 11/9/18.
//  Copyright © 2018 Michael Rojas. All rights reserved.
//

import Foundation

/// Protocol for app dependencies.
public protocol AppDependencies {
    var restaurantService: RestaurantService { get }
    var locationService: LocationService { get } 
}

///  Appwide dependencies.
class Dependencies: AppDependencies {
    public var restaurantService: RestaurantService
    public var locationService: LocationService
    
    public init() {
        self.restaurantService = RestaurantApi(webService: Api())
        self.locationService = LocationService()
    }
}

//
//  RestaurantService.swift
//  FoodApp
//
//  Created by Michael Rojas on 11/9/18.
//  Copyright © 2018 Michael Rojas. All rights reserved.
//

import Foundation
import CoreLocation

public protocol RestaurantService {
    func fetchRestauraunts(for coordinates: CLLocationCoordinate2D)
}

class RestaurantApi: RestaurantService {
    let webService: WebService
    
    init(webService: WebService) {
        self.webService = webService
    }
    
    func fetchRestauraunts(for coordinates: CLLocationCoordinate2D) {
        let longitude = String(coordinates.longitude)
        let latitude = String(coordinates.latitude)
        let url = URL(string: "https://us-central1-bitbite-9927e.cloudfunctions.net/restaurants?lat=\(latitude)&long=\(longitude)")!
        webService.get(with: url) { (data) in
            print(data)
        }
//        let responses = try JSONDecoder().decode(RestaurantResponse.self, from: data)
//        let resultModels = responses.businesses.map { RestaurantResult(text: $0.name,
//                                                                       url: $0.image_url,
//                                                                       coordinates: $0.coordinates,
//                                                                       isClosed: $0.is_closed, categories: $0.categories )}

    }
}



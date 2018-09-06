//
//  WebService.swift
//  FoodApp
//
//  Created by Michael Rojas on 12/25/17.
//  Copyright © 2017 Michael Rojas. All rights reserved.
//

import Foundation
import CoreLocation

final class WebService {
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    func getBusinesses(for coordinates: CLLocationCoordinate2D, completion: @escaping ([RestaurantResult]?) -> ()) {
        let longitude = String(coordinates.longitude)
        let latitude = String(coordinates.latitude)
        let url = URL(string: "https://us-central1-bitbite-9927e.cloudfunctions.net/restaurants?lat=\(latitude)&long=\(longitude)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        defaultSession.dataTask(with: request) { (data, _, _) in
            guard let data = data else {
                completion(nil)
                return
            }
            do {
                let responses = try JSONDecoder().decode(RestaurantResponse.self, from: data)
                let resultModels = responses.businesses.map { RestaurantResult(text: $0.name,
                                                                               url: $0.image_url,
                                                                               coordinates: $0.coordinates,
                                                                               isClosed: $0.is_closed, categories: $0.categories )}
                completion(resultModels)

            } catch {
                completion(nil)
                print("Error converting data into Restaurant type")
            }
        }.resume()
    }
}

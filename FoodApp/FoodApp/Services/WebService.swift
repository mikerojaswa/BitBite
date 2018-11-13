//
//  WebService.swift
//  FoodApp
//
//  Created by Michael Rojas on 12/25/17.
//  Copyright © 2017 Michael Rojas. All rights reserved.
//

import Foundation
import CoreLocation

protocol WebService {
    func get(with url: URL, completion: @escaping (Data?) -> Void)
}

final class Api: WebService {
    func get(with url: URL, completion: @escaping ((Data?) -> ())) {

        let defaultSession = URLSession(configuration: .default)
        var request = URLRequest(url: url)
        defaultSession.dataTask(with: request) { (data, _, _) in
            guard let data = data else {
                completion(nil)
                return
            }
            do {
                completion(data)
            }
            }.resume()
    }
}

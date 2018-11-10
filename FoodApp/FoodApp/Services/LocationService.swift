//
//  LocationServices.swift
//  FoodApp
//
//  Created by Michael Rojas on 11/10/18.
//  Copyright © 2018 Michael Rojas. All rights reserved.
//

import CoreLocation
import RxSwift

public class LocationService: NSObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    private let locationStatus: Observable<CLAuthorizationStatus>
         
    public var locationObservable: Observable<CLAuthorizationStatus> {
        return locationStatus.asObservable()
    }
    
    override init() {
        self.locationStatus = Observable(CLLocationManager.authorizationStatus())

        super.init()
        locationManager.delegate = self
    }
    
    func requestLocationPermission() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            // Request when-in-use authorization initially
            locationManager.requestWhenInUseAuthorization()
            break
            
        case .restricted, .denied:
            // FUCK
            break
            
        case .authorizedWhenInUse, .authorizedAlways:
            // Sweg
            break
        }
    }
    
    private func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.locationStatus.value = status
    }
}

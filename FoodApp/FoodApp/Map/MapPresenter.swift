//
//  MapPresenter.swift
//  FoodApp
//
//  Created by Michael Rojas on 11/9/18.
//  Copyright © 2018 Michael Rojas. All rights reserved.
//

import Foundation
import RxSwift
import CoreLocation

protocol MapEventHandler: LifeCycle {
    func requestLocationAuthorizationIfNeeded()
}

class MapPresenter: MapEventHandler {
    func onLoaded() {
        // TODO attach search here.
    }
    
    func onWillAppear() {}
    
    func onAppear() {}
    
    
    var viewInterface: MapViewInterface?
    let disposeBag = DisposeBag()
    let appDependencies: AppDependencies
    
    init(appDependencies: AppDependencies) {
        self.appDependencies = appDependencies
    }
    
    func requestLocationAuthorizationIfNeeded() {
        let coordinates = CLLocationCoordinate2D(latitude: CLLocationDegrees(33.5610), longitude: CLLocationDegrees(-111.9089))
        appDependencies.restaurantService.fetchRestauraunts(for: coordinates) { (results) in
            
        }
        appDependencies.locationService.requestLocationPermission()
    }
    
}

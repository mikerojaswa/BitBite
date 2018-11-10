//
//  MapPresenter.swift
//  FoodApp
//
//  Created by Michael Rojas on 11/9/18.
//  Copyright © 2018 Michael Rojas. All rights reserved.
//

import Foundation
import RxSwift

protocol MapEventHandler {
    func requestLocationAuthorizationIfNeeded()
}

class MapPresenter: MapEventHandler {
    var viewInterface: MapViewInterface?
    let disposeBag = DisposeBag()
    let appDependencies: AppDependencies
    init(appDependencies: AppDependencies) {
        self.appDependencies = appDependencies
    }
    
    func requestLocationAuthorizationIfNeeded() {
        appDependencies.locationService.requestLocationPermission()
        appDependencies.locationService.locationObservable.subscribe({ status in
            print(status.element)
        }).disposed(by: disposeBag)
    }
    
}

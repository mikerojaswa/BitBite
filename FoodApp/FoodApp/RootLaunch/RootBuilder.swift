//
//  RootBuilder.swift
//  FoodApp
//
//  Created by Michael Rojas on 11/9/18.
//  Copyright © 2018 Michael Rojas. All rights reserved.
//

import UIKit

protocol Buildable {
    func build() -> UIViewController
}

final class RootBuilder: Buildable {
    let appDependencies: AppDependencies
    
    init(appDependencies: AppDependencies) {
        self.appDependencies = Dependencies()
    }
    
    func build() -> UIViewController {
        // Map presenter acts as our root presenter. 
        let rootPresenter = MapPresenter(appDependencies: appDependencies)
        
        // MapViewController is our root vc. 
        guard let viewController: MapViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MapViewController") as? MapViewController else {
            fatalError()
        }
        
        
        rootPresenter.viewInterface = viewController
        viewController.eventHandler = rootPresenter
        
        return viewController
    }
}

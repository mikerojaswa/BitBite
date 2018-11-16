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
    
    init() {
        self.appDependencies = Dependencies()
    }
    
    func build() -> UIViewController {
        // Map presenter acts as our root vc. 
        let rootPresenter = MapPresenter(appDependencies: appDependencies)
        
        guard let viewController: MapViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MapViewController") as? MapViewController else {
            fatalError()
        }
        
        // There will be retain cycles but dealing with that is out of the scope of this app.
        rootPresenter.viewInterface = viewController
        viewController.eventHandler = rootPresenter
        
        return viewController
    }
}

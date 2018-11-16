//
//  Presenter.swift
//  FoodApp
//
//  Created by Michael Rojas on 11/15/18.
//  Copyright © 2018 Michael Rojas. All rights reserved.
//

import Foundation

class BasePresenter  {
    let appDependencies: AppDependencies
    
    init(appDependencies: AppDependencies) {
        self.appDependencies = appDependencies
    }
}

protocol LifeCycle {
    func onLoaded()
    func onWillAppear()
    func onAppear()
}



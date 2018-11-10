//
//  RootLauncher.swift
//  FoodApp
//
//  Created by Michael Rojas on 11/9/18.
//  Copyright © 2018 Michael Rojas. All rights reserved.
//

import UIKit

public protocol Launchable {
    func launch(from window: UIWindow)
}

public class RootLauncher: Launchable {
    let root: UIViewController
    
    init(root: UIViewController) {
        self.root = root
    }
    
    public final func launch(from window: UIWindow) {
        window.rootViewController = root
        window.makeKeyAndVisible()
    }
}

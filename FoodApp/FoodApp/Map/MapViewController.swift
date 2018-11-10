//
//  MapViewController.swift
//  BitBite
//
//  Created by Michael Rojas on 12/16/17.
//  Copyright © 2017 Michael Rojas. All rights reserved.
//

import UIKit

public protocol MapViewInterface {
}

class MapViewController: UIViewController, MapViewInterface {
    
    var eventHandler: MapEventHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        eventHandler?.requestLocationAuthorizationIfNeeded()
    }
    
    
}

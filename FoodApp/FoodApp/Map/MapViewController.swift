//
//  MapViewController.swift
//  BitBite
//
//  Created by Michael Rojas on 12/16/17.
//  Copyright © 2017 Michael Rojas. All rights reserved.
//

import UIKit
import FloatingPanel

public protocol MapViewInterface {}

class MapViewController: UIViewController, MapViewInterface, FloatingPanelControllerDelegate {
    var fpc: FloatingPanelController!
    var eventHandler: MapEventHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        fpc = FloatingPanelController()
        fpc.delegate = self
        
        fpc.surfaceView.backgroundColor = .clear
        fpc.surfaceView.cornerRadius = 9.0
        fpc.surfaceView.shadowHidden = false
        
        let sb = UIStoryboard.init(name: "Search", bundle: nil)
        guard let searchViewController = sb.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController else { return }
        
        
        fpc.show(searchViewController, sender: nil)
        fpc.track(scrollView: searchViewController.tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        eventHandler?.requestLocationAuthorizationIfNeeded()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fpc.addPanel(toParent: self, animated: true)
    }
    
    func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout? {
        return MyFloatingPanelLayout()
    }
}


class MyFloatingPanelLayout: FloatingPanelLayout {
    public var initialPosition: FloatingPanelPosition {
        return .tip
    }
    
    public func insetFor(position: FloatingPanelPosition) -> CGFloat? {
        switch position {
        case .full: return 16.0 // A top inset from safe area
        case .half: return 216.0 // A bottom inset from the safe area
        case .tip: return 44.0 // A bottom inset from the safe area
        }
    }
}

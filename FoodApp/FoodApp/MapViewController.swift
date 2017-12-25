//
//  MapViewController.swift
//  BitBite
//
//  Created by Michael Rojas on 12/16/17.
//  Copyright © 2017 Michael Rojas. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate, PopupViewControllerDelegate {
    var location: CLLocationCoordinate2D?
    @IBOutlet var mapView: MKMapView!
    var locationManager: CLLocationManager = CLLocationManager()

    @IBOutlet var findFoodButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        mapView.userTrackingMode = MKUserTrackingMode.follow
        findFoodButton.layer.cornerRadius = 10
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        locationAuthStatus()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        }
    }
    
    func locationAuthStatus(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            /*  6.Allow map view to use Core Location to find the user's location
             and add an annotation of type MKUserLocation to the map. */
            locationManager.startMonitoringSignificantLocationChanges()
            mapView.showsUserLocation = true
        } else {
            //  6.1.If status isn't authorizedWhenInUse, then ask manager for the author
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.location = locations.last?.coordinate
    }
    
    @IBAction func findFoodButtonPressed(_ sender: Any) {
        locationManager.requestLocation()
        let vc = PopUpViewController(nibName: "PopUpViewController", bundle: nil)
        vc.delegate = self
        vc.restaurant = RestaurantMock(mockType: .mcDonalds).mockData()
        self.addChildViewController(vc)
        vc.view.frame = self.view.frame
        self.view.addSubview(vc.view)
        vc.didMove(toParentViewController: self)
    }
    
    // MARK: - PopupViewControllerDelegate
    func didSelectClose(_ popupVC: PopUpViewController) {
        guard let vc = self.childViewControllers.last else { return }
        vc.view.removeFromSuperview()
        vc.removeFromParentViewController()
    }
    
}

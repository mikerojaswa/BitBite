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

enum ViewState {
    case routing
    case browsing
}

class MapViewController: UIViewController, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate {
    var location: CLLocationCoordinate2D?
    @IBOutlet var mapView: MKMapView!
    var locationManager: CLLocationManager = CLLocationManager()
    @IBOutlet var tableView: CustomTableView!
    @IBOutlet var tableViewHeight: NSLayoutConstraint!
    var viewState: ViewState = .browsing
    // TODO: Encapsulate this abomination
    var selectedModel: RestaurantResult?
    var travelModel: TravelModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        mapView.userTrackingMode = MKUserTrackingMode.follow
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 100
        mapView.delegate = self
        tableView.backgroundColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.9)
        tableView.register(UINib.init(nibName: "ThumbnailAndLabelTableViewCell", bundle: nil), forCellReuseIdentifier: "ThumbnailAndLabelTableViewCell")
        tableView.register(UINib.init(nibName: "ResultCell", bundle: nil), forCellReuseIdentifier: "ResultCell")
        var helloWorldTimer = Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(updateStuff), userInfo: nil, repeats: true)
    }
    
    @objc
    private func handleTap() {
        tableView.scrollToNearestSelectedRow(at: .top, animated: false)
        UIView.animate(withDuration: 0.5, animations: {
            self.tableViewHeight.constant = 100
        })
    }
    
    @objc
    private func handleScrollViewTap() {
        UIView.animate(withDuration: 0.5, animations: {
            self.tableViewHeight.constant = 400
        })
    }
    
    var models: [RestaurantResult] = []
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = models[indexPath.row]
        for annotation in mapView.annotations {
            mapView.removeAnnotation(annotation)
        }
        let anno = MKPointAnnotation();
        anno.title = model.text
        let restaurantCoordinates = CLLocationCoordinate2D(latitude: model.coordinates.latitude!, longitude: model.coordinates.longitude!)
        anno.coordinate = restaurantCoordinates
        mapView.addAnnotation(anno)
        guard let location = self.location else { return }

        tableView.scrollToRow(at: indexPath, at: .top, animated: false)
        tableView.deselectRow(at: indexPath, animated: true)
        handleTap()
        showRoute(source: location, destination: restaurantCoordinates)
        viewState = .routing
        selectedModel = model
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch viewState {
        case .browsing:
            return models.count
        case .routing:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewState {
        case .browsing:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ThumbnailAndLabelTableViewCell", for: indexPath) as! ThumbnailAndLabelTableViewCell
            let model = models[indexPath.row]
            cell.bind(model: model)
            cell.titleLabel.textColor = .black
            if model.isClosed {
                cell.titleLabel.textColor = .red
            }
            
            
            return cell
        case .routing:
            tableView.rowHeight = 250
            let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as! ResultCell
            guard let model = selectedModel, let travelModel = travelModel else { return cell }
            cell.title.text = model.text
            cell.imageHint.downloadedFrom(link: model.url)
            cell.distance.text = travelModel.distance
            cell.transportationTime.text = travelModel.time
            cell.textView.text = ""
            for category in model.categories {
                cell.textView.text += "\(category.title) \n"
            }
            
            return cell
        }
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
            locationManager.startUpdatingLocation()
            mapView.showsUserLocation = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: { [weak self] in
                self?.updateStuff()
            })
            
        } else {
            //  6.1.If status isn't authorizedWhenInUse, then ask manager for the author
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.location = locations.last?.coordinate
    }
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        handleTap()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        UIView.animate(withDuration: 0.5, animations: {
            self.tableViewHeight.constant = 400
        })
    }
    
    @objc func updateStuff() {
        let service = WebService()
        guard let location = self.location else { return }
        service.getBusinesses(for: location, completion: { [weak self] data in
            guard let data = data else { return }
            self?.models = data
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        })
        mapView.setCenter(self.location!, animated: true)
    }
    
    func showRoute(source: CLLocationCoordinate2D, destination: CLLocationCoordinate2D) {
        let request = MKDirectionsRequest()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: source, addressDictionary: nil))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination, addressDictionary: nil))
        request.requestsAlternateRoutes = false
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        
        directions.calculate { [unowned self] response, error in
            guard let unwrappedResponse = response else { return }
            
            if (unwrappedResponse.routes.count > 0) {
                let distance = unwrappedResponse.routes[0].distance/1600
                let expectedTravelTime = unwrappedResponse.routes[0].expectedTravelTime/60
                self.travelModel = TravelModel.init(time: "\(expectedTravelTime.rounded(FloatingPointRoundingRule.toNearestOrAwayFromZero).description) min", distance: "\(distance.rounded(FloatingPointRoundingRule.toNearestOrAwayFromZero).description) mi.")
                self.mapView.add(unwrappedResponse.routes[0].polyline)
                let coordinates: [CLLocationCoordinate2D] = [source, destination]
                let points = coordinates.map { MKMapPointForCoordinate($0) }
                let rects = points.map { MKMapRect(origin: $0, size: MKMapSize(width: 0, height: 0)) }
                let fittingRect = rects.reduce(MKMapRectNull, MKMapRectUnion)
                let insetRect = MKMapRectInset(fittingRect, -5000, -5000)
                
                let region = MKCoordinateRegionForMapRect(insetRect)
                
                self.mapView.setRegion(region, animated: true)
                self.tableView.reloadData()
            }
        }

    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        mapView.removeAllOverlays()
        if overlay is MKPolyline {
            let polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = .blue
            polylineRenderer.lineWidth = 5
            return polylineRenderer
        }
        return MKPolylineRenderer()
    }
    
}


extension MKMapView
{
    func removeAllOverlays(){
        self.removeOverlays(self.overlays)
    }
    
}

//
//  ViewController.swift
//  SwiftMapPlayground
//
//  Created by Swan Nay Phue Aung on 01/10/2024.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, UIGestureRecognizerDelegate {

    private let locationManager = LocationViewModel.shared
    
    
    // Declare start and end position variables
    var startCoordinate: CLLocationCoordinate2D?
    var endCoordinate: CLLocationCoordinate2D?
    var coreLocationManager : CLLocationManager!
    
    private let mapView : MKMapView = {
       let mapView = MKMapView()
        mapView.overrideUserInterfaceStyle = .light
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        setupLocationManager()
        coreLocationManager.delegate = self
        mapView.register(MKAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        setUpUI()
        setUpConstraintts()
        addDoubleTapGesture()

    }

    fileprivate func setUpUI() {
        view.addSubview(mapView)
        mapView.addAnnotations(locationManager.locations)

    }
    
    private func setupLocationManager() {
        coreLocationManager = CLLocationManager()
        coreLocationManager.delegate = self
        coreLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        coreLocationManager.requestWhenInUseAuthorization()
        coreLocationManager.startUpdatingLocation()  // Start receiving location updates
       }
    
    
    private func addDoubleTapGesture() {
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        doubleTapGesture.numberOfTapsRequired = 2 // Set for double-tap
        doubleTapGesture.delegate = self // Set the delegate
        mapView.addGestureRecognizer(doubleTapGesture)
    }
    
    @objc private func handleDoubleTap(_ gestureRecognizer: UITapGestureRecognizer) {
        print("Double tap recognized!") 
          let locationInView = gestureRecognizer.location(in: mapView)
          let coordinate = mapView.convert(locationInView, toCoordinateFrom: mapView)
          
          // Drop an annotation at the double-tap location
          let annotation = MKPointAnnotation()
          annotation.coordinate = coordinate
          annotation.title = "Pinned Location"
          annotation.subtitle = "Lat: \(coordinate.latitude), Lon: \(coordinate.longitude)"
          mapView.addAnnotation(annotation)
      }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        // Allow double-tap gesture to be recognized simultaneously with map's default gestures
        return true
    }
       
    
    fileprivate func setUpConstraintts() {
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor,constant: 10),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
        
        
    }
    
    
    //MARK: - Initial Locaton Set Up
    private func setUpMapInitialView(currentLocation: CLLocation) {
           let coordinate = currentLocation.coordinate
           
           // Add annotation for current location (optional)
           let annotation = MKPointAnnotation()
           annotation.coordinate = coordinate
           annotation.title = "My Location"
           mapView.addAnnotation(annotation)
           
           // Set map region to user's current location
           let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
           mapView.setRegion(region, animated: true)
       }

    
    
    //MARK: - Route Set Up
    fileprivate func setUpRoute() {
        guard let start = startCoordinate, let end = endCoordinate else {
            print("Start or end coordinate is missing.")
            return
        }
        
        
        //1. Need MapItem to set up route directions request
        //2. make placemark to create map item first
        
        
        let startPlacemark = MKPlacemark(coordinate: start)
        let endPlacemark = MKPlacemark(coordinate: end)
        
        let startMapItem = MKMapItem(placemark: startPlacemark)
        let endMapItem = MKMapItem(placemark: endPlacemark)
        
        // Create a directions request
        let directionsRequest = MKDirections.Request()
        
        // specify starting point
        directionsRequest.source = startMapItem
        
        // specify ending point
        directionsRequest.destination = endMapItem
        
        // specify transport type
        directionsRequest.transportType = .automobile // Can also be `.walking`, `.transit`, etc.
        
        // Calculate directions
        let directions = MKDirections(request: directionsRequest)
        directions.calculate { [weak self] (response, error) in
            guard let strongSelf = self else { return }
            
            if let error = error {
                print("Error calculating directions: \(error.localizedDescription)")
                return
            }
            
            if let route = response?.routes.first {
                // Add the route polyline to the map
                strongSelf.mapView.addOverlay(route.polyline)
                
                // Adjust the map region to fit the route
                strongSelf.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            }
        }
    }


    

}


extension MapViewController: MKMapViewDelegate {
    
    // Showing annotation view with a custom pin
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = MKMapViewDefaultAnnotationViewReuseIdentifier
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier, for: annotation)
        
        annotationView.canShowCallout = true
        annotationView.tintColor = .red
        annotationView.image = UIImage(systemName: "mappin.circle.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal)
        annotationView.rightCalloutAccessoryView = UIButton(type: .contactAdd)
        
        return annotationView
    }
    
    // Visual for route view
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: polyline)
            renderer.strokeColor = UIColor.red
            renderer.lineWidth = 4.0
            return renderer
        }
        return MKOverlayRenderer(overlay: overlay)
    }
    
    // Handling callout accessory taps to set start/end positions
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let annotation = view.annotation as? MKPointAnnotation else { return }
        
        let alertController: UIAlertController
        if startCoordinate == nil {
            alertController = UIAlertController(title: annotation.title ?? "Start", message: "Start location set", preferredStyle: .alert)
            startCoordinate = annotation.coordinate
        } else {
            alertController = UIAlertController(title: annotation.title ?? "End", message: "End location set", preferredStyle: .alert)
            endCoordinate = annotation.coordinate
        }
        
        let dismissAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(dismissAction)
        present(alertController, animated: true, completion: nil)
        
        if startCoordinate != nil && endCoordinate != nil {
            setUpRoute()
        }
    }
}

extension MapViewController : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else { return }
                
            setUpMapInitialView(currentLocation: currentLocation)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("Failed to find user's location: \(error.localizedDescription)")

    }
    
}

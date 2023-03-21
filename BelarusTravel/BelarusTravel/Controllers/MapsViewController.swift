//
//  MapsViewController.swift
//  BelarusTravel
//
//  Created by Eugene on 15/03/2023.
//

import UIKit
import MapKit
import CoreLocation

class MapsViewController: UIViewController {
    
    //MARK: - Properties
    
    var place: Place?
    
    let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    let locationManager = CLLocationManager()
    var currentLat: Double = 0
    var currentLng: Double = 0

    //MARK: - Life cicle

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        setConstrains()
        getCurrentLocation()
    }
    
    //MARK: - Methods
    
    private func getCurrentLocation() {
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.delegate = self
                self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
                self.locationManager.startUpdatingLocation()
            }
        }
    }
    

    
    private func geoCoder() {
        let geoCoder = CLGeocoder()
        guard let lat = Double(place?.coordinates?.lat ?? "0.00"),
              let lng = Double(place?.coordinates?.lng ?? "0.00") else { return }
        let finalLocation = CLLocation(latitude: lat, longitude: lng)
        geoCoder.reverseGeocodeLocation(finalLocation) { [self] placemarks, error in
            if let error = error {
                print(error)
                return
            }
            guard let placemarks = placemarks else { return }
            let placemark = placemarks.first
            
            let annotation = MKPointAnnotation()
            annotation.title = "\(String(describing: self.place?.namePlace))"
            guard let placemarkLocation = placemark?.location else { return }
            annotation.coordinate = placemarkLocation.coordinate
            
            let annotationSecond = MKPointAnnotation()
            annotationSecond.coordinate = CLLocationCoordinate2D(latitude: currentLat, longitude: currentLng)
            let annotationsArray = [annotation, annotationSecond]
            mapView.showAnnotations(annotationsArray, animated: true)
            createRoute(a: annotation.coordinate, b: annotationSecond.coordinate)
        }
    }
    
 
    
    private func createRoute(a: CLLocationCoordinate2D, b: CLLocationCoordinate2D) {
        
        let currentLocation = MKPlacemark(coordinate: a)
        let finalLocation = MKPlacemark(coordinate: b)
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: currentLocation)
        request.destination = MKMapItem(placemark: finalLocation)
        request.transportType = .automobile
        
        let diraction = MKDirections(request: request)
        diraction.calculate { response, error in
            if let error = error {
                print(error)
                return
            }
            guard let response = response else {
                return
            }
            let route = response.routes[0]

            self.mapView.addOverlay(route.polyline)
        }
        
    }
}

extension MapsViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("\(locValue.latitude) \(locValue.longitude)")
        currentLat = 53.9
        currentLng = 27.5
        geoCoder()
    }
}

extension MapsViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .red
        return renderer
    }
}

extension MapsViewController {
    
    func setConstrains() {
        
        view.addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}

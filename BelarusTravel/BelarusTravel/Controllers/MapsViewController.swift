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
    
    //var place: TravelType?
    var place: Place?
    let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
//    var annotationsArray = [MKPointAnnotation]()
    let locationManager = CLLocationManager()
    //var currentRoute: MKRoute?
    var currentLat: Double = 0
    var currentLng: Double = 0


    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        //self.title?.removeAll()
        setConstrains()
//        geoCoder()
        getCurrentLocation()
//        createRoute(a: annotationsArray[0].coordinate, b: annotationsArray[1].coordinate)
    }
    
    
    private func getCurrentLocation() {
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        //        locationManager.delegate = self
        //        locationManager.requestWhenInUseAuthorization()
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.delegate = self
                self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
                self.locationManager.startUpdatingLocation()
            }
        }
        
//        if CLLocationManager.locationServicesEnabled() {
//            locationManager.delegate = self
//            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
//            locationManager.startUpdatingLocation()
//        }
    }
    

    
    private func geoCoder() {
        let geoCoder = CLGeocoder()
//        guard let lat = Double(place?.place?.coordinates?.lat ?? "0.00"),
//              let lng = Double(place?.place?.coordinates?.lng ?? "0.00") else { return }
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
            //annotation.title = "\(String(describing: self.place?.place?.namePlace))"
            annotation.title = "\(String(describing: self.place?.namePlace))"
            guard let placemarkLocation = placemark?.location else { return }
            annotation.coordinate = placemarkLocation.coordinate
            
            let annotationSecond = MKPointAnnotation()
            annotationSecond.coordinate = CLLocationCoordinate2D(latitude: currentLat, longitude: currentLng)
            //annotationSecond.coordinate = placemarkLocation.coordinate
//            annotationsArray.append(annotation)
//            annotationsArray.append(annotationSecond)
            let annotationsArray = [annotation, annotationSecond]
            mapView.showAnnotations(annotationsArray, animated: true)
            //mapView.centerLocation(finalLocation, regionRadius: 600000)
            
//            createRoute(a: annotationsArray[0].coordinate, b: annotationsArray[1].coordinate)
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
            
            //self.currentRoute = route
            //self.mapView.removeOverlay(self.mapView.overlays as! MKOverlay)
            self.mapView.addOverlay(route.polyline)
        }
        
    }
}

extension MapsViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("\(locValue.latitude) \(locValue.longitude)")
        //currentLat = locValue.latitude
        //currentLng = locValue.longitude
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

//extension MKMapView {
//    func centerLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 10000) {
//        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
//        setRegion(coordinateRegion, animated: true)
//    }
//}

//
//  LocationService.swift
//  WeatherMan
//
//  Created by Andrew Riznyk on 12/2/18.
//  Copyright © 2018 Andrew Riznyk. All rights reserved.
//

import Foundation
import CoreLocation

class LocationService: NSObject {
    static let shared = LocationService()
    private override init() {}
    var date : Date?
    var locationUpdateHandler: ((CLLocation) -> Void)?
    
    var userLocation: CLLocation!
    let locationManager = CLLocationManager()
    
    func findLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        updateLocation()
    }
    
    func updateLocation(){
        if  CLLocationManager.authorizationStatus() == .authorizedAlways ||
            CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
}


extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lastLocation = locations.last else { return }
        if date == nil || date!.timeIntervalSince(Date()) > Double(60) {
            date = Date()
            locationManager.stopUpdatingLocation()
            userLocation = lastLocation
            locationUpdateHandler?(userLocation)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        updateLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

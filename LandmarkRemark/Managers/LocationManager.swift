//
//  LocationManager.swift
//  LandmarkRemark
//
//  Created by Michael Yuwono on 26/7/20.
//  Copyright © 2020 Michael Yuwono. All rights reserved.
//

import Foundation
import MapKit

class LocationManager: NSObject, ObservableObject {
    
    // Device current location
    @Published var location: CLLocation?
    
    // Callback function called when the first location is received
    var onFirstLocationUpdateHandler: ((CLLocation?) -> Void)?
    
    // Manager to handle location service
    private let locationManager: CLLocationManager = CLLocationManager()
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        
        // Request authorization when the device location services are enabled
        if (CLLocationManager.locationServicesEnabled()) {
            self.locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func setOnFirstLocationUpdateHandler(handler: @escaping ((CLLocation?) -> Void)) {
        self.onFirstLocationUpdateHandler = handler
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == .authorizedAlways || status == .authorizedWhenInUse) {
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        
        // Call onFirstLocationUpdateHandler on first location update
        if (self.location == nil) {
            if let handler = self.onFirstLocationUpdateHandler {
                handler(location)
            }
        }
        
        // Update current location
        self.location = location
    }
    
}

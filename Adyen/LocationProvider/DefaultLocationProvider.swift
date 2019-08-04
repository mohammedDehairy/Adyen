//
//  DefaultLocationProvider.swift
//  Adyen
//
//  Created by mohamed mohamed El Dehairy on 8/3/19.
//  Copyright © 2019 mohamed El Dehairy. All rights reserved.
//

import CoreLocation

final public class DefaultLocationProvider: NSObject, LocationProvider, CLLocationManagerDelegate {
    public var updateUserLocation: ((CLLocation) -> Void)?
    private lazy var locationManager: CLLocationManager = CLLocationManager()
    private var isUpdating = false
    
    public func startUpdateLocation() {
        guard !isUpdating else { return }
        isUpdating = true
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    public func stopUpdateLocation() {
        guard isUpdating else { return }
        isUpdating = false
        locationManager.stopUpdatingLocation()
    }
    
    // MARK: - CLLocationManagerDelegate
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        updateUserLocation?(location)
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
}

//
//  LocationProvider.swift
//  Adyen
//
//  Created by mohamed mohamed El Dehairy on 8/3/19.
//  Copyright © 2019 mohamed El Dehairy. All rights reserved.
//

import CoreLocation

protocol LocationProvider {
    var updateUserLocation: ((CLLocation) -> Void)? { get set }
    func startUpdateLocation()
    func stopUpdateLocation()
}

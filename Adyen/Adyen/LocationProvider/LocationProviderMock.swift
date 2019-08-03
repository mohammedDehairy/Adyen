//
//  LocationProviderMock.swift
//  AdyenTests
//
//  Created by mohamed mohamed El Dehairy on 8/3/19.
//  Copyright © 2019 mohamed El Dehairy. All rights reserved.
//

import Foundation
import CoreLocation

final class LocationProviderMock: LocationProvider {
    var updateUserLocation: ((CLLocation) -> Void)?
    
    var onStartUpdateLocation: (() -> Void)?
    func startUpdateLocation() {
        onStartUpdateLocation?()
    }
    
    var onStopUpdateLocation: (() -> Void)?
    func stopUpdateLocation() {
        onStopUpdateLocation?()
    }
}

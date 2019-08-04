//
//  PlacesViewModelMock.swift
//  AdyenTests
//
//  Created by mohamed mohamed El Dehairy on 8/3/19.
//  Copyright © 2019 mohamed El Dehairy. All rights reserved.
//

import Foundation
import MapKit
import PlacesScene

final class PlacesViewModelMock: PlacesViewModel {
    var updateModel: ((Result<[PlaceModel], Error>) -> Void)?
    
    var updateUserLocation: ((CLLocation) -> Void)?
    
    var cachedModel: [PlaceModel] = []
    
    var onDidChangeRegion: ((MKCoordinateRegion) -> Void)?
    func didChangeRegion(region: MKCoordinateRegion) {
        onDidChangeRegion?(region)
    }
    
    var onDidSelect: ((PlaceModel) -> Void)?
    func didSelect(place: PlaceModel) {
        onDidSelect?(place)
    }
}

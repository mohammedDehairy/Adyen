//
//  PlacesViewModel.swift
//  Adyen
//
//  Created by mohamed mohamed El Dehairy on 8/3/19.
//  Copyright © 2019 mohamed El Dehairy. All rights reserved.
//

import MapKit

public protocol PlacesViewModel {
    var updateModel: ((Result<[PlaceModel], Error>) -> Void)? { get set }
    var updateUserLocation: ((CLLocation) -> Void)? { get set }
    var cachedModel: [PlaceModel] { get }
    func didChangeRegion(region: MKCoordinateRegion)
    func didSelect(place: PlaceModel)
}

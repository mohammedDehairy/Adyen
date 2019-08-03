//
//  PlacesStore.swift
//  Adyen
//
//  Created by mohamed mohamed El Dehairy on 8/3/19.
//  Copyright © 2019 mohamed El Dehairy. All rights reserved.
//

import Foundation
import MapKit

struct PlaceQuery {
    let region: MKCoordinateRegion
    let limit: Int
}

protocol PlaceStore {
    @discardableResult
    func get(with query: PlaceQuery, completion: @escaping ((Result<[PlaceModel], Error>) -> Void)) -> Cancelable
}

//
//  PlacesStore.swift
//  Adyen
//
//  Created by mohamed mohamed El Dehairy on 8/3/19.
//  Copyright © 2019 mohamed El Dehairy. All rights reserved.
//

import Foundation
import MapKit
import ClientAPI

public struct PlaceQuery {
    public let region: MKCoordinateRegion
    public let limit: Int
    
    public init(region: MKCoordinateRegion, limit: Int) {
        self.region = region
        self.limit = limit
    }
}

public protocol PlaceStore {
    @discardableResult
    func get(with query: PlaceQuery, completion: @escaping ((Result<[PlaceModel], Error>) -> Void)) -> Cancelable
}

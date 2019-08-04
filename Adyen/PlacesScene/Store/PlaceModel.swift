//
//  PlaceModel.swift
//  Adyen
//
//  Created by mohamed mohamed El Dehairy on 8/3/19.
//  Copyright © 2019 mohamed El Dehairy. All rights reserved.
//

import MapKit

public struct PlaceModel: Hashable {
    public let id: String
    public let name: String
    public let coordinate: CLLocationCoordinate2D
    public let category: String
    
    public init(
        id: String,
        name: String,
        coordinate: CLLocationCoordinate2D,
        category: String
        ) {
        self.id = id
        self.name = name
        self.coordinate = coordinate
        self.category = category
    }
    
    static public func == (lhs: PlaceModel, rhs: PlaceModel) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.coordinate.latitude == rhs.coordinate.latitude && lhs.coordinate.longitude == rhs.coordinate.longitude && lhs.category == rhs.category
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(coordinate.latitude)
        hasher.combine(coordinate.longitude)
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(category)
    }
}

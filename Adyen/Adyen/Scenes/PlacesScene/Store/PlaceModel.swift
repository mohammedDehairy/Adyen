//
//  PlaceModel.swift
//  Adyen
//
//  Created by mohamed mohamed El Dehairy on 8/3/19.
//  Copyright © 2019 mohamed El Dehairy. All rights reserved.
//

import MapKit

struct PlaceModel: Hashable {
    let id: String
    let name: String
    let coordinate: CLLocationCoordinate2D
    let category: String
    
    static func == (lhs: PlaceModel, rhs: PlaceModel) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.coordinate.latitude == rhs.coordinate.latitude && lhs.coordinate.longitude == rhs.coordinate.longitude && lhs.category == rhs.category
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(coordinate.latitude)
        hasher.combine(coordinate.longitude)
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(category)
    }
}

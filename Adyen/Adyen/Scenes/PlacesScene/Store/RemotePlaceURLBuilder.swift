//
//  RemotePlaceStoreURLBuilder.swift
//  Adyen
//
//  Created by mohamed mohamed El Dehairy on 8/3/19.
//  Copyright © 2019 mohamed El Dehairy. All rights reserved.
//

import MapKit

struct RemotePlaceURLBuilder {
    let environment: PlaceApiEnvironment
    func build(query: PlaceQuery) -> String {
        let ll = "\(query.region.center.latitude),\(query.region.center.longitude)"
        let radius = getRadius(from: query.region)
        return "\(environment.host)/v2/venues/explore?ll=\(ll)&radius=\(radius)&limit=\(query.limit)&client_id=\(environment.credentials.id)&client_secret=\(environment.credentials.secret)&v=20190803"
    }
    
    func getRadius(from region: MKCoordinateRegion) -> Int {
        let center = CLLocation(latitude: region.center.latitude, longitude: region.center.longitude)
        let delta = region.span.latitudeDelta
        let coordinate1 = CLLocation(latitude: center.coordinate.latitude + delta/2, longitude: center.coordinate.longitude)
        let radius = center.distance(from: coordinate1)
        return min(Int(radius), 100_000)
    }
}

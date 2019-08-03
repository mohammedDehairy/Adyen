//
//  RemotePlaceStoreURLBuilder.swift
//  Adyen
//
//  Created by mohamed mohamed El Dehairy on 8/3/19.
//  Copyright © 2019 mohamed El Dehairy. All rights reserved.
//

import MapKit

struct RemotePlaceURLBuilder {
    func build(query: PlaceQuery) -> String {
        let ll = "\(query.region.center.latitude),\(query.region.center.longitude)"
        let radius = getRadius(from: query.region)
        return "https://api.foursquare.com/v2/venues/explore?ll=\(ll)&radius=\(radius)&client_id=11UWH4D0OHIDVOIL2F1NC5OUABVEED3VTOEOVLSPGHI3LKQB&client_secret=B4RQ2D3CI0ZVQFM5C2OJKH5IN01MX3GJSMO0PT5A0RY0RLDZ&v=20190803"
    }
    
    private func getRadius(from region: MKCoordinateRegion) -> Int {
        let center = CLLocation(latitude: region.center.latitude, longitude: region.center.longitude)
        let delta = max(region.span.latitudeDelta, region.span.longitudeDelta)
        let coordinate1 = CLLocation(latitude: center.coordinate.latitude + delta/2, longitude: center.coordinate.longitude)
        let radius = center.distance(from: coordinate1)
        return Int(radius)
    }
}

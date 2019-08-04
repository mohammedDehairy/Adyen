//
//  RemotePlaceURLBuilderTest.swift
//  AdyenTests
//
//  Created by mohamed mohamed El Dehairy on 8/3/19.
//  Copyright © 2019 mohamed El Dehairy. All rights reserved.
//

import XCTest
import MapKit
import PlacesScene

class RemotePlaceURLBuilderTest: XCTestCase {
    var sut: RemotePlaceURLBuilder!

    func test_small_radius() {
        sut = RemotePlaceURLBuilder(environment: PlaceApiEnvironment(host: "host_test", credentials: PlaceApiCredentials(id: "id_test", secret: "secret_test")))
        let center = CLLocationCoordinate2D(latitude: 50, longitude: 50)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 50, longitudinalMeters: 50)
        let radius = sut.getRadius(from: region)
        let query = PlaceQuery(region: region, limit: 5)
        let url = sut.build(query: query)
        let ll = "50.0,50.0"
        XCTAssertEqual(url, "host_test/v2/venues/explore?ll=\(ll)&radius=\(radius)&limit=\(query.limit)&client_id=id_test&client_secret=secret_test&v=20190803")
    }
    
    func test_large_radius() {
        sut = RemotePlaceURLBuilder(environment: PlaceApiEnvironment(host: "host_test", credentials: PlaceApiCredentials(id: "id_test", secret: "secret_test")))
        let center = CLLocationCoordinate2D(latitude: 50, longitude: 50)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 900_000, longitudinalMeters: 900_000)
        let query = PlaceQuery(region: region, limit: 5)
        let url = sut.build(query: query)
        let ll = "50.0,50.0"
        XCTAssertEqual(url, "host_test/v2/venues/explore?ll=\(ll)&radius=100000&limit=\(query.limit)&client_id=id_test&client_secret=secret_test&v=20190803")
    }

}

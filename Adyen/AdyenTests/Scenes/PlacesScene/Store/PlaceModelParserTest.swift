//
//  PlaceModelParserTest.swift
//  AdyenTests
//
//  Created by mohamed mohamed El Dehairy on 8/3/19.
//  Copyright © 2019 mohamed El Dehairy. All rights reserved.
//

import XCTest
import CoreLocation
import PlacesScene

class PlaceModelParserTest: XCTestCase {

    func test_success() {
        let expectedPlaces = [
            PlaceModel(id: "587fb9ea25911e15b1056e8c", name: "Brute Burgers", coordinate: CLLocationCoordinate2D(latitude: 52.303954, longitude: 4.691842), category: "Burger Joint"),
            PlaceModel(id: "4f5f4a63e4b0028cfa222448", name: "CineMeerse", coordinate: CLLocationCoordinate2D(latitude: 52.30175696243503, longitude: 4.69554693601281), category: "Movie Theater"),
            PlaceModel(id: "581483c738fa25270f6a022d", name: "Jopenkerk Hoofddorp", coordinate: CLLocationCoordinate2D(latitude: 52.30211291653203, longitude: 4.6887681648385815), category: "Brewery")
        ]
        let path = Bundle(for: PlaceModelParserTest.self).path(forResource: "test_places_success", ofType: "json")!
        let url = URL(fileURLWithPath: path)
        let data = try! Data(contentsOf: url)
        let result = parse(data: data)
        XCTAssertEqual(result.value, expectedPlaces)
    }
    
    func test_error() {
        let path = Bundle(for: PlaceModelParserTest.self).path(forResource: "test_places_error", ofType: "json")!
        let url = URL(fileURLWithPath: path)
        let data = try! Data(contentsOf: url)
        let result = parse(data: data)
        XCTAssertEqual(result.error?.localizedDescription, "Your geographic boundary is too big. Please search a smaller area.")
    }

}

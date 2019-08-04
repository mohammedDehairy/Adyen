//
//  PlacesViewControllerTest.swift
//  AdyenTests
//
//  Created by mohamed mohamed El Dehairy on 8/3/19.
//  Copyright © 2019 mohamed El Dehairy. All rights reserved.
//

import XCTest
import MapKit
@testable import PlacesScene

class PlacesViewControllerTest: XCTestCase {

    func test_update_modes() {
        let viewModel = PlacesViewModelMock()
        let sut = PlacesViewController(viewModel: viewModel)
        let expectedPlaces = [
            PlaceModel(id: "id_1", name: "name 1", coordinate: CLLocationCoordinate2D(latitude: 50, longitude: 50), category: "category 1"),
            PlaceModel(id: "id_2", name: "name 2", coordinate: CLLocationCoordinate2D(latitude: 50.01, longitude: 50.01), category: "category 2")
        ]
        UIApplication.shared.keyWindow?.rootViewController = sut
        
        let expectation1 = XCTestExpectation(description: "Expect the places to added to the map")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
            viewModel.updateUserLocation?(CLLocation(latitude: 50, longitude: 50))
            viewModel.updateModel?(.success(expectedPlaces))
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(5)) {
            let annotations = sut.mapView.annotations
            XCTAssertTrue(Set(annotations.map { $0.title }).isSuperset(of: Set(expectedPlaces.map { $0.name })))
            expectation1.fulfill()
        }
        
        wait(for: [expectation1], timeout: 10.0)
    }

}

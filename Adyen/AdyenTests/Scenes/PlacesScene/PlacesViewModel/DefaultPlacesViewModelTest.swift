//
//  DefaultPlacesViewModelTest.swift
//  AdyenTests
//
//  Created by mohamed mohamed El Dehairy on 8/3/19.
//  Copyright © 2019 mohamed El Dehairy. All rights reserved.
//

import XCTest
import MapKit
import ClientAPI
import PlacesScene

enum ErrorMock: LocalizedError, Equatable {
    case anyError
    
    var errorDescription: String? {
        return "error_mock"
    }
}

class DefaultPlacesViewModelTest: XCTestCase {

    var sut: DefaultPlacesViewModel!
    var store: PlaceStoreMock!
    var locationProvider: LocationProviderMock!
    
    override func setUp() {
        store = PlaceStoreMock()
        locationProvider = LocationProviderMock()
        sut = DefaultPlacesViewModel(store: store, locationProvider: locationProvider)
    }

    func test_did_change_region_success() {
        let expectedPlaces = (1...10).map { i in
            PlaceModel(id: "id_\(i)", name: "name \(i)", coordinate: CLLocationCoordinate2D(latitude: 52.3005591, longitude: 4.6844456), category: "category \(i)")
        }
        store.onGet = { query, completion in
            completion(.success(expectedPlaces))
            return NullCancelable()
        }
        
        let expectation1 = expectation(description: "Expect DefaultPlacesViewModel to call the updateModel closure")
        sut.updateModel = { result in
            XCTAssertEqual(result.value, expectedPlaces)
            expectation1.fulfill()
        }
        
        sut.didChangeRegion(region: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 1, longitude: 2), latitudinalMeters: 2, longitudinalMeters: 3))
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func test_did_change_region_failure() {
        store.onGet = { query, completion in
            completion(.failure(ErrorMock.anyError))
            return NullCancelable()
        }
        
        let expectation1 = expectation(description: "Expect DefaultPlacesViewModel to call the updateModel closure")
        sut.updateModel = { result in
            XCTAssertEqual(result.error?.localizedDescription, ErrorMock.anyError.localizedDescription)
            expectation1.fulfill()
        }
        
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 1, longitude: 2), latitudinalMeters: 2, longitudinalMeters: 3)
        sut.didChangeRegion(region: region)
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func test_updateUserLocation() {
        let expectation1 = expectation(description: "Expect locationProvider.startUpdateLocation() to be called")
        locationProvider.onStartUpdateLocation = {
            expectation1.fulfill()
        }
        sut.updateUserLocation = { _ in }
        waitForExpectations(timeout: 1.0, handler: nil)
        
        let expectation2 = expectation(description: "Expect locationProvider.stopUpdateLocation() to be called")
        locationProvider.onStopUpdateLocation = {
            expectation2.fulfill()
        }
        sut.updateUserLocation = nil
        waitForExpectations(timeout: 1.0, handler: nil)
    }

}

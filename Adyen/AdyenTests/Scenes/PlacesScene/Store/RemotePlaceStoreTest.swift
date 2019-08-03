//
//  RemotePlaceStoreTest.swift
//  AdyenTests
//
//  Created by mohamed mohamed El Dehairy on 8/3/19.
//  Copyright © 2019 mohamed El Dehairy. All rights reserved.
//

import XCTest
import MapKit

class RemotePlaceStoreTest: XCTestCase {
    var sut: RemotePlaceStore!
    var clientApi: APIClientMock!
    
    override func setUp() {
        clientApi = APIClientMock()
        sut = RemotePlaceStore(clientApi: clientApi)
    }

    func test_success() {
        let expectedPlaces = (1...10).map { i in
            PlaceModel(id: "id_\(i)", name: "name \(i)", coordinate: CLLocationCoordinate2D(latitude: 52.3005591, longitude: 4.6844456), category: "category \(i)")
        }
        clientApi.onFetch = { _, _, completion in
            completion(.success(expectedPlaces))
            return NullCancelable()
        }
        
        let expectation1 = expectation(description: "Expect RemotePlaceStore completion closure to be called")
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 1, longitude: 2), latitudinalMeters: 2, longitudinalMeters: 3)
        sut.get(with: PlaceQuery(region: region, limit: 5)) { result in
            XCTAssertEqual(result.value, expectedPlaces)
            expectation1.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func test_failure() {
        clientApi.onFetch = { _, _, completion in
            completion(.failure(ErrorMock.anyError))
            return NullCancelable()
        }
        
        let expectation1 = expectation(description: "Expect RemotePlaceStore completion closure to be called")
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 1, longitude: 2), latitudinalMeters: 2, longitudinalMeters: 3)
        sut.get(with: PlaceQuery(region: region, limit: 5)) { result in
            XCTAssertEqual(result.error?.localizedDescription, ErrorMock.anyError.localizedDescription)
            expectation1.fulfill()
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }

}

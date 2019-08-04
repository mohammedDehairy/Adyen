//
//  DefaultAPIClientTest.swift
//  AdyenTests
//
//  Created by mohamed mohamed El Dehairy on 8/3/19.
//  Copyright © 2019 mohamed El Dehairy. All rights reserved.
//

import XCTest
import MapKit

class DefaultAPIClientTest: XCTestCase {
    var sut: DefaultAPIClient!
    var executer: RequestExecuterMock!
    
    override func setUp() {
        executer = RequestExecuterMock()
        sut = DefaultAPIClient(executer: executer)
    }

    func test_success() {
        let expectedPlaces = [
            PlaceModel(id: "587fb9ea25911e15b1056e8c", name: "Brute Burgers", coordinate: CLLocationCoordinate2D(latitude: 52.303954, longitude: 4.691842), category: "Burger Joint"),
            PlaceModel(id: "4f5f4a63e4b0028cfa222448", name: "CineMeerse", coordinate: CLLocationCoordinate2D(latitude: 52.30175696243503, longitude: 4.69554693601281), category: "Movie Theater"),
            PlaceModel(id: "581483c738fa25270f6a022d", name: "Jopenkerk Hoofddorp", coordinate: CLLocationCoordinate2D(latitude: 52.30211291653203, longitude: 4.6887681648385815), category: "Brewery")
        ]
        executer.onExecute = { _, completion in
            completion(.success(Data()), nil)
            return NullCancelable()
        }
        let resource = APIResource(request: URLRequest(url: URL(string: "https://www.google.com")!), parser: { _ in
            return .success(expectedPlaces)
        })
        let expectation = XCTestExpectation(description: "Expect DefaultAPIClient completion closure to be called")
        sut.fetch(resource: resource, deliverOn: DispatchQueue.main) { result in
            XCTAssertEqual(result.value, expectedPlaces)
            expectation.fulfill()
        }
    }

    func test_failure() {
        executer.onExecute = { _, completion in
            completion(.failure(ErrorMock.anyError), nil)
            return NullCancelable()
        }
        let resource = APIResource(request: URLRequest(url: URL(string: "https://www.google.com")!), parser: parse)
        let expectation = XCTestExpectation(description: "Expect DefaultAPIClient completion closure to be called")
        sut.fetch(resource: resource, deliverOn: DispatchQueue.main) { result in
            XCTAssertEqual(result.error?.localizedDescription, ErrorMock.anyError.localizedDescription)
            expectation.fulfill()
        }
    }
}

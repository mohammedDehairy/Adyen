//
//  PlaceStoreMock.swift
//  AdyenTests
//
//  Created by mohamed mohamed El Dehairy on 8/3/19.
//  Copyright © 2019 mohamed El Dehairy. All rights reserved.
//

import Foundation
import ClientAPI
import PlacesScene

final class PlaceStoreMock: PlaceStore {
    var onGet: ((PlaceQuery, ((Result<[PlaceModel], Error>) -> Void)) -> Cancelable)?
    func get(with query: PlaceQuery, completion: @escaping ((Result<[PlaceModel], Error>) -> Void)) -> Cancelable {
        return onGet?(query, completion) ?? NullCancelable()
    }
}

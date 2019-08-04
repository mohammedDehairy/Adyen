//
//  APIClientMock.swift
//  AdyenTests
//
//  Created by mohamed mohamed El Dehairy on 8/3/19.
//  Copyright © 2019 mohamed El Dehairy. All rights reserved.
//

import Foundation
import ClientAPI
import PlacesScene

final class APIClientMock: ClientAPI {
    var onFetch: ((APIResource<[PlaceModel]>, DispatchQueue, _ completion: @escaping ((Result<[PlaceModel], Error>) -> Void)) -> Cancelable)?
    func fetch<T>(resource: APIResource<T>, deliverOn: DispatchQueue, completion: @escaping ((Result<T, Error>) -> Void)) -> Cancelable {
        guard let resource = resource as? APIResource<[PlaceModel]> else {
            assertionFailure("Only PlaceModel is supported in the APIClientMock")
            return NullCancelable()
        }
        guard let completion = completion as? ((Result<[PlaceModel], Error>) -> Void) else {
            assertionFailure("Only PlaceModel is supported in the APIClientMock")
            return NullCancelable()
        }
        return onFetch?(resource, deliverOn, completion) ?? NullCancelable()
    }
}

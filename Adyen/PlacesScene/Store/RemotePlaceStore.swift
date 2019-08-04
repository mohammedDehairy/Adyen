//
//  DefaultPlaceStore.swift
//  Adyen
//
//  Created by mohamed mohamed El Dehairy on 8/3/19.
//  Copyright © 2019 mohamed El Dehairy. All rights reserved.
//

import Foundation
import MapKit
import ClientAPI

final public class RemotePlaceStore: PlaceStore {
    private let clientApi: ClientAPI
    private let environment: PlaceApiEnvironment
    
    public enum RemotePlaceStoreError: Error {
        case inValidUrl
    }
    
    public init(
        clientApi: ClientAPI,
        environment: PlaceApiEnvironment = PlaceApiEnvironment.default
    ) {
        self.clientApi = clientApi
        self.environment = environment
    }
    
    @discardableResult
    public func get(with query: PlaceQuery, completion: @escaping ((Result<[PlaceModel], Error>) -> Void)) -> Cancelable {
        let urlStr = RemotePlaceURLBuilder(environment: environment).build(query: query)
        guard let url = URL(string: urlStr) else {
            assertionFailure("URL is nil")
            completion(.failure(RemotePlaceStoreError.inValidUrl))
            return NullCancelable()
        }
        let request = URLRequest(url: url)
        let resource = APIResource(request: request, parser: parse)
        return clientApi.fetch(resource: resource, deliverOn: DispatchQueue.main, completion: completion)
    }
    
}

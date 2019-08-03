//
//  DefaultPlaceStore.swift
//  Adyen
//
//  Created by mohamed mohamed El Dehairy on 8/3/19.
//  Copyright © 2019 mohamed El Dehairy. All rights reserved.
//

import Foundation
import MapKit

final class RemotePlaceStore: PlaceStore {
    private let clientApi: APIClient
    
    enum RemotePlaceStoreError: Error {
        case inValidUrl
    }
    
    init(clientApi: APIClient) {
        self.clientApi = clientApi
    }
    
    @discardableResult
    func get(with query: PlaceQuery, completion: @escaping ((Result<[PlaceModel], Error>) -> Void)) -> Cancelable {
        let urlStr = RemotePlaceURLBuilder().build(query: query)
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

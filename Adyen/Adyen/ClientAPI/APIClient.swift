//
//  APIClient.swift
//  Adyen
//
//  Created by mohamed mohamed El Dehairy on 8/3/19.
//  Copyright © 2019 mohamed El Dehairy. All rights reserved.
//

import Foundation

protocol APIClient {
    func fetch<T>(resource: APIResource<T>, deliverOn: DispatchQueue, completion: @escaping ((Result<T, Error>) -> Void)) -> Cancelable
}

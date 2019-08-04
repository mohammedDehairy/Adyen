//
//  ClientAPI.swift
//  ClientAPI
//
//  Created by mohamed mohamed El Dehairy on 8/4/19.
//  Copyright © 2019 mohamed El Dehairy. All rights reserved.
//

import Foundation

public protocol ClientAPI {
    func fetch<T>(resource: APIResource<T>, deliverOn: DispatchQueue, completion: @escaping ((Result<T, Error>) -> Void)) -> Cancelable
}

//
//  APIResource.swift
//  Adyen
//
//  Created by mohamed mohamed El Dehairy on 8/3/19.
//  Copyright © 2019 mohamed El Dehairy. All rights reserved.
//

import Foundation

struct APIResource<T> {
    let request: URLRequest
    let parser: ((Data?) -> Result<T, Error>)
}

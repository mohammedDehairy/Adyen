//
//  APIResource.swift
//  Adyen
//
//  Created by mohamed mohamed El Dehairy on 8/3/19.
//  Copyright © 2019 mohamed El Dehairy. All rights reserved.
//

import Foundation

public struct APIResource<T> {
    public let request: URLRequest
    public let parser: ((Data?) -> Result<T, Error>)
    
    public init(request: URLRequest, parser: @escaping ((Data?) -> Result<T, Error>)) {
        self.request = request
        self.parser = parser
    }
}

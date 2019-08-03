//
//  RequestExecuter.swift
//  Adyen
//
//  Created by mohamed mohamed El Dehairy on 8/3/19.
//  Copyright © 2019 mohamed El Dehairy. All rights reserved.
//

import Foundation

protocol Cancelable {
    func cancel()
}

struct NullCancelable: Cancelable {
    func cancel() {}
}

extension URLSessionDataTask: Cancelable { }

protocol RequestExecuter {
    @discardableResult
    func execute(request: URLRequest, completion: @escaping ((Result<Data, Error>, URLResponse?) -> Void)) -> Cancelable
}

extension Result where Failure: Error {
    var error: Error? {
        switch self {
        case .success:
            return nil
        case .failure(let error):
            return error
        }
    }
    
    var value: Success? {
        switch self {
        case .success(let value):
            return value
        case .failure:
            return nil
        }
    }
}

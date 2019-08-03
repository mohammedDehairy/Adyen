//
//  DefaultRequestExecuter.swift
//  Adyen
//
//  Created by mohamed mohamed El Dehairy on 8/3/19.
//  Copyright © 2019 mohamed El Dehairy. All rights reserved.
//

import Foundation

extension URLSession: RequestExecuter {
    enum RequestExecuterError: Error {
        case nilData
    }
    
    func execute(request: URLRequest, completion: @escaping ((Result<Data, Error>, URLResponse?) -> Void)) -> Cancelable {
        let task = dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error), response)
                return
            } else if let data = data {
                completion(.success(data), response)
            } else {
                completion(.failure(RequestExecuterError.nilData), response)
            }
        }
        task.resume()
        return task
    }
}

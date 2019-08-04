//
//  DefaultAPIClient.swift
//  Adyen
//
//  Created by mohamed mohamed El Dehairy on 8/3/19.
//  Copyright © 2019 mohamed El Dehairy. All rights reserved.
//

import Foundation

final public class DefaultAPIClient: ClientAPI {
    private let executer: RequestExecuter
    
    public init(executer: RequestExecuter) {
        self.executer = executer
    }
    
    @discardableResult
    public func fetch<T>(resource: APIResource<T>, deliverOn: DispatchQueue, completion: @escaping ((Result<T, Error>) -> Void)) -> Cancelable {
        return executer.execute(request: resource.request) { result, response in
            deliverOn.async {
                if let error = result.error {
                    completion(.failure(error))
                } else {
                    completion(resource.parser(result.value))
                }
            }
        }
    }
}

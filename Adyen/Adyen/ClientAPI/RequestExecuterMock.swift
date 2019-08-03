//
//  RequestExecuterMock.swift
//  AdyenTests
//
//  Created by mohamed mohamed El Dehairy on 8/3/19.
//  Copyright © 2019 mohamed El Dehairy. All rights reserved.
//

import Foundation

final class RequestExecuterMock: RequestExecuter {
    var onExecute: ((URLRequest, ((Result<Data, Error>, URLResponse?) -> Void)) -> Cancelable)?
    func execute(request: URLRequest, completion: @escaping ((Result<Data, Error>, URLResponse?) -> Void)) -> Cancelable {
        return onExecute?(request, completion) ?? NullCancelable()
    }
}

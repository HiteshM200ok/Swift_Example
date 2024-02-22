//
//  NetWordmanager.swift
//  SwiftExample
//
//  Created by 200OK-IOS5 on 31/01/24.
//

import Foundation

enum NetworErrorMe: Error {
    case error(statusCode: Int?, data:Data?)
    case failure
    case notConnected
    case cancelled
}

protocol NetworkSessionManagerMe {
    typealias CompletionHandler = (Result<Data?, NetworErrorMe>) -> Void
    func request(_ endPoints: Requestable, completion:@escaping CompletionHandler) -> NetworkCancellable?
    func request(_ request: URLRequest,
                 completion: @escaping CompletionHandler) -> NetworkCancellable
}

final class NetWorkManager {
    
}



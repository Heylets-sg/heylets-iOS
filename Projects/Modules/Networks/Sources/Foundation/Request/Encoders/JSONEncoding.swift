//
//  JSONEncoding.swift
//  Networks
//
//  Created by 류희재 on 1/8/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

public protocol JSONEncodingType {
    func encode(_ request: URLRequest, with parameters: Encodable) -> AnyPublisher<URLRequest, HeyNetworkError.RequestError.ParameterEncodingError>
}

public struct JSONEncoding: JSONEncodingType {
    public init() {}
    
    public func encode(_ request: URLRequest, with parameters: Encodable) -> AnyPublisher<URLRequest, HeyNetworkError.RequestError.ParameterEncodingError> {
        
        return Just(request)
            .tryMap { request in
                var modifiedRequest = request
                
                do {
                    let data = try JSONEncoder().encode(parameters)
                    modifiedRequest.httpBody = data
                    return modifiedRequest
                } catch {
                    throw HeyNetworkError.RequestError.ParameterEncodingError.jsonEncodingFailed
                }
            }
            .mapError { _ in HeyNetworkError.RequestError.ParameterEncodingError.unknownErr }
            .eraseToAnyPublisher()
    }
}


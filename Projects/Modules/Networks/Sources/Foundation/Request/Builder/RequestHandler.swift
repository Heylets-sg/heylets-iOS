//
//  RequestHandler.swift
//  Networks
//
//  Created by 류희재 on 1/8/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

import Core

public struct RequestHandler {
    /// URLRequest 생성
    static public func createURLRequest<T: URLRequestTargetType>(for target: T) -> AnyPublisher<URLRequest, HMHNetworkError> {
        return target.asURLRequest()
            .mapError { ErrorHandler.handleRequestError($0) }
            .eraseToAnyPublisher()
    }
    
    /// 인터셉터 적용
    static public func applyInterceptorIfNeeded(_ urlRequest: URLRequest, for target: URLRequestTargetType) -> AnyPublisher<URLRequest, HMHNetworkError> {
        if target.isWithInterceptor {
            return TokenInterceptor.shared.adapt(urlRequest)
        } else {
            return Just(urlRequest)
                .setFailureType(to: HMHNetworkError.self)
                .eraseToAnyPublisher()
        }
    }
}





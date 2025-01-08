//
//  ErrorHandler.swift
//  Networks
//
//  Created by 류희재 on 1/8/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

public struct ErrorHandler {
    static public func handleDecodingError<T: Decodable>(data:Data, decodingType: T.Type, error: HeyNetworkError.DecodeError) -> HeyNetworkError {
        
        let decodingError: HeyNetworkError = .decodingFailed(error)
        NetworkLogHandler.responseDecodingError(data: data, decodingType: T.self, error: error)
        return decodingError
    }
    
    static public func handleRetryLimitExceeded() -> HeyNetworkError {
        let error: HeyNetworkError = .retryLimitExceeded
        NetworkLogHandler.tokenIntercepterRetryError(error: error)
        return error
    }
}

extension ErrorHandler {
    static public func handleRequestError(_ error: HeyNetworkError.RequestError) -> HeyNetworkError {
        let requestError: HeyNetworkError = .invalidRequest(error)
        return requestError
    }
    
    static public func handleParameterEncodingError(
        _ request: URLRequest,
        _ parameter: Any? = nil,
        error: HeyNetworkError.RequestError.ParameterEncodingError
    ) -> HeyNetworkError.RequestError {
        
        NetworkLogHandler.requestParameterEncodingError(request, parameter, error: error)
        return .parameterEncodingFailed(error)
    }
    
    static public func handleInvalidURLError<T: URLRequestTargetType>(
        _ target: T,
        error: HeyNetworkError.RequestError.URLValidationError
    ) -> AnyPublisher<URLRequest, HeyNetworkError.RequestError> {
        
        NetworkLogHandler.requestInvalidURLError(target, result: error)
        return Fail(error: .invalidURL(error)).eraseToAnyPublisher()
    }
}

extension ErrorHandler {
    static public func handleNoResponseError<T: URLRequestTargetType>(_ target: T, error: HeyNetworkError.ResponseError) -> HeyNetworkError {
        
        NetworkLogHandler.NoResponseError(target, error: error)
        return .invalidResponse(error)
    }
    
    static public func handleInvalidResponse(response: NetworkResponse) -> HeyNetworkError {
        let error: HeyNetworkError.ResponseError
        if let data = response.data {
            if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                error = .invalidStatusCode(code: response.response.statusCode, message: errorResponse.message)
            } else {
                error = .invalidStatusCode(code: response.response.statusCode)
            }
        } else {
            error = .noResponseData
        }
        
        NetworkLogHandler.invalidReponseError(response: response, error: error)
        return .invalidResponse(error)
    }
}


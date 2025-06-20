//
//  URLRequestTargetType.swift
//  Networks
//
//  Created by 류희재 on 1/8/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

public protocol URLRequestTargetType {
    var url: String { get }
    var path: String? { get }
    var method: HTTPMethod { get }
    var headers : [String : String]? { get }
    var task: NetworkTask { get }
    var isWithInterceptor: Bool { get }
    var connectWebHook: Bool { get }
    
    func asURLRequest() async -> AnyPublisher<URLRequest, HeyNetworkError.RequestError>
}

extension URLRequestTargetType {
    public func asURLRequest() -> AnyPublisher<URLRequest, HeyNetworkError.RequestError> {
        var finalURL = self.url

        if let path = self.path {
            finalURL = finalURL.trimmingCharacters(in: .whitespacesAndNewlines) + "/" + path.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
        switch URLValidator.validateURL(finalURL) {
        case .failure(let error):
            return ErrorHandler.handleInvalidURLError(self, error: error)
            
        case .success(let validURL):
            return task.buildRequest(baseURL: validURL, method: self.method, headers: self.headers)
        }
    }
}



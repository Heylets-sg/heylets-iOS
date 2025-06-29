//
//  Task.swift
//  Networks
//
//  Created by 류희재 on 1/8/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

public enum NetworkTask {
    case requestPlain
    case requestParameters(
        Parameters,
        urlencoder: URLEncodingType = URLEncoding()
    )
    
    case requestJSONEncodable(
        Encodable,
        jsonencoder: JSONEncodingType = JSONEncoding()
    )
    
    case uploadMultipartFormData(
        [MultipartData],
        String,
        multipartBodyBuilder: MultipartBodyBuilderType = MultipartBodyBuilder()
    )
}

extension NetworkTask {
    public func buildRequest(
        baseURL: URL,
        method: HTTPMethod,
        headers: [String: String]?
    ) -> AnyPublisher<URLRequest, HeyNetworkError.RequestError> {
        var request = URLRequest(url: baseURL)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        
        switch self {
        case .requestPlain:
            return Just(request)
                .setFailureType(to: HeyNetworkError.RequestError.self)
                .eraseToAnyPublisher()
            
        case .requestParameters(let parameters, let urlEncoder):
            return urlEncoder.encode(request, with: parameters)
                .mapError { ErrorHandler.handleParameterEncodingError(request, parameters, error: $0) }
                .eraseToAnyPublisher()
            
        case .requestJSONEncodable(let encodable, let jsonEncoder):
            return jsonEncoder.encode(request, with: encodable)
                .mapError { ErrorHandler.handleParameterEncodingError(request, encodable, error: $0) }
                .eraseToAnyPublisher()
            
        case .uploadMultipartFormData(let multipartData, let boundary, let multipartBuilder):
            return multipartBuilder.buildRequest(
                request,
                with: multipartData,
                boundary: boundary
            )
            .mapError { $0 }
            .eraseToAnyPublisher()
        }
    }
}

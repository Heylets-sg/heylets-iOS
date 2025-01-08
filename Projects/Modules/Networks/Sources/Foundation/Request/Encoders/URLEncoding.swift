//
//  URLEncoding.swift
//  Networks
//
//  Created by 류희재 on 1/8/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

public protocol URLEncodingType {
    func encode(_ request: URLRequest, with parameters: Parameters) -> AnyPublisher<URLRequest, HMHNetworkError.RequestError.ParameterEncodingError>
}

public struct URLEncoding: URLEncodingType {
    
    public init() {}
    
    public func encode(_ request: URLRequest, with parameters: Parameters) -> AnyPublisher<URLRequest, HMHNetworkError.RequestError.ParameterEncodingError> {
        return Just(request)
            .tryMap { request in
                // url을 사용하기 때문에 명시적으로 표시를 해주는게 안전하다고 생각함 (하지만 필요없는 구문임.. 고민중)
                // 다른 방법으로는 위에서 filter 걸어버리고 강제 옵셔널 처리하면 되긴함 (이게 더 끌리는데 안전하지 못하다는 아쉬움)
                guard let url = request.url else {
                    throw HMHNetworkError.RequestError.ParameterEncodingError.missingURL
                }
                
                guard !parameters.isEmpty else {
                    throw HMHNetworkError.RequestError.ParameterEncodingError.emptyParameters
                }
                
                if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) {
                    urlComponents.queryItems = parameters.map { key, value in
                        URLQueryItem(name: key, value: "\(value)")
                    }
                    var modifiedRequest = request
                    modifiedRequest.url = urlComponents.url
                    return modifiedRequest
                } else {
                    throw HMHNetworkError.RequestError.ParameterEncodingError.urlEncodingFailed
                }
            }
            .mapError { $0 as! HMHNetworkError.RequestError.ParameterEncodingError }
            .eraseToAnyPublisher()
        
    }
}




//
//  TokenInterceptor.swift
//  Networks
//
//  Created by 류희재 on 1/8/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine
import Core

actor TokenInterceptor {
    
    private var retryCnt = 0
    private var retryLimit = 3
    let cancelBag = CancelBag()
    
    static let shared = TokenInterceptor(
//        service: ReissueAPIService()
    )
    
//    private let service: ReissueAPIService
//    
//    private init(service: ReissueAPIService) {
//        self.service = service
//    }
    
    
    func adapt(_ request: URLRequest) -> AnyPublisher<URLRequest, HeyNetworkError> {
        return Just(request)
            .setFailureType(to: HeyNetworkError.self)
            .eraseToAnyPublisher()
    }
    
    
//    func retry(for session: URLSession) -> AnyPublisher<TokenResult, HeyNetworkError> {
//        NetworkLogHandler.tokenIntercepterRetryLogging(retryCnt: retryCnt)
//        self.retryCnt += 1
//        if retryCnt > retryLimit {
//            let error = ErrorHandler.handleRetryLimitExceeded()
//            retryCnt = 0
//            return Fail(error: error).eraseToAnyPublisher()
//        } else {
//            return service.tokenRefresh()
//        }
//    }
}


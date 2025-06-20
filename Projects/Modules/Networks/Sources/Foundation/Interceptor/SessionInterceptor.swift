//
//  SessionInterceptor.swift
//  Networks
//
//  Created by 류희재 on 1/8/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine
import Core

// 요청을 수정하는 Adapter 프로토콜

public protocol RequestAdapter {
    func adapt(_ urlRequest: URLRequest) -> AnyPublisher<URLRequest, HeyNetworkError>
}

// 실패한 요청을 재시도하는 Retrier 프로토콜

public protocol RequestRetrier {
    func retry(_ request: URLRequest, dueTo error: Error, retryCount: Int) -> AnyPublisher<Bool, Never>
}

// Adapter와 Retrier를 모두 구현하는 인터셉터 프로토콜
public protocol RequestInterceptor: RequestAdapter, RequestRetrier {}

// 세션 인터셉터 구현


public class SessionInterceptor: NSObject, URLSessionTaskDelegate, RequestInterceptor {
    private var retriers: [RequestRetrier] = []
    private var adapters: [RequestAdapter] = []
    
    // 싱글톤 인스턴스
    public static let shared = SessionInterceptor()
    
    private override init() {
        super.init()
    }
    
    // Adapter 및 Retrier 등록
    public func register(adapter: RequestAdapter) {
        adapters.append(adapter)
    }
    
    public func register(retrier: RequestRetrier) {
        retriers.append(retrier)
    }
    
    // RequestAdapter 프로토콜 구현
    public func adapt(_ urlRequest: URLRequest) -> AnyPublisher<URLRequest, HeyNetworkError> {
        // 등록된 모든 adapter를 순차적으로 적용
        return adapters.reduce(Just(urlRequest).setFailureType(to: HeyNetworkError.self).eraseToAnyPublisher()) { publisher, adapter in
            return publisher.flatMap { request in
                return adapter.adapt(request)
            }.eraseToAnyPublisher()
        }
    }
    
    // RequestRetrier 프로토콜 구현
    public func retry(_ request: URLRequest, dueTo error: Error, retryCount: Int) -> AnyPublisher<Bool, Never> {
        // 어떤 retrier라도 true를 반환하면 재시도 진행
        let initialPublisher = Just(false).eraseToAnyPublisher()
        
        return retriers.reduce(initialPublisher) { publisher, retrier in
            return publisher.flatMap { shouldRetry -> AnyPublisher<Bool, Never> in
                if shouldRetry {
                    return Just(true).eraseToAnyPublisher()
                } else {
                    return retrier.retry(request, dueTo: error, retryCount: retryCount)
                }
            }.eraseToAnyPublisher()
        }
    }
    
    // URLSessionTaskDelegate 구현
    nonisolated public func urlSession(_ session: URLSession,
                           task: URLSessionTask,
                           willPerformHTTPRedirection response: HTTPURLResponse,
                           newRequest request: URLRequest,
                           completionHandler: @escaping (URLRequest?) -> Void) {
        // 리다이렉션 처리 등의 추가 작업 가능
        completionHandler(request)
    }
}

// 토큰 어댑터 구현
public class TokenAdapter: @preconcurrency RequestAdapter {
    @MainActor public func adapt(_ urlRequest: URLRequest) -> AnyPublisher<URLRequest, HeyNetworkError> {
        var request = urlRequest
        
        // 액세스 토큰이 있으면 헤더에 추가
        if !SecureTokenStorage.getAccessToken().isEmpty {
            request.setValue(APIHeaders.accessToken, forHTTPHeaderField: APIHeaders.auth)
        }
        
        return Just(request)
            .setFailureType(to: HeyNetworkError.self)
            .eraseToAnyPublisher()
    }
}

// 토큰 갱신 Retrier 구현
public class TokenRetrier: @preconcurrency RequestRetrier {
    private let session: URLSession
    private var isRefreshing = false
    private var refreshPublisher: AnyPublisher<AuthResult, HeyNetworkError>?
    private var retryCount = 0
    private let maxRetryCount = 3
    
    public init(session: URLSession) {
        self.session = session
    }
    
    @MainActor public func retry(_ request: URLRequest, dueTo error: Error, retryCount: Int) -> AnyPublisher<Bool, Never> {
        self.retryCount = retryCount
        
        // 재시도 횟수 초과 체크
        guard retryCount < maxRetryCount else {
            NetworkLogHandler.tokenIntercepterRetryError(error: .retryLimitExceeded)
            return Just(false).eraseToAnyPublisher()
        }
        
        // 401 에러인지 확인
        let isUnauthorized = (error as? HeyNetworkError)?.isInvalidStatusCode() == 401
        
        if !isUnauthorized {
            return Just(false).eraseToAnyPublisher()
        }
        
        NetworkLogHandler.tokenIntercepterRetryLogging(retryCnt: retryCount)
        
        // 토큰 갱신 요청
        return refreshTokenIfNeeded()
            .map { _ in true }  // 토큰 갱신 성공하면 재시도 요청
            .catch { _ in Just(false) }
            .eraseToAnyPublisher()
    }
    
    @MainActor private func refreshTokenIfNeeded() -> AnyPublisher<AuthResult, HeyNetworkError> {
        // 이미 갱신 중이면 기존 publisher 반환
        if let publisher = refreshPublisher, isRefreshing {
            return publisher
        }
        
        isRefreshing = true
        
        // 토큰 갱신 요청 생성
        guard let url = URL(string: Config.baseURL + "/" + Paths.refreshToken) else {
            return Fail(error: .invalidRequest(.invalidURL(.invalidPath))).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.allHTTPHeaderFields = APIHeaders.headerWithRefreshToken
        
        // 토큰 갱신 요청 실행
        let publisher = session.dataTaskPublisher(for: request)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw HeyNetworkError.invalidResponse(.unhandled)
                }
                
                guard httpResponse.isValidateStatus() else {
                    throw HeyNetworkError.invalidResponse(.invalidStatusCode(code: httpResponse.statusCode))
                }
                
                return data
            }
            .decode(type: GenericResponse<AuthResult>.self, decoder: JSONDecoder())
            .map { $0.data! }
            .mapError { error -> HeyNetworkError in
                if let networkError = error as? HeyNetworkError {
                    return networkError
                }
                return .invalidResponse(.unhandled)
            }
            .handleEvents(
                receiveOutput: { tokenResult in
                    // 새 토큰 저장
                    SecureTokenStorage.setAuthTokens(
                        access: tokenResult.access_token,
                        refresh: tokenResult.refresh_token
                    )
                    self.isRefreshing = false
                    self.refreshPublisher = nil
                },
                receiveCompletion: { completion in
                    if case .failure = completion {
                        // 실패 시 토큰 초기화
                        SecureTokenStorage.clearAuthTokens()
                        self.isRefreshing = false
                        self.refreshPublisher = nil
                    }
                }
            )
            .share()
            .eraseToAnyPublisher()
        
        self.refreshPublisher = publisher
        return publisher
    }
}

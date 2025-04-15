//
//  NetworkLogHandler.swift
//  Networks
//
//  Created by 류희재 on 1/8/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public struct NetworkLogHandler {
    // MARK: - 상수
    private static let divider = "================================================================"
    private static let shortDivider = "--------------------------------"
    
    // MARK: - 디코딩 로깅 함수
    static func responseDecodingError<T: Decodable>(
        data: Data,
        decodingType: T.Type,
        error: HeyNetworkError.DecodeError
    ) {
        let jsonString = String(data: data, encoding: .utf8) ?? "Invalid Data"
        
        print("""
            
            \(divider)
            📥 응답 - 디코딩 오류
            \(shortDivider)
            ❌ 오류 유형: \(error.description)
            📋 예상 디코딩 타입: \(decodingType)
            🔍 오류 데이터: \(jsonString)
            \(divider)
            
            """)
    }
    
    static func tokenIntercepterRetryLogging(retryCnt: Int) {
        print("""
            
            \(divider)
            🔄 토큰 재시도 (\(retryCnt)/3)
            \(shortDivider)
            🔑 토큰이 만료되어 재시도 작업을 실행합니다.
            ⚠️ \(3-retryCnt)회 이후 요청 횟수 초과 오류가 발생합니다!
            \(divider)
            
            """)
    }
    
    static func tokenIntercepterRetryError(error: HeyNetworkError) {
        print("""
            
            \(divider)
            ❌ 토큰 재시도 오류
            \(shortDivider)
            🔴 오류 유형: \(error.description)
            \(divider)
            
            """)
    }
}

// MARK: - 네트워크 응답 로깅 함수
extension NetworkLogHandler {
    static func responseLogging(
        _ endpoint: URLRequestTargetType,
        result response: NetworkResponse
    ) {
        print("""
            
            \(divider)
            📥 응답 수신 완료
            \(shortDivider)
            📌 엔드포인트 정보:
              • URL: \(endpoint.url)
              • Path: \(endpoint.path ?? "없음")
              • Method: \(endpoint.method)
              • Headers: \(formatDictionary(endpoint.headers ?? [:]))
              • Task: \(endpoint.task)
            \(shortDivider)
            📊 응답 정보:
              • Status Code: \(response.response.statusCode)
              • 응답 데이터: \(String(data: response.data ?? Data(), encoding: .utf8) ?? "No data")
            \(divider)
            
            """)
    }
    
    static func NoResponseError(
        _ endpoint: URLRequestTargetType,
        error: HeyNetworkError.ResponseError
    ) {
        print("""
            
            \(divider)
            📤 네트워크 응답 오류
            \(shortDivider)
            ❌ 응답 없음
            🔴 오류 유형: \(error.description)
            📌 요청 정보:
              • URL: \(endpoint.url)
              • Path: \(endpoint.path ?? "없음")
            \(divider)
            
            """)
    }
    
    static func invalidReponseError(
        response: NetworkResponse,
        error: HeyNetworkError.ResponseError
    ) {
        print("""
            
            \(divider)
            📤 네트워크 응답 오류
            \(shortDivider)
            ❌ 잘못된 응답
            🔴 오류 유형: \(error.description)
            🔢 상태 코드: \(response.response.statusCode)
            📄 응답 데이터: \(String(data: response.data ?? Data(), encoding: .utf8) ?? "No data")
            \(divider)
            
            """)
    }
}

// MARK: - 네트워크 요청 로깅 함수
extension NetworkLogHandler {
    static func requestLogging(_ request: URLRequest) {
        let requestURL = request.url?.absoluteString ?? "없음"
        let requestHTTPmethod = request.httpMethod ?? "없음"
        let requestHeaders = request.allHTTPHeaderFields ?? [:]
        let parameters = extractParameters(from: request)
        
        print("""
            
            \(divider)
            📤 요청 전송
            \(shortDivider)
            🔗 URL: \(requestURL)
            🔤 HTTP Method: \(requestHTTPmethod)
            📋 Header: \(formatDictionary(requestHeaders))
            📦 Parameters: \(parameters != nil ? "\n\(formatAnyValue(parameters!))" : "없음")
            \(divider)
            
            """)
    }
    
    static func requestInvalidURLError(
        _ endpoint: any URLRequestTargetType,
        result error: HeyNetworkError.RequestError.URLValidationError
    ) {
        let url = endpoint.url + (endpoint.path ?? "")
        let method = endpoint.method
        let headers = endpoint.headers ?? [:]
        let task = endpoint.task
        
        print("""
            
            \(divider)
            📤 네트워크 요청 오류
            \(shortDivider)
            ❌ 잘못된 URL
            🔴 오류 유형: \(error.description)
            🔗 URL: \(url)
            🔤 Method: \(method)
            📋 Header: \(formatDictionary(headers))
            📦 Task: \(task)
            \(divider)
            
            """)
    }
    
    static func requestParameterEncodingError(
        _ request: URLRequest,
        _ parameter: Any? = nil,
        error: HeyNetworkError.RequestError.ParameterEncodingError
    ) {
        let url = request.url?.absoluteString ?? "없음"
        let method = request.httpMethod ?? "없음"
        let headers = request.allHTTPHeaderFields ?? [:]
        let parameterDescription = parameter.map { formatAnyValue($0) } ?? "없음"
        
        print("""
            
            \(divider)
            📤 네트워크 요청 오류
            \(shortDivider)
            ❌ 파라미터 인코딩 실패
            🔴 오류 유형: \(error.description)
            🔗 URL: \(url)
            🔤 Method: \(method)
            📋 Header: \(formatDictionary(headers))
            📦 Parameter: \(parameterDescription)
            \(divider)
            
            """)
    }
    
    // MARK: - 유틸리티 메소드
    
    /// 딕셔너리를 가독성 좋게 포맷팅
    private static func formatDictionary<K, V>(_ dict: [K: V]) -> String {
        if dict.isEmpty { return "없음" }
        
        let elements = dict.map { "\($0.key): \($0.value)" }
        return "[\n    " + elements.joined(separator: ",\n    ") + "\n]"
    }
    
    /// request에서 파라미터 추출
    private static func extractParameters(from request: URLRequest) -> Any? {
        // HTTP Body에서 파라미터 추출 시도
        if let httpBody = request.httpBody, let jsonObject = try? JSONSerialization.jsonObject(with: httpBody, options: []) {
            return jsonObject
        }
        
        // URL 쿼리 파라미터 추출 시도
        if let url = request.url, let components = URLComponents(url: url, resolvingAgainstBaseURL: false), let queryItems = components.queryItems, !queryItems.isEmpty {
            var queryParameters: [String: String] = [:]
            queryItems.forEach { queryItem in
                if let value = queryItem.value {
                    queryParameters[queryItem.name] = value
                }
            }
            return queryParameters
        }
        
        return nil
    }
    
    /// Any 타입 값을 가독성 좋게 포맷팅
    private static func formatAnyValue(_ value: Any) -> String {
        let mirror = Mirror(reflecting: value)
        
        if let dict = value as? [String: Any] {
            let elements = dict.map { "\"\($0.key)\": \(formatAnyValue($0.value))" }
            return "{\n    " + elements.joined(separator: ",\n    ") + "\n}"
        } else if let array = value as? [Any] {
            let elements = array.map { formatAnyValue($0) }
            return "[\n    " + elements.joined(separator: ",\n    ") + "\n]"
        } else if mirror.displayStyle == .class || mirror.displayStyle == .struct {
            return String(describing: value)
        } else {
            return "\(value)"
        }
    }
}

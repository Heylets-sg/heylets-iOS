//
//  MultipartBodyBuilder.swift
//  Networks
//
//  Created by 류희재 on 1/11/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

public protocol MultipartBodyBuilderType {
    func buildRequest(
        _ request: URLRequest,
        _ boundary: String,
        with multipartData: [MultipartFormData]
    ) -> AnyPublisher<URLRequest, HeyNetworkError.RequestError>
}

public class MultipartBodyBuilder: MultipartBodyBuilderType {
    public init() {}
    
    public func buildRequest(
        _ request: URLRequest,
        _ boundary: String = UUID().uuidString,
        with multipartData: [MultipartFormData]
    ) -> AnyPublisher<URLRequest, HeyNetworkError.RequestError> {
        return createMultipartBody(multipartData: multipartData, boundary: boundary)
            .tryMap { body in
                var request = request
                request.httpBody = body
                return request
            }
            .mapError { _ in .multipartFailed }
            .eraseToAnyPublisher()
    }
    
    /// 멀티파트 데이터 본문을 반환하는 Publisher
    private func createMultipartBody(
        multipartData: [MultipartFormData],
        boundary: String
    ) -> AnyPublisher<Data, HeyNetworkError.RequestError> {
        Just(multipartData)
            .tryMap { data in
                var body = Data()
                
                // 멀티파트 데이터를 body에 추가
                for part in data {
                    body.append("--\(boundary)\r\n".data(using: .utf8)!)
                    
                    if let filename = part.filename, let mimeType = part.mimeType {
                        body.append("Content-Disposition: form-data; name=\"\(part.name)\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
                        body.append("Content-Type: \(mimeType)\r\n\r\n".data(using: .utf8)!)
                    } else {
                        body.append("Content-Disposition: form-data; name=\"\(part.name)\"\r\n\r\n".data(using: .utf8)!)
                    }
                    
                    body.append(part.data)
                    body.append("\r\n".data(using: .utf8)!)
                }
                
                body.append("--\(boundary)--\r\n".data(using: .utf8)!)
                
                // 멀티파트 본문을 반환
                return body
            }
            .mapError { _ in .multipartFailed }
            .eraseToAnyPublisher()
    }
}

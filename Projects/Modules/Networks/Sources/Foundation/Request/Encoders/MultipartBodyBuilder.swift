//
//  MultipartBodyBuilder.swift
//  Networks
//
//  Created by 류희재 on 1/11/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

public struct MultipartData {
    let name: String
    let value: MultipartValue
    let contentType: String?
    
    enum MultipartValue {
        case text(String)
        case file(Data, String)
    }
}

public protocol MultipartBodyBuilderType {
    func buildRequest(
        _ request: URLRequest,
        with multipartData: [MultipartData],
        boundary: String
    ) -> AnyPublisher<URLRequest, HeyNetworkError.RequestError>
}

public class MultipartBodyBuilder: MultipartBodyBuilderType {
    public init() {}
    
    public func buildRequest(
        _ request: URLRequest,
        with multipartData: [MultipartData],
        boundary: String
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
        multipartData: [MultipartData],
        boundary: String
    ) -> AnyPublisher<Data, HeyNetworkError.RequestError> {
        Just(multipartData)
            .tryMap { data in
                var body = Data()
                
                // 멀티파트 데이터를 body에 추가
                for part in data {
                    body.append("--\(boundary)\r\n".data(using: .utf8)!)
                    
                    switch part.value {
                    case .text(let text):
                        body.append("Content-Disposition: form-data; name=\"\(part.name)\"\r\n".data(using: .utf8)!)
                        if let contentType = part.contentType {
                            body.append("Content-Type: \(contentType)\r\n".data(using: .utf8)!)
                        }
                        body.append("\r\n\(text)\r\n".data(using: .utf8)!)
                    case .file(let fileData, let fileName):
                        body.append("Content-Disposition: form-data; name=\"\(part.name)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
                        body.append("Content-Type: \(part.contentType ?? "application/octet-stream")\r\n\r\n".data(using: .utf8)!)
                        body.append(fileData)
                        body.append("\r\n".data(using: .utf8)!)
                    }
                }
                
                body.append("--\(boundary)--\r\n".data(using: .utf8)!)
                return body
            }
            .mapError { _ in .multipartFailed }
            .eraseToAnyPublisher()
    }
}

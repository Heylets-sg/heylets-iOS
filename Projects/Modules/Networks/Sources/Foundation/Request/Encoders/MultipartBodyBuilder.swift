//
//  MultipartBodyBuilder.swift
//  Networks
//
//  Created by 류희재 on 1/11/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

public enum MultipartFormData {
    case text(String, String)
    case file(name: String, filename: String, mimeType: String, fileData: Data)
}

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
        _ boundary: String,
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
                let requestData: [String: Any] = [
                    "nickname": "johndoe123",
                    "email": "student@u.nus.edu",
                    "password": "Password123!",
                    "university": "NUS",
                    "sex": "M",
                    "birth": "19960115"
                ]
                
                guard let jsonData = try? JSONSerialization.data(withJSONObject: requestData, options: []),
                      let jsonString = String(data: jsonData, encoding: .utf8) else {
                    print("JSON 데이터 생성 실패")
                    return body
                }
                
                
                // 멀티파트 데이터 생성
//                var body = Data()
                
                // request 필드 추가
                body.append("--\(boundary)\r\n".data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"request\"\r\n\r\n".data(using: .utf8)!)
                body.append("\(jsonString)\r\n".data(using: .utf8)!)
                
                // profileImage 필드 추가 (파일 대신 문자열로 예시)
                body.append("--\(boundary)\r\n".data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"profileImage\"\r\n\r\n".data(using: .utf8)!)
                body.append("string\r\n".data(using: .utf8)!)
                
                // 바운더리 종료
                body.append("--\(boundary)--\r\n".data(using: .utf8)!)
                
                return body
                
                
                
                // 멀티파트 데이터를 body에 추가
                //                for part in data {
                //                    body.append("--\(boundary)\r\n".data(using: .utf8)!)
                //
                //                    switch part {
                //                    case .text(let name, let value):
                //                        body.append("Content-Disposition: form-data; name=\(name)\r\n\r\n".data(using: .utf8)!)
                //                        body.append(value.data(using: .utf8)!)
                //
                //                    case .file(let name, let filename, let mimeType, let fileData):
                //                        body.append("Content-Disposition: form-data; name=\(name); filename=\(filename)\r\n".data(using: .utf8)!)
                //                        body.append("Content-Type: \(mimeType)\r\n\r\n".data(using: .utf8)!)
                //                        body.append(fileData)
                //                    }
                //
                //                    body.append("\r\n".data(using: .utf8)!)
                //                }
                //
                //                body.append("--\(boundary)--\r\n".data(using: .utf8)!)
                //
                //                // 멀티파트 본문을 반환
                //                dump("🎱 \(body)")
                //                return body
            }
            .mapError { _ in .multipartFailed }
            .eraseToAnyPublisher()
    }
}

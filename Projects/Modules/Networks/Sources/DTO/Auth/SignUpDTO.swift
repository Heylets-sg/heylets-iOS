//
//  SignUpDTO.swift
//  Networks
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public struct SignUpRequest: Encodable {
    let request: RequiredRequest
    let profileImg: Data?
    
    public init(request: RequiredRequest, profileImg: Data?) {
        self.request = request
        self.profileImg = profileImg
    }
}

public struct RequiredRequest: Encodable {
    let nickname: String
    let email: String
    let password: String
    let university: String
    let sex: String
    let birth: Int
    
    public init(
        nickname: String,
        email: String,
        password: String,
        university: String,
        sex: String,
        birth: Int
    ) {
        self.nickname = nickname
        self.email = email
        self.password = password
        self.university = university
        self.sex = sex
        self.birth = birth
    }
}

extension SignUpRequest {
    func toMultipart(_ boundary: String) -> Data {
        var body = Data()
        // JSON 파트 추가
        if let jsonData = try? JSONEncoder().encode(self.request),
           let jsonString = String(data: jsonData, encoding: .utf8) {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"request\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: application/json\r\n\r\n".data(using: .utf8)!)
            body.append("\(jsonString)\r\n".data(using: .utf8)!)
        }
        
        // 파일 파트 추가 (이미지가 있을 경우만)
        if let profileImg = profileImg {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"profileImage\"; filename=\"profile.png\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
            body.append(profileImg)
            body.append("\r\n".data(using: .utf8)!)
        }
        
        // 멀티파트 종료
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        return body
        
    }
}

//
//  GuestAPI.swift
//  Networks
//
//  Created by 류희재 on 2/18/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

import Domain

public enum GuestAPI {
    case changeGuestUniversity(UniversityRequest)
    case startGuestMode(String)
    case convertToMember(SignUpRequest, String)
}

extension GuestAPI: BaseAPI {
    public var isWithInterceptor: Bool {
        return false
    }
    
    public var path: String? {
        switch self {
        case .changeGuestUniversity:
            Paths.changeGuestUniversity
        case .startGuestMode(let university):
            Paths.startGuestMode
                .replacingOccurrences(
                    of: "{university}",
                    with: university
                )
        case .convertToMember:
            Paths.convertToMember
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .changeGuestUniversity:
            return .patch
        case .startGuestMode:
            return .post
        case .convertToMember:
            return .post
        }
    }
    
    public var task: Task {
        switch self {
        case .changeGuestUniversity(let request):
            return .requestJSONEncodable(request)
        case .startGuestMode:
            return .requestPlain
        case .convertToMember(let request, let boundary):
            var multipartData: [MultipartData] = []
            
            if let jsonData = try? JSONEncoder().encode(request.request),
               let jsonString = String(data: jsonData, encoding: .utf8) {
                let part: MultipartData = .init(
                    name: "request",
                    value: .text(jsonString),
                    contentType: "application/json"
                )
                multipartData.append(part)
            }
            
            // 프로필 이미지 추가
            if let profileImageData = request.profileImg {
                let part: MultipartData = .init(
                    name: "profileImage",
                    value: .file(profileImageData, "profile.jpeg"),
                    contentType: "image/jpeg"
                )
                multipartData.append(part)
            }
            
            return .uploadMultipartFormData(multipartData, boundary)
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .changeGuestUniversity:
            return APIHeaders.headerWithAccessToken
        case .startGuestMode:
            return APIHeaders.defaultHeader
        case .convertToMember:
            return APIHeaders.headerWithAccessToken
        }
    }
}

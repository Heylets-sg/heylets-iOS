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
    case startGuestMode(String, GuestAgreementRequest)
    case convertToMember(GuestSignUpRequest, String)
    case testConvertToMember(GuestSignUpRequest, String)
}

extension GuestAPI: BaseAPI {
    public var connectWebHook: Bool {
        switch self {
        case .convertToMember:
            return true
        default:
            return false
        }
    }
    
    public var isWithInterceptor: Bool {
        switch self {
        case .changeGuestUniversity, .convertToMember:
            return true
        default:
            return false
        }
    }
    
    public var path: String? {
        switch self {
        case .changeGuestUniversity:
            Paths.changeGuestUniversity
        case .startGuestMode(let university, _):
            Paths.startGuestMode
                .replacingOccurrences(
                    of: "{university}",
                    with: university
                )
        case .convertToMember:
            Paths.convertToMember
        case .testConvertToMember:
            Paths.testGuestSignUp
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
        case .testConvertToMember:
            return .post
        }
    }
    
    public var task: NetworkTask {
        switch self {
        case .changeGuestUniversity(let request):
            return .requestJSONEncodable(request)
        case .startGuestMode(_, let request):
            return .requestJSONEncodable(request)
            
        case .convertToMember(let request, let boundary), .testConvertToMember(let request, let boundary):
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
        case .convertToMember(_, let boundary):
            return APIHeaders.multipartGuestHeader(boundary)
        case .testConvertToMember(_, let boundary):
            return APIHeaders.testGuestHeader(boundary)
        }
    }
}

//
//  UserAPI.swift
//  Networks
//
//  Created by 류희재 on 1/8/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

import Domain

public enum UserAPI {
    case deleteProfileImg
    case getProfile
    case patchNickName(EditNameRequest)
    case patchAcademicInfo(AcademicDTO)
    case postProfileImg(profileImgRequest)
}

extension UserAPI: BaseAPI {
    public var connectWebHook: Bool {
        return false
    }
    
    public var isWithInterceptor: Bool {
        return true
    }
    
    public var path: String? {
        switch self {
        case .deleteProfileImg:
            return Paths.deleteProfileImg
        case .getProfile:
            return Paths.getProfile
        case .patchNickName:
            return Paths.patchNickName
        case .patchAcademicInfo:
            return Paths.patchAcademicInfo
        case .postProfileImg:
            return Paths.postProfileImg
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .deleteProfileImg:
            return .delete
        case .getProfile:
            return .get
        case .patchNickName:
            return .patch
        case .patchAcademicInfo:
            return .patch
        case .postProfileImg:
            return .post
        }
    }
    
    public var task: NetworkTask {
        switch self {
        case .deleteProfileImg:
            return .requestPlain
        case .getProfile:
            return .requestPlain
        case .patchNickName(let request):
            return .requestJSONEncodable(request)
        case .patchAcademicInfo(let request):
            return .requestJSONEncodable(request)
        case .postProfileImg:
            return .requestPlain
//            var multipartData: [MultipartFormData] = []
//            multipartData.append(.file(
//                name: "profileImage",
//                filename: "profile.jpg",
//                mimeType: "image/jpeg",
//                fileData: request.image
//            ))
//            
//            return .uploadMultipartFormData(multipartData)
        }
    }
    
    public var headers: [String : String]? {
        return APIHeaders.headerWithAccessToken
    }
}

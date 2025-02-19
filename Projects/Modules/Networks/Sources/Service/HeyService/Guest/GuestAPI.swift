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
    case convertToMember
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
        case .convertToMember:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .changeGuestUniversity:
            return APIHeaders.headerWithAccessToken
        case .startGuestMode:
            return APIHeaders.defaultHeader
        default:
            return APIHeaders.defaultHeader
            
        }
    }
}

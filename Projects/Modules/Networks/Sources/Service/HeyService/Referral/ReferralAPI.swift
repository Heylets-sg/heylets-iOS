//
//  ReferralAPI.swift
//  Networks
//
//  Created by 류희재 on 3/20/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

import Domain

public enum ReferralAPI {
    case getReferralCode
    case validateReferralCode(String)
}

extension ReferralAPI: BaseAPI {
    public var connectWebHook: Bool {
        return false
    }
    
    public var isWithInterceptor: Bool {
        return true
    }
    
    public var path: String? {
        switch self {
        case .getReferralCode:
            Paths.getReferralCode
        case .validateReferralCode:
            Paths.validateReferralCode
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .getReferralCode:
            return .get
        case .validateReferralCode:
            return .get
        }
    }
    
    public var task: NetworkTask {
        switch self {
        case .getReferralCode:
            return .requestPlain
        case .validateReferralCode(let code):
            return .requestParameters(["code": code])
            
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .getReferralCode:
            return APIHeaders.headerWithAccessToken
        case .validateReferralCode:
            return APIHeaders.defaultHeader
        }
    }
}



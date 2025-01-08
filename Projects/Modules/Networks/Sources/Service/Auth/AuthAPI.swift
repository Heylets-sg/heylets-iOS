//
//  AuthAPI.swift
//  Networks
//
//  Created by 류희재 on 1/8/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

import Domain

public enum AuthAPI {
    case checkUserName(String)
    case refreshToken
    case signUp
    case resetPassword
    case verifyResetPassword
    case requestResetPassword
    case logout
    case login
    case verifyEmail
    case requestVerifyEmail
}

extension AuthAPI: BaseAPI {
    public var isWithInterceptor: Bool {
        return false
    }
    
    public var path: String? {
        switch self {
        case .checkUserName:
            Paths.checkUserName
        case .refreshToken:
            Paths.refreshToken
        case .signUp:
            Paths.signUp
        case .resetPassword:
            Paths.resetPassword
        case .verifyResetPassword:
            Paths.verifyResetPassword
        case .requestResetPassword:
            Paths.requestResetPassword
        case .logout:
            Paths.logout
        case .login:
            Paths.login
        case .verifyEmail:
            Paths.verifyEmail
        case .requestVerifyEmail:
            Paths.requestVerifyEmail
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .checkUserName:
            return .get
        case .refreshToken:
            return .post
        case .signUp:
            return .post
        case .resetPassword:
            return .post
        case .verifyResetPassword:
            return .post
        case .requestResetPassword:
            return .post
        case .logout:
            return .post
        case .login:
            return .post
        case .verifyEmail:
            return .post
        case .requestVerifyEmail:
            return .post
        }
    }
    
    public var task: Task {
        switch self {
        case .checkUserName(let name):
            return .requestParameters(["username": name])
        case .refreshToken:
            <#code#>
        case .signUp:
            <#code#>
        case .resetPassword:
            <#code#>
        case .verifyResetPassword:
            <#code#>
        case .requestResetPassword:
            <#code#>
        case .logout:
            <#code#>
        case .login:
            <#code#>
        case .verifyEmail:
            <#code#>
        case .requestVerifyEmail:
            <#code#>
        }
    }
    
    public var headers: [String : String]? {
        switch self {
            
        }
    }
}



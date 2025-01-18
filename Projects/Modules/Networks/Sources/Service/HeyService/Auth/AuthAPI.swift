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
    //    case refreshToken
    case signUp(SignUpRequest, String)
    case resetPassword(ResetPasswordRequest)
    case verifyResetPassword(VerifyOTPCodeRequest)
    case requestResetPassword(RequestOTPCodeRequest)
    case logout
    case login(SignInRequest)
    case verifyEmail(VerifyOTPCodeRequest)
    case requestVerifyEmail(RequestOTPCodeRequest)
    case deleteAccount(DeleteAccountRequest)
}

extension AuthAPI: BaseAPI {
    public var isWithInterceptor: Bool {
        return false
    }
    
    public var path: String? {
        switch self {
        case .checkUserName:
            Paths.checkUserName
            //        case .refreshToken:
            //            Paths.refreshToken
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
        case .deleteAccount:
            Paths.deleteAccount
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .checkUserName:
            return .get
            //        case .refreshToken:
            //            return .post
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
        case .deleteAccount:
            return .post
        }
    }
    
    public var task: Task {
        switch self {
        case .checkUserName(let name):
            return .requestParameters(["username": name])
            //        case .refreshToken:
            //            <#code#>
        case .signUp(let request, let boundary):
            return .uploadMultipartFormData(request.toMultipart(boundary))
        case .resetPassword(let request):
            return .requestJSONEncodable(request)
        case .verifyResetPassword(let request):
            return .requestJSONEncodable(request)
        case .requestResetPassword(let request):
            return .requestJSONEncodable(request)
        case .logout:
            return .requestPlain
        case .login(let request):
            return .requestJSONEncodable(request)
        case .verifyEmail(let request):
            return .requestJSONEncodable(request)
        case .requestVerifyEmail(let request):
            return .requestJSONEncodable(request)
        case .deleteAccount(let request):
            return .requestJSONEncodable(request)
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .signUp(_, let boundary):
            return APIHeaders.multipartHeader(boundary)
        case .checkUserName, .login, .requestVerifyEmail, .verifyEmail, .resetPassword, .verifyResetPassword, .requestResetPassword:
            return APIHeaders.defaultHeader
        case .logout, .deleteAccount:
            return APIHeaders.headerWithAccessToken
        }
        
    }
}



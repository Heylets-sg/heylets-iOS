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
    case signUp(SignUpRequest)
    case resetPassword(ResetPasswordRequest)
    case verifyResetPassword(VerifyOTPCodeRequest)
    case requestResetPassword(RequestOTPCodeRequest)
    case logout
    case login(SignInRequest)
    case verifyEmail(VerifyOTPCodeRequest)
    case requestVerifyEmail(RequestOTPCodeRequest)
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
        }
    }
    func encodeToJSONString<T: Encodable>(_ value: T) throws -> String {
        let jsonData = try JSONEncoder().encode(value)
        guard let jsonString = String(data: jsonData, encoding: .utf8) else {
            throw HeyNetworkError.RequestError.multipartFailed
        }
        print("jsonString -> \(jsonString)")
        return jsonString
    }
    
    public var task: Task {
        switch self {
        case .checkUserName(let name):
            return .requestParameters(["username": name])
            //        case .refreshToken:
            //            <#code#>
        case .signUp(let request):
            var multipartData: [MultipartFormData] = 
            [
                .text("request", "{\"nickname\":\"\(request.requset.nickname)\",\"email\":\"\(request.requset.email)\",\"password\":\"\(request.requset.password)\",\"university\":\"\(request.requset.university)\",\"sex\":\"\(request.requset.sex)\",\"birth\":\"\(request.requset.birth)\"}")
            ]
            
            if let profileImage = request.profileImg {
                multipartData.append(.file(
                    name: "profileImage",
                    filename: "profile.jpg",
                    mimeType: "image/jpeg",
                    fileData: profileImage
                ))
            }
            return .uploadMultipartFormData(multipartData)
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
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .signUp:
            return APIHeaders.multipartHeader
        default:
            return APIHeaders.defaultHeader
        }
        
    }
}



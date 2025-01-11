//
//  APIHeaders.swift
//  Networks
//
//  Created by 류희재 on 1/8/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

import Core

public struct APIHeaders {
    static let contentType = "Content-Type"
    static let applicationJSON = "application/json"
    static let multiPart = "multipart/form-data"
    
    static let auth = "Authorization"
    
    static let deviceID_key = "Device-Id"
    static let deviceID_value = "ex) 1234abcd5678efgh"
    
    static let deviceModel_key = "Device-Model"
    static let deviceModel_value = "ex) SM-S918N"
    
    static let osVersion_key = "OS-Version"
    static let osVersion_value = "ex) 13"
    
    static let appVersion_key = "App-Version"
    static let appVersion_value = "ex) 1.0.0"
    
    static let xPlatform = "X-Platform"
    static let iOS = "IOS"
    
    
    static var accessToken: String {
        return "Bearer " /*+ (UserManager.shared.accessToken)*/
    }
    
    static var refreshToken: String {
        return "Bearer " /*+ (UserManager.shared.refreshToken)*/
    }
    
    static var appleAccessToken: String {
        return ""
//        return UserManager.shared.socialToken
    }

    
}

public extension APIHeaders {
    static var defaultHeader: [String:String] {
        return [
            contentType: applicationJSON,
            deviceID_key: deviceID_value,
            deviceModel_key: deviceModel_value,
            osVersion_key: osVersion_value,
            appVersion_key: appVersion_value,
            xPlatform: iOS,
        ]
    }
    
    static var multipartHeader: [String:String] {
        return [
            contentType: multiPart,
            deviceID_key: deviceID_value,
            deviceModel_key: deviceModel_value,
            osVersion_key: osVersion_value,
            appVersion_key: appVersion_value,
            xPlatform: iOS,
        ]
    }
}


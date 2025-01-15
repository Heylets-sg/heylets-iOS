//
//  APIHeaders.swift
//  Networks
//
//  Created by 류희재 on 1/8/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

import Core
import Domain

public struct APIHeaders {
    static let contentType = "Content-Type"
    static let applicationJSON = "application/json"
    static let multiPartFormData = "multipart/form-data; boundary=\("boundary")" //boundary 값 넣어줘야함
    
    
    
    static let auth = "Authorization"
    
    static let deviceID_key = "Device-Id"
    static let deviceID_value = AppService.getDeviceIdentifier()
    
    static let deviceModel_key = "Device-Model"
    static let deviceModel_value = AppService.getDeviceModelName()
    
    static let osVersion_key = "OS-Version"
    static let osVersion_value = AppService.getOSVersion()
    
    static let appVersion_key = "App-Version"
    static let appVersion_value = AppService.getLocalAppVersion()
    
    static let xPlatform = "X-Platform"
    static let iOS = "IOS"
    
//    static var accessToken: String {
////        return "Bearer \(UserDefaultsManager.shared.accessToken)"
//    }
    
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
            xPlatform: iOS
        ]
    }
    
    static var headerWithAccessToken: [String:String] {
        return [
            contentType: applicationJSON,
            deviceID_key: deviceID_value,
            deviceModel_key: deviceModel_value,
            osVersion_key: osVersion_value,
            appVersion_key: appVersion_value,
            xPlatform: iOS,
            auth: "Bearer eyJhbGciOiJIUzI1NiJ9.eyJpZCI6OTAsImRldmljZUlkIjoiRjlCNDMxMjItMzNFMC00QjFELTlGOTItMjhBRkMxMjhCNkI2IiwidHlwZSI6IkFDQ0VTUyIsImlhdCI6MTczNjk0MzAxMSwiZXhwIjoxNzM3MDI5NDExfQ.O0r3_3zrKE7sw5XqOiFZk4C4YB08siLkGURNunCR4VU"
        ]
    }
    
    static var multipartHeader: [String:String] {
        return [
            contentType: multiPartFormData,
            deviceID_key: deviceID_value,
            deviceModel_key: deviceModel_value,
            osVersion_key: osVersion_value,
            appVersion_key: appVersion_value,
            xPlatform: iOS,
        ]
    }
}


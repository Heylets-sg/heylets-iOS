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
    static let multiPartFormData = "multipart/form-data; "
    static let accept = "Accept"
    
    
    
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
    
    static var accessToken: String {
        return "Bearer \(UserDefaultsManager.heyAccessToken)"
    }
    
    static var refreshToken: String {
        return "Bearer \(UserDefaultsManager.heyRefreshToken)"
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
            appVersion_key: appVersion_value.versionString,
            xPlatform: iOS
        ]
    }
    
    static var headerWithAccessToken: [String:String] {
        return [
            contentType: applicationJSON,
            deviceID_key: deviceID_value,
            deviceModel_key: deviceModel_value,
            osVersion_key: osVersion_value,
            appVersion_key: appVersion_value.versionString,
            xPlatform: iOS,
            auth: accessToken
        ]
    }
    
    static func multipartHeader(_ boundary: String) -> [String:String] {
        return [
            contentType: multiPartFormData + "boundary=\(boundary)",
            accept: applicationJSON,
            deviceID_key: deviceID_value,
            deviceModel_key: deviceModel_value,
            osVersion_key: osVersion_value,
            appVersion_key: appVersion_value.versionString,
            xPlatform: iOS,
        ]
    }
}


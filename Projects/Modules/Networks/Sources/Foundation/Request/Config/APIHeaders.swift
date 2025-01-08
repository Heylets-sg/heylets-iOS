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
    
    static let auth = "Authorization"
    
    static let timezone = "Time-Zone"
    static let TIMEZONE = "Asia/Seoul"
    
    static let iOS = "iOS"
    
    static let deviceID = "Device-Id"
    static let dieviceModel = "Device-Model"
    static let osVersion = "OS-Version"
    static let appVersion = "App-Version"
    static let xPlatform = "X-Platform"
    static let pushToken = "Push-Token"
    
    
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
}


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
    
    static let os = "OS"
    static let iOS = "iOS"
    
    static var accessToken: String {
        return "Bearer " + (UserManager.shared.accessToken)
    }
    
    static var refreshToken: String {
        return "Bearer " + (UserManager.shared.refreshToken)
    }
    
    static var appleAccessToken: String {
        return UserManager.shared.socialToken
    }

    
}

public extension APIHeaders {
    static var noTokenHeader: Dictionary<String,String> {
        [contentType: applicationJSON]
    }
    
    static var hasSocialTokenHeader: [String:String] {
        return [
            contentType: applicationJSON,
            auth: appleAccessToken
        ]
    }
    
    static var hasTokenHeader: [String:String] {
        return [
            contentType: applicationJSON,
            auth: accessToken
        ]
    }
    
    static var hasTokenWithTimeZoneHeader: [String:String] {
        return [
            contentType: applicationJSON,
            auth: accessToken,
            timezone: TIMEZONE
        ]
    }
    
    static var hasTokenWithOSHeader: [String:String] {
        return [
            contentType: applicationJSON,
            auth: accessToken,
            os: iOS
        ]
    }
    
    static var hasTokenWithAllHeader: [String: String] {
        return [
            contentType: applicationJSON,
            auth: accessToken,
            os: iOS,
            timezone: TIMEZONE
        ]
    }
    
    static var hasAccessTokenHeader: [String: String] {
        return [
            contentType: applicationJSON,
            auth: accessToken
        ]
    }
    
    static var hasRefreshTokenHeader: [String: String] {
        return [
            contentType: applicationJSON,
            auth: refreshToken
        ]
    }
}


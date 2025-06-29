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
    
    static let deviceIDName = "Device-Id"
    static let deviceID = AppService.getDeviceIdentifier()
    
    static let deviceModelName = "Device-Model"
    static let deviceModel = AppService.getDeviceModelName()
    
    static let OSVersionName = "OS-Version"
    static let OSVersion = AppService.getOSVersion()
    
    static let appVersionName = "App-Version"
    static let appVersion = AppService.getLocalAppVersion()
    
    static let xPlatform = "X-Platform"
    static let iOS = "IOS"
    
    //MARK: Test용 삭제 필수
    static let xadminkeyName = "X-Admin-Key"
    static let xadminkey = "heylets-183ba62c-c51e-4d03-967e-0a95fe01a9fa"
    
    static var accessToken: String {
        return "Bearer \(SecureTokenStorage.getAccessToken())"
    }
    
    static let refreshTokenName = "Refresh-Token"
    static var refreshToken: String {
        return "Bearer \(SecureTokenStorage.getRefreshToken())"
    }
    
    static let pushTokenName = "Push-Token"
    static let pushToken = AppSettingsStorage.getFCMToken()
}

public extension APIHeaders {
    static var defaultHeader: [String:String] {
        return [
            contentType: applicationJSON,
            deviceIDName: deviceID,
            deviceModelName: deviceModel,
            OSVersionName: OSVersion,
            appVersionName: appVersion.versionString,
            xPlatform: iOS
        ]
    }
    
    //MARK: Test용 삭제 필수
    static func testHeader(_ boundary: String) -> [String:String] {
        return [
            xadminkeyName: xadminkey,
            contentType: multiPartFormData + "boundary=\(boundary)",
            deviceIDName: deviceID,
            deviceModelName: deviceModel,
            OSVersionName: OSVersion,
            appVersionName: appVersion.versionString,
            xPlatform: iOS
        ]
    }
    
    static func testGuestHeader(_ boundary: String) -> [String:String] {
        return [
            xadminkeyName: xadminkey,
            contentType: multiPartFormData + "boundary=\(boundary)",
            deviceIDName: deviceID,
            deviceModelName: deviceModel,
            OSVersionName: OSVersion,
            appVersionName: appVersion.versionString,
            xPlatform: iOS,
            auth: accessToken
        ]
    }
    
    static func multipartGuestHeader(_ boundary: String) -> [String:String] {
        return [
            contentType: multiPartFormData + "boundary=\(boundary)",
            accept: applicationJSON,
            deviceIDName: deviceID,
            deviceModelName: deviceModel,
            OSVersionName: OSVersion,
            appVersionName: appVersion.versionString,
            xPlatform: iOS,
            auth: accessToken
        ]
    }
    
    static func multipartHeader(_ boundary: String) -> [String:String] {
        return [
            contentType: multiPartFormData + "boundary=\(boundary)",
            accept: applicationJSON,
            deviceIDName: deviceID,
            deviceModelName: deviceModel,
            OSVersionName: OSVersion,
            appVersionName: appVersion.versionString,
            xPlatform: iOS,
            pushTokenName: pushToken
        ]
    }
    
    static var headerWithAccessToken: [String:String] {
        return [
            contentType: applicationJSON,
            deviceIDName: deviceID,
            deviceModelName: deviceModel,
            OSVersionName: OSVersion,
            appVersionName: appVersion.versionString,
            xPlatform: iOS,
            auth: accessToken,
            refreshTokenName: refreshToken,
            pushTokenName: pushToken
        ]
    }
    
    static var headerWithRefreshToken: [String:String] {
        return [
            contentType: applicationJSON,
            deviceIDName: deviceID,
            deviceModelName: deviceModel,
            OSVersionName: OSVersion,
            appVersionName: appVersion.versionString,
            xPlatform: iOS,
            refreshTokenName: refreshToken,
            pushTokenName: pushToken
        ]
    }
}

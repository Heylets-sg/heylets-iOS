//
//  UserDefaultsManager.swift
//  Networks
//
//  Created by 류희재 on 1/16/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

enum UserDefaultKeys: String, CaseIterable {
    case fcmToken
    case heyAccessToken
    case heyRefreshToken
    case email
    case password
}

public struct UserDefaultsManager {
    
    @UserDefaultWrapper<String>(key: UserDefaultKeys.fcmToken.rawValue, defaultValue: "none")
    static var fcmToken: String
    
    @UserDefaultWrapper<String>(key: UserDefaultKeys.heyAccessToken.rawValue, defaultValue: "")
    static var heyAccessToken: String
    
    @UserDefaultWrapper<String>(key: UserDefaultKeys.heyRefreshToken.rawValue, defaultValue: "")
    static var heyRefreshToken: String
    
    @UserDefaultWrapper<String>(key: UserDefaultKeys.email.rawValue, defaultValue: "이름없음")
    static var email: String
    
    @UserDefaultWrapper<String>(key: UserDefaultKeys.password.rawValue, defaultValue: "이름없음")
    static var password: String
}

extension UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    static func setToken(_ authInfo: AuthResult) {
        UserDefaultsManager.heyAccessToken = authInfo.access_token
        UserDefaultsManager.heyRefreshToken = authInfo.refresh_token
    }

    static func clearLogout() {
        UserDefaultsManager.heyAccessToken = ""
        UserDefaultsManager.heyRefreshToken = ""
    }
}

//
//  UserDefaultsManager.swift
//  Data
//
//  Created by 류희재 on 1/16/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Networks

extension UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    @MainActor
    static func setToken(_ authInfo: AuthResult) {
        UserDefaultsManager.heyAccessToken = authInfo.access_token
        UserDefaultsManager.heyRefreshToken = authInfo.refresh_token ?? ""
    }

    @MainActor
    static func clearToken() {
        UserDefaultsManager.heyAccessToken = ""
        UserDefaultsManager.heyRefreshToken = ""
    }
    
    @MainActor
    static func isTokenExist() -> Bool {
        return heyAccessToken != ""
    }
    
    @MainActor
    public static func setFCMTokne(_ fcmToken: String) {
        UserDefaultsManager.fcmToken = fcmToken
    }
}

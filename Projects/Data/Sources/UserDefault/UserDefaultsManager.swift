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
        UserDefaultsManager.setAccessToken(authInfo.access_token)
        UserDefaultsManager.setFCMToken(authInfo.refresh_token ?? "")
    }

    @MainActor
    static func clearToken() {
        UserDefaultsManager.setAccessToken("")
        UserDefaultsManager.setFCMToken("")
    }
    
    @MainActor
    static func isTokenExist() -> Bool {
        return UserDefaultsManager.getAccessToken() != ""
    }
    
    @MainActor
    public static func setFCMTokne(_ fcmToken: String) {
        UserDefaultsManager.setFCMToken(fcmToken)
    }
}

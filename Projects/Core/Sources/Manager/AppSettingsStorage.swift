//
//  AppSettingsStorage.swift
//  Data
//
//  Created by 류희재 on 6/20/25.
//

import Foundation

public struct AppSettingsStorage {
    private init() {}
    
    // MARK: - FCM 토큰
    public static func setFCMToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: "fcmToken")
    }
    
    public static func getFCMToken() -> String {
        UserDefaults.standard.string(forKey: "fcmToken") ?? ""
    }
    
    // MARK: - 게스트 모드
    public static func setGuestMode(_ isGuest: Bool) {
        UserDefaults.standard.set(isGuest, forKey: "isGuestMode")
    }
    
    public static func isGuestMode() -> Bool {
        UserDefaults.standard.bool(forKey: "isGuestMode")
    }
    
    // MARK: - 편의 메서드들
    public static func clearAllSettings() {
        UserDefaults.standard.removeObject(forKey: "fcmToken")
        UserDefaults.standard.removeObject(forKey: "isGuestMode")
        print("🗑️ 앱 설정 초기화 완료")
    }
}

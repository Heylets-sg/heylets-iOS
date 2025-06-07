//
//  UserDefaultsManager.swift
//  Networks
//
//  Created by 류희재 on 1/19/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

// UserDefault 키 정의
public enum UserDefaultKeys: String, CaseIterable {
    case fcmToken
    case heyAccessToken
    case heyRefreshToken
    case isGuestMode
}

// 프로퍼티 래퍼 정의
@propertyWrapper
public struct UserDefaultWrapper<T> {
    private let key: String
    private let defaultValue: T
    
    public init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    public var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

public struct UserDefaultsManager {
    public init() {}
    
    // 함수 기반 접근 - 프로퍼티 대신 함수 사용
    static public func getFCMToken() -> String {
        return UserDefaults.standard.string(forKey: UserDefaultKeys.fcmToken.rawValue) ?? "none"
    }
    
    static public func setFCMToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: UserDefaultKeys.fcmToken.rawValue)
    }
    
    static public func getAccessToken() -> String {
        return UserDefaults.standard.string(forKey: UserDefaultKeys.heyAccessToken.rawValue) ?? ""
    }
    
    static public func setAccessToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: UserDefaultKeys.heyAccessToken.rawValue)
    }
    
    static public func getRefreshToken() -> String {
        return UserDefaults.standard.string(forKey: UserDefaultKeys.heyRefreshToken.rawValue) ?? ""
    }
    
    static public func setRefreshToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: UserDefaultKeys.heyRefreshToken.rawValue)
    }
    
    static public func isGuestMode() -> Bool {
        return UserDefaults.standard.bool(forKey: UserDefaultKeys.isGuestMode.rawValue)
    }
    
    static public func setGuestMode(_ isGuest: Bool) {
        UserDefaults.standard.set(isGuest, forKey: UserDefaultKeys.isGuestMode.rawValue)
    }
    
    // 통합 헬퍼 메서드
    public static func setToken(_ token: AuthResult) {
        setAccessToken(token.access_token)
        setRefreshToken(token.refresh_token ?? "")
    }
    
    public static func clearToken() {
        setAccessToken("")
        setRefreshToken("")
    }
    
    public static func isTokenExist() -> Bool {
        return !getAccessToken().isEmpty
    }
}

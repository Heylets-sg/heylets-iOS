//
//  UserDefaultsManager.swift
//  Networks
//
//  Created by 류희재 on 1/19/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public enum UserDefaultKeys: String, CaseIterable {
    case fcmToken
    case heyAccessToken
    case heyRefreshToken
    case isGuestMode
}

public struct UserDefaultsManager {
    public init() {}
    
    @UserDefaultWrapper<String>(key: UserDefaultKeys.fcmToken.rawValue, defaultValue: "none")
    static public var fcmToken: String
    
    @UserDefaultWrapper<String>(key: UserDefaultKeys.heyAccessToken.rawValue, defaultValue: "")
    static public var heyAccessToken: String
    
    @UserDefaultWrapper<String>(key: UserDefaultKeys.heyRefreshToken.rawValue, defaultValue: "")
    static public var heyRefreshToken: String
    
    @UserDefaultWrapper<Bool>(key: UserDefaultKeys.isGuestMode.rawValue, defaultValue: false)
    static public var isGuestMode: Bool
}

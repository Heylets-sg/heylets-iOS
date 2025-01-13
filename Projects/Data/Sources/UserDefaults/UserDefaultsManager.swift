//
//  UserDefaultsManager.swift
//  Data
//
//  Created by 류희재 on 1/13/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

import Domain

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
    static public func getEmail() -> String { return email }
    
//    static func setUserInfo(_ data: UserInfo) {
//        let name = data.name ?? "이름없음"
//        let phoneLast = data.phone?.suffix(4) ?? "번호없음"
//        let nameWithPhone = name + "_" + phoneLast
//        UserDefaultsManager.userNameAndPhoneLast = nameWithPhone
//    }
//
//    static func reset() {
//
//        UserDefaultKeys.allCases.forEach { key in
//            guard key != .fcmToken else { return  }
//            guard key != .neverShowTutorial else { return  }
//            UserDefaults.standard.removeObject(forKey: key.rawValue)
//        }
//    }
}





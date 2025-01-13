////
////  NavigationDestination.swift
////  BaseFeatureDependency
////
////  Created by 류희재 on 12/19/24.
////  Copyright © 2024 Heylets-iOS. All rights reserved.
////
//

import Domain
import SwiftUI

public enum NavigationDestination: Hashable {
    // MyPage destinations
    case myPage
    case changePassword
    case privacyPolicy
    case termsOfService
    case contactUs
    case notificationSetting
    case deleteAccount
    
    // Onboarding destinations
    case onboarding
    case selectUniversity
    case verifyEmail(UserInfo)
    case enterSecurityCode(UserInfo?, String)
    case enterPersonalInfo(UserInfo)
    case enterIdPassword(UserInfo)
    case addProfile(UserInfo)
    case login
    case enterEmail
    case resetPassword
}

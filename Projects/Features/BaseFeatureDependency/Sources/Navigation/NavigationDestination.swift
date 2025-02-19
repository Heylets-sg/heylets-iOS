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
    case myPage(ProfileInfo)
    case changePassword
    case privacyPolicy
    case termsOfService
    case contactUs
    case notificationSetting
    case deleteAccount
    case editSchool
    
    // Onboarding destinations
    case onboarding
    case selectUniversity
    case verifyEmail
    case enterSecurityCode(VerifyCodeType, String)
    case enterPersonalInfo
    case enterIdPassword
    case addProfile
    case login
    case enterEmail
    case resetPassword(String)
    
    //Guest
    case selectGuestUniversity
    case termsOfServiceAgreement(String)
}

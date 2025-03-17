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
    // MyPage
    case myPage(ProfileInfo)
    case changePassword
    case privacyPolicy
    case termsOfService
    case contactUs
    case notificationSetting
    case deleteAccount
    case editSchool
    
    // Onboarding
    case onboarding
    
    // Sign Up
    case selectUniversity
    case verifyEmail
    case signUpEnterSecurityCode(String)
    case enterPersonalInfo
    case enterIdPassword
    
    // Log IN
    case login
    case resetPWVerifyEmail
    case resetEnterPWSecurityCode(String)
    case resetPassword(String)
    
    //Guest
    case selectGuestUniversity
    case termsOfServiceAgreement(String)
}

extension NavigationDestination {
    var screenName: String {
        switch self {
            
        // MyPage
            
        case .myPage:
            return "my_page"
        case .changePassword:
            return "change_pw"
        case .privacyPolicy:
            return  "privacy_policy"
        case .termsOfService:
            return "terms"
        case .contactUs:
            return ""
        case .notificationSetting:
            return "notification_setting"
        case .deleteAccount:
            return "delete_account"
            
        // Onboarding
        case .onboarding:
            return "onboarding"
            
        // Sign Up
        case .selectUniversity:
            return "select_school"
        case .verifyEmail:
            return "verify_email"
        case .signUpEnterSecurityCode:
            return "enter_security_code"
        case .enterPersonalInfo:
            return "enter_pll"
        case .enterIdPassword:
            return "enter_account_info"
        case .termsOfServiceAgreement:
            return "terms_of_service"
            
        // Log In
        case .login:
            return "log_in"
        case .resetPWVerifyEmail:
            return "reset_pw_verify_email"
        case .resetEnterPWSecurityCode:
            return "reset_pw_enter_security_code"
        case .resetPassword:
            return "reset_pw_verify_email"
            
        // Guest
        case .selectGuestUniversity:
            return "guest_select_school"
        case .editSchool:
            return "guest_edit_school"
        }
    }
}

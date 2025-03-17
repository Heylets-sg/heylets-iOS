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

//extension NavigationDestination {
//    var screenName: String {
//        switch self {
//        case .myPage(let profileInfo):
//            <#code#>
//        case .changePassword:
//            <#code#>
//        case .privacyPolicy:
//            <#code#>
//        case .termsOfService:
//            <#code#>
//        case .contactUs:
//            <#code#>
//        case .notificationSetting:
//            <#code#>
//        case .deleteAccount:
//            <#code#>
//        case .editSchool:
//            <#code#>
//        case .onboarding:
//            <#code#>
//        case .selectUniversity:
//            return "select_school"
//        case .verifyEmail:
//            return "verify_email"
//        case .signUpEnterSecurityCode:
//            return "enter_security_code"
//        case .enterPersonalInfo:
//            return "enter_pll"
//        case .enterIdPassword:
//            return "enter_account_info"
//        case .login:
//            return "log_in"
//        case .resetPWVerifyEmail:
//            return "reset_pw_verify_email"
//        case .resetPassword:
//            return "reset_pw_verify_email"
//        case .selectGuestUniversity:
//            <#code#>
//        case .termsOfServiceAgreement:
//            return "terms_of_service"
//        }
//    }
//}

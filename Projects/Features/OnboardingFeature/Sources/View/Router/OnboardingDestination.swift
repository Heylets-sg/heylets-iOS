//
//  OnboardingDestination.swift
//  OnboardingFeature
//
//  Created by 류희재 on 12/20/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import Foundation

public enum OnboardingDestination: Hashable {
    case onboarding
    
    //signup
    case selectUniversity
    case verifyEmail
    case enterSecurityCode
    case enterPersonalInfo
    case enterIdPassword
    case addProfile
    
    //signin
    case login
    case enterEmail
    case resetPassword
}

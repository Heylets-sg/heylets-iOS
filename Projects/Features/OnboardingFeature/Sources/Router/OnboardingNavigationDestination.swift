//
//  OnboardingNavigationDestination.swift
//  OnboardingFeature
//
//  Created by 류희재 on 12/20/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

public enum OnboardingNavigationDestination: Hashable {
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
import BaseFeatureDependency

struct OnboardingNavigationRoutingView: View {
    
    @EnvironmentObject var router: OnboardingNavigationRouter
    @State var destination: OnboardingNavigationDestination
    
    var body: some View {
        switch destination {
        case .onboarding:
            OnboardingView(
                viewModel: .init(
                    navigationRouter: router
                )
            )
            //MARK: SignUp
            
        case .selectUniversity:
            SelectUniversityView(
                viewModel: .init(
                    navigationRouter: router
                )
            )
        case .verifyEmail:
            VerifyEmailView(
                viewModel: .init(
                    navigationRouter: router
                )
            )
        case .enterSecurityCode:
            EnterSecurityCodeView(
                viewModel: .init(
                    navigationRouter: router
                )
            )
        case .enterPersonalInfo:
            EnterSecurityCodeView(
                viewModel: .init(
                    navigationRouter: router
                )
            )
        case .enterIdPassword:
            EnterIdPasswordView(
                viewModel: .init(
                    navigationRouter: router
                )
            )
        case .addProfile:
            AddProfileView(
                viewModel: .init(
                    navigationRouter: router
                )
            )
            
            //MARK: SignIn
            
        case .login:
            LogInView(
                viewModel: .init(
                    navigationRouter: router
                )
            )
        case .enterEmail:
            EnterEmailView(
                viewModel: .init(
                    navigationRouter: router
                )
            )
        case .resetPassword:
            ResetPasswordView(
                viewModel: .init(
                    navigationRouter: router
                )
            )
        }
    }
}
extension View {
    func setHeyNavigation() -> some View {
        self.navigationDestination(for: OnboardingNavigationDestination.self) { destination in
            OnboardingNavigationRoutingView(destination: destination)
        }
    }
}

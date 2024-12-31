//
//  OnboardingNavigationDestination.swift
//  OnboardingFeature
//
//  Created by 류희재 on 12/20/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

import BaseFeatureDependency

public enum OnboardingNavigationDestination: Hashable {
    case onboarding
    
    //signup
    case selectUniversity
    case verifyEmail(User)
    case enterSecurityCode(User)
    case enterPersonalInfo
    case enterIdPassword
    case addProfile
    
    //signin
    case login
    case enterEmail
    case resetPassword
}

struct OnboardingNavigationRoutingView: View {
    
    @EnvironmentObject var navigationRouter: OnboardingNavigationRouter
    @EnvironmentObject var router: Router
    @State var destination: OnboardingNavigationDestination
    
    var body: some View {
        switch destination {
        case .onboarding:
            OnboardingView(
                viewModel: .init(
                    navigationRouter: navigationRouter
                )
            )
            //MARK: SignUp
            
        case .selectUniversity:
            SelectUniversityView(
                viewModel: .init(
                    navigationRouter: navigationRouter
                )
            )
        case .verifyEmail(let user):
            VerifyEmailView(
                viewModel: .init(
                    navigationRouter: navigationRouter,
                    user: user
                )
            )
        case .enterSecurityCode(let user):
            EnterSecurityCodeView(
                viewModel: .init(
                    navigationRouter: navigationRouter,
                    user: user
                )
            )
        case .enterPersonalInfo:
            EnterPersonalInfoView(
                viewModel: .init(
                    navigationRouter: navigationRouter
                )
            )
        case .enterIdPassword:
            EnterIdPasswordView(
                viewModel: .init(
                    navigationRouter: navigationRouter
                )
            )
        case .addProfile:
            AddProfileView(
                viewModel: .init(
                    navigationRouter: navigationRouter
                )
            )
            
            //MARK: SignIn
            
        case .login:
            LogInView(
                viewModel: .init(
                    navigationRouter: navigationRouter, 
                    windowRouter: router.windowRouter
                )
            )
        case .enterEmail:
            EnterEmailView(
                viewModel: .init(
                    navigationRouter: navigationRouter
                )
            )
        case .resetPassword:
            ResetPasswordView(
                viewModel: .init(
                    navigationRouter: navigationRouter
                )
            )
        }
    }
}
extension View {
    func setOnboardingNavigation() -> some View {
        self.navigationDestination(for: OnboardingNavigationDestination.self) { destination in
            OnboardingNavigationRoutingView(destination: destination)
        }
    }
}

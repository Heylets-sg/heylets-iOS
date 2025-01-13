//
//  NavigationRoutingView.swift
//  Heylets-iOS
//
//  Created by 류희재 on 12/19/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//


import Foundation
import SwiftUI

import BaseFeatureDependency
import MyPageFeature
import OnboardingFeature
import TimeTableFeature

import Core
import Networks

struct NavigationRoutingView: View {
    @EnvironmentObject var container: DIContainer
    @State var destination: NavigationDestination
    
    var body: some View {
        switch destination {
            
        // MyPage Feature
        case .myPage:
            MyPageView(
                viewModel: .init(
                    navigationRouter: container.navigationRouter,
                    windowRouter: container.windowRouter
                )
            )
        case .changePassword:
            ChangePasswordView(
                viewModel: .init(navigationRouter: container.navigationRouter)
            )
        case .privacyPolicy:
            PrivacyPolicyView()
        case .termsOfService:
            TermsOfServiceView()
        case .contactUs:
            ContactUsView()
        case .notificationSetting:
            NotificationSettingView(
                viewModel: .init(navigationRouter: container.navigationRouter)
            )
        case .deleteAccount:
            DeleteAccountView(
                viewModel: .init(
                    navigationRouter: container.navigationRouter,
                    windowRouter: container.windowRouter
                )
            )
        
        // Onboarding Feature
        case .onboarding:
            OnboardingView(
                viewModel: .init(navigationRouter: container.navigationRouter)
            )
        case .selectUniversity:
            SelectUniversityView(
                viewModel: .init(navigationRouter: container.navigationRouter)
            )
        case .verifyEmail(let user):
            VerifyEmailView(
                viewModel: .init(
                    navigationRouter: container.navigationRouter,
                    user: user
                )
            )
        case .enterSecurityCode(let user, let email):
            EnterSecurityCodeView(
                viewModel: .init(
                    navigationRouter: container.navigationRouter,
                    user: user,
                    email: email
                )
            )
        case .enterPersonalInfo(let user):
            EnterPersonalInfoView(
                viewModel: .init(
                    navigationRouter: container.navigationRouter,
                    user: user
                )
            )
        case .enterIdPassword(let user):
            EnterIdPasswordView(
                viewModel: .init(
                    navigationRouter: container.navigationRouter,
                    user: user
                )
            )
        case .addProfile(let user):
            AddProfileView(
                viewModel: .init(
                    navigationRouter: container.navigationRouter,
                    user: user
                )
            )
        case .login:
            LogInView(
                viewModel: .init(
                    navigationRouter: container.navigationRouter,
                    windowRouter: container.windowRouter
                )
            )
        case .enterEmail:
            EnterEmailView(
                viewModel: .init(navigationRouter: container.navigationRouter)
            )
        case .resetPassword:
            ResetPasswordView(
                viewModel: .init(navigationRouter: container.navigationRouter)
            )
        }
    }
}

//extension View {
//    public func setHeyNavigation() -> some View {
//        self.navigationDestination(for: NavigationDestination.self) { destination in
//            NavigationRoutingView(destination: destination)
//        }
//    }
//}

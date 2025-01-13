import Foundation
import SwiftUI

import BaseFeatureDependency
import MyPageFeature
import OnboardingFeature
import TimeTableFeature

import Core
import Networks

struct OnboardingNavigationRoutingView: View {
    @EnvironmentObject var router: Router
    @State var destination: NavigationDestination
    
    var body: some View {
        switch destination {
        
        // Onboarding Feature
        case .onboarding:
            OnboardingView(
                viewModel: .init(navigationRouter: router.navigationRouter)
            )
        case .selectUniversity:
            SelectUniversityView(
                viewModel: .init(navigationRouter: router.navigationRouter)
            )
        case .verifyEmail(let user):
            VerifyEmailView(
                viewModel: .init(
                    navigationRouter: router.navigationRouter,
                    user: user
                )
            )
        case .enterSecurityCode(let user, let email):
            EnterSecurityCodeView(
                viewModel: .init(
                    navigationRouter: router.navigationRouter,
                    user: user,
                    email: email
                )
            )
        case .enterPersonalInfo(let user):
            EnterPersonalInfoView(
                viewModel: .init(
                    navigationRouter: router.navigationRouter,
                    user: user
                )
            )
        case .enterIdPassword(let user):
            EnterIdPasswordView(
                viewModel: .init(
                    navigationRouter: router.navigationRouter,
                    user: user
                )
            )
        case .addProfile(let user):
            AddProfileView(
                viewModel: .init(
                    navigationRouter: router.navigationRouter,
                    user: user
                )
            )
        case .login:
            LogInView(
                viewModel: .init(
                    navigationRouter: router.navigationRouter,
                    windowRouter: router.windowRouter
                )
            )
        case .enterEmail:
            EnterEmailView(
                viewModel: .init(navigationRouter: router.navigationRouter)
            )
        case .resetPassword:
            ResetPasswordView(
                viewModel: .init(navigationRouter: router.navigationRouter)
            )
            
        default:
            EmptyView()
        }
    }
}

extension View {
    public func setOnboardingHeyNavigation() -> some View {
        self.navigationDestination(for: NavigationDestination.self) { destination in
            OnboardingNavigationRoutingView(destination: destination)
        }
    }
}

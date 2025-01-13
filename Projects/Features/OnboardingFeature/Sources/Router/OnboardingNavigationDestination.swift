import Foundation
import SwiftUI

import BaseFeatureDependency
import MyPageFeature
import OnboardingFeature
import TimeTableFeature

import Core
import Networks

struct OnboardingNavigationRoutingView: View {
    @EnvironmentObject var container: DIContainer
    @State var destination: NavigationDestination
    
    var body: some View {
        switch destination {
        
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

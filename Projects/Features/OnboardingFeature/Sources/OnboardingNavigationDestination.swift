import Foundation
import SwiftUI

import BaseFeatureDependency
import Domain

import Core

struct OnboardingNavigationRoutingView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var useCase: HeyUseCase
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
                viewModel: .init(
                    navigationRouter: router.navigationRouter,
                    useCase: useCase.onboardingUseCase
                    
                )
            )
        case .verifyEmail:
            VerifyEmailView(
                viewModel: .init(
                    navigationRouter: router.navigationRouter,
                    useCase: useCase.onboardingUseCase
                )
            )
        case .enterSecurityCode(let type, let email):
            EnterSecurityCodeView(
                viewModel: .init(
                    navigationRouter: router.navigationRouter,
                    useCase: useCase.onboardingUseCase, 
                    type: type,
                    email: email
                )
            )
        case .enterPersonalInfo:
            EnterPersonalInfoView(
                viewModel: .init(
                    navigationRouter: router.navigationRouter,
                    useCase: useCase.onboardingUseCase
                )
            )
        case .enterIdPassword:
            EnterIdPasswordView(
                viewModel: .init(
                    navigationRouter: router.navigationRouter,
                    useCase: useCase.onboardingUseCase
                )
            )
        case .login:
            LogInView(
                viewModel: .init(
                    navigationRouter: router.navigationRouter,
                    windowRouter: router.windowRouter, 
                    useCase: useCase.onboardingUseCase
                )
            )
        case .enterEmail:
            EnterEmailView(
                viewModel: .init(
                    navigationRouter: router.navigationRouter, useCase: useCase.onboardingUseCase
                )
            )
        case .resetPassword(let email):
            ResetPasswordView(
                viewModel: .init(
                    navigationRouter: router.navigationRouter,
                    useCase: useCase.onboardingUseCase, 
                    email: email
                )
            )
        case .selectGuestUniversity:
            SelectGuestUnversityView(
                viewModel: .init(
                    navigationRouter: router.navigationRouter
                )
            )
        case .termsOfServiceAgreement(let university):
            TermsOfServiceView(
                viewModel: .init(
                    navigationRouter: router.navigationRouter,
                    windowRouter: router.windowRouter,
                    useCase: useCase.onboardingUseCase,
                    university: university
                )
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

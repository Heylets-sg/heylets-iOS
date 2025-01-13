import Foundation
import SwiftUI

import BaseFeatureDependency
import OnboardingFeature
import Domain

import Core
import Networks

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
        case .enterSecurityCode(let type):
            EnterSecurityCodeView(
                viewModel: .init(
                    navigationRouter: router.navigationRouter,
                    useCase: useCase.onboardingUseCase, 
                    type: type
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
        case .addProfile:
            AddProfileView(
                viewModel: .init(
                    navigationRouter: router.navigationRouter,
                    useCase: useCase.onboardingUseCase
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

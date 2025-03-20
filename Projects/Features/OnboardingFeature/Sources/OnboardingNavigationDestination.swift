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
        
        // Onboarding
        case .onboarding:
            OnboardingView(
                viewModel: .init(navigationRouter: router.navigationRouter)
            )
        case .selectUniversity:
            SelectUniversityView(
                viewModel: .init(
                    navigationRouter: router.navigationRouter,
                    useCase: useCase.signUpUseCase
                )
            )
        case .verifyEmail(let nationality):
            VerifyEmailView(
                viewModel: .init(
                    navigationRouter: router.navigationRouter,
                    useCase: useCase.signUpUseCase,
                    nationality: nationality
                )
            )
        case .signUpEnterSecurityCode(let email):
            EnterSecurityCodeView(
                viewModel: .init(
                    navigationRouter: router.navigationRouter,
                    useCase: useCase.signUpUseCase,
                    email: email
                )
            )
            
        // 싱가폴
        case .enterPersonalInfo_SG:
            SGEnterPersonalInfoView(
                viewModel: .init(
                    navigationRouter: router.navigationRouter,
                    useCase: useCase.signUpUseCase
                )
            )
        case .enterIdPassword:
            EnterIdPasswordView(
                viewModel: .init(
                    navigationRouter: router.navigationRouter,
                    useCase: useCase.signUpUseCase
                )
            )
        
        // 말레이시아
        case .enterPersonalInfo_MYS:
            MYSEnterPersonalInfoView(
                viewModel: .init(
                    navigationRouter: router.navigationRouter,
                    useCase: useCase.signUpUseCase
                )
            )
            
        case .enterReferralCode:
            EnterReferralCodeView(
                viewModel: .init(
                    navigationRouter: router.navigationRouter,
                    useCase: useCase.signUpUseCase
                )
            )
            
        // LogIn
        case .login:
            LogInView(
                viewModel: .init(
                    navigationRouter: router.navigationRouter,
                    windowRouter: router.windowRouter, 
                    useCase: useCase.signInUseCase
                )
            )
        case .resetPWVerifyEmail:
            ResetVerifyEmailView(
                viewModel: .init(
                    navigationRouter: router.navigationRouter, 
                    useCase: useCase.signInUseCase
                )
            )
        case .resetPassword(let email):
            ResetPasswordView(
                viewModel: .init(
                    navigationRouter: router.navigationRouter,
                    useCase: useCase.signInUseCase,
                    email: email
                )
            )
            
        case .resetEnterPWSecurityCode(let email):
            ResetEnterSecurityCodeView(viewModel: .init(
                    navigationRouter: router.navigationRouter,
                    useCase: useCase.signUpUseCase,
                    email: email
                )
            )
            
        case .selectNationality:
            SelectNationalityView(
                viewModel: .init(
                    navigationRouter: router.navigationRouter,
                    useCase: useCase.signUpUseCase
                )
            )
            
        case .selectGuestUniversity(let universityList):
            SelectGuestUnversityView(
                viewModel: .init(
                    navigationRouter: router.navigationRouter,
                    universityList: universityList
                )
            )
        case .termsOfServiceAgreement(let university):
            TermsOfServiceView(
                viewModel: .init(
                    navigationRouter: router.navigationRouter,
                    windowRouter: router.windowRouter,
                    useCase: useCase.signUpUseCase,
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

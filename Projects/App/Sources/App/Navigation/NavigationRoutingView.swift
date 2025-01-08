////
////  NavigationRoutingView.swift
////  Heylets-iOS
////
////  Created by 류희재 on 12/19/24.
////  Copyright © 2024 Heylets-iOS. All rights reserved.
////
//
//
//import Foundation
//import SwiftUI
//
//import BaseFeatureDependency
//import MyPageFeature
//import OnboardingFeature
//import TimeTableFeature
//
//import Core
//
//struct NavigationRoutingView: View {
//    
//    @EnvironmentObject var router: Router
//    @State var destination: NavigationDestination
//    
//    var body: some View {
//        switch destination {
//        case .onboarding:
//            OnboardingView(
//                viewModel: .init(
//                    navigationRouter: router.navigationRouter
//                )
//            )
//            //MARK: SignUp
//            
//        case .selectUniversity:
//            SelectUniversityView(
//                viewModel: .init(
//                    navigationRouter: router.navigationRouter
//                )
//            )
//        case .verifyEmail:
//            VerifyEmailView(
//                viewModel: .init(
//                    navigationRouter: router.navigationRouter
//                )
//            )
//        case .enterSecurityCode:
//            EnterSecurityCodeView(
//                viewModel: .init(
//                    navigationRouter: router.navigationRouter
//                )
//            )
//        case .enterPersonalInfo:
//            EnterSecurityCodeView(
//                viewModel: .init(
//                    navigationRouter: router.navigationRouter
//                )
//            )
//        case .enterIdPassword:
//            EnterIdPasswordView(
//                viewModel: .init(
//                    navigationRouter: router.navigationRouter
//                )
//            )
//        case .addProfile:
//            AddProfileView(
//                viewModel: .init(
//                    navigationRouter: router.navigationRouter
//                )
//            )
//            
//            //MARK: SignIn
//            
//        case .login:
//            LogInView(
//                viewModel: .init(
//                    navigationRouter: router.navigationRouter
//                )
//            )
//        case .enterEmail:
//            EnterEmailView(
//                viewModel: .init(
//                    navigationRouter: router.navigationRouter
//                )
//            )
//        case .resetPassword:
//            ResetPasswordView(
//                viewModel: .init(
//                    navigationRouter: router.navigationRouter
//                )
//            )
//        }
//    }
//}
//extension View {
//    func setHeyNavigation() -> some View {
//        self.navigationDestination(for: NavigationDestination.self) { destination in
//            NavigationRoutingView(destination: destination)
//        }
//    }
//}

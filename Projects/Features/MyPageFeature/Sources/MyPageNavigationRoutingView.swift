//
//  MyPageNavigationDestination.swift
//  MyPageFeature
//
//  Created by 류희재 on 12/26/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

import Core
import BaseFeatureDependency
import Domain

struct MyPageNavigationRoutingView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var useCase: HeyUseCase
    @State var destination: NavigationDestination
    
    var body: some View {
        switch destination {
        case .myPage:
            MyPageView(
                viewModel: .init(
                    navigationRouter: router.navigationRouter,
                    windowRouter: router.windowRouter,
                    useCase: useCase.myPageUseCase
                )
            )
        case .changePassword:
            ChangePasswordView(
                viewModel: .init(
                    navigationRouter: router.navigationRouter,
                    useCase: useCase.myPageUseCase
                )
            )
        case .privacyPolicy:
            PrivacyPolicyView()
        case .termsOfService:
            TermsOfServiceView()
        case .contactUs:
            ContactUsView()
        case .notificationSetting:
            NotificationSettingView(
                viewModel: .init(
                    useCase: useCase.myPageUseCase,
                    navigationRouter: router.navigationRouter
                )
            )
        case .deleteAccount:
            DeleteAccountView(
                viewModel: .init(
                    useCase: useCase.myPageUseCase,
                    navigationRouter: router.navigationRouter,
                    windowRouter: router.windowRouter
                )
            )
            
        case .editSchool(let nationality):
            EditSchoolView(
                viewModel: .init(
                    navigationRouter: router.navigationRouter,
                    useCase: useCase.myPageUseCase,
                    nationality: nationality
                )
            )
        default:
            EmptyView()
        }
    }
}

extension View {
    public func setMypageNavigation() -> some View {
        self.navigationDestination(for: NavigationDestination.self) { destination in
            MyPageNavigationRoutingView(destination: destination)
        }
    }
}

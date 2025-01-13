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

struct MyPageNavigationRoutingView: View {
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

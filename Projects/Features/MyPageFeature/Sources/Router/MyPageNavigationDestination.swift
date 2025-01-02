//
//  MyPageNavigationDestination.swift
//  MyPageFeature
//
//  Created by 류희재 on 12/26/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

import BaseFeatureDependency

public enum MyPageNavigationDestination: Hashable {
    case myPage
    
    case changePassword
    
    case privacyPolicy
    case termsOfService
    case contactUs
    
    case notificationSetting
    
    case deleteAccount
}

struct MyPageNavigationRoutingView: View {
    
    @EnvironmentObject var router: MyPageNavigationRouter
    @State var destination: MyPageNavigationDestination
    
    var body: some View {
        switch destination {
        case .myPage:
            MyPageView(viewModel: .init(navigationRouter: router))
        case .changePassword:
            ChangePasswordView(viewModel: .init(navigationRouter: router))
        case .privacyPolicy:
            PrivacyPolicyView()
        case .termsOfService:
            TermsOfServiceView()
        case .contactUs:
            ContactUsView()
        case .notificationSetting:
            NotificationSettingView(viewModel: .init(navigationRouter: router))
        case .deleteAccount:
            DeleteAccountView()
        }
    }
}

extension View {
    func setMyPageNavigation() -> some View {
        self.navigationDestination(for: MyPageNavigationDestination.self) { destination in
            MyPageNavigationRoutingView(destination: destination)
        }
    }
}

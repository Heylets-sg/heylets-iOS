//
//  MyPageViewModel.swift
//  MyPageFeature
//
//  Created by 류희재 on 12/26/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

import BaseFeatureDependency

public class MyPageViewModel: ObservableObject {
    var logOutAlertViewIsPresented: Bool = false
    
    enum Action {
        case changePasswordButtonDidTap
        case privacyPolicyButtonDidTap
        case termsOfServiceButtonDidTap
        case contactUsButtonDidTap
        case notificationSettingButtonDidTap
        case deleteAccountButtonDidTap
        case logoutButtonDidTap
    }
    
    public var navigationRouter: MyPageNavigationRouter
    
    public init(navigationRouter: MyPageNavigationRouter) {
        self.navigationRouter = navigationRouter
        print(navigationRouter.destinations)
    }
    
    func send(_ action: Action) {
        switch action {
        case .changePasswordButtonDidTap:
            navigationRouter.push(to: .changePassword)
        case .privacyPolicyButtonDidTap:
            navigationRouter.push(to: .privacyPolicy)
        case .termsOfServiceButtonDidTap:
            navigationRouter.push(to: .termsOfService)
        case .contactUsButtonDidTap:
            navigationRouter.push(to: .contactUs)
        case .notificationSettingButtonDidTap:
            navigationRouter.push(to: .notificationSetting)
        case .deleteAccountButtonDidTap:
            navigationRouter.push(to: .deleteAccount)
        case .logoutButtonDidTap:
            logOutAlertViewIsPresented = true
        }

    }
}

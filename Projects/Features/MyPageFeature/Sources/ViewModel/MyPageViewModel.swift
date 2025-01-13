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
import Domain
import Core

public class MyPageViewModel: ObservableObject {
    struct State {
        var logoutAlertViewIsPresented: Bool = false
    }
    
    enum Action {
        case changePasswordButtonDidTap
        case privacyPolicyButtonDidTap
        case termsOfServiceButtonDidTap
        case contactUsButtonDidTap
        case notificationSettingButtonDidTap
        case deleteAccountButtonDidTap
        
        case logout
        case logoutButtonDidTap
        case dismissLogoutAlertView
    }
    
    @Published var state = State()
    public var navigationRouter: NavigationRoutableType
    public var windowRouter: WindowRoutableType
    private let useCase: MyPageUseCaseType
    
    public init(
        navigationRouter: NavigationRoutableType,
        windowRouter: WindowRoutableType,
        useCase: MyPageUseCaseType
    ) {
        self.navigationRouter = navigationRouter
        self.windowRouter = windowRouter
        self.useCase = useCase
    }
    
    private let cancelBag = CancelBag()
    
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
            state.logoutAlertViewIsPresented = true
        case .logout:
            //TODO: 로그아웃 API
            useCase.logout()
                .sink(receiveValue: { [weak self] _ in
                    self?.windowRouter.switch(to: .onboarding)
                }).store(in: cancelBag)
            
            
        case .dismissLogoutAlertView:
            state.logoutAlertViewIsPresented = false
        }
        
    }
}

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
        case onAppear
        
        case changePasswordButtonDidTap
        case privacyPolicyButtonDidTap
        case termsOfServiceButtonDidTap
        case contactUsButtonDidTap
        case notificationSettingButtonDidTap
        case deleteAccountButtonDidTap
        
        case signUpLogInButtonDidTap
        case editSchoolButtonDidTap
        
        case logout
        case logoutButtonDidTap
        case dismissLogoutAlertView
    }
    
    @Published var state = State()
    public var navigationRouter: NavigationRoutableType
    public var windowRouter: WindowRoutableType
    private let useCase: MyPageUseCaseType
    @Published var profileInfo: ProfileInfo = .init()
    @Published var isGuestMode: Bool = false
    
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
        case .onAppear:
            useCase.checkGuesetMode()
                .receive(on: RunLoop.main)
                .handleEvents(receiveOutput: { [weak self] isGuestMode in
                    print("isGuestMode: \(isGuestMode)")
                    self?.isGuestMode = isGuestMode
                })
                .map { _ in }
                .flatMap(useCase.getProfile)
                .receive(on: RunLoop.main)
                .assign(to: \.profileInfo, on: self)
                .store(in: cancelBag)
            
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
            useCase.logout()
                .receive(on: RunLoop.main)
                .sink(receiveValue: { [weak self] _ in
                    self?.windowRouter.switch(to: .onboarding)
                }).store(in: cancelBag)
            
        case .dismissLogoutAlertView:
            state.logoutAlertViewIsPresented = false
            
        case .signUpLogInButtonDidTap:
            windowRouter.switch(to: .login)
            
        case .editSchoolButtonDidTap:
            navigationRouter.push(to: .editSchool)
        }
    }
}

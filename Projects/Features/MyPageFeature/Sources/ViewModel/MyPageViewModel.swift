//
//  MyPageViewModel.swift
//  MyPageFeature
//
//  Created by 류희재 on 12/26/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import UIKit
import Combine


import BaseFeatureDependency
import Domain
import Core


public class MyPageViewModel: ObservableObject {
    struct State {
        var referralCodeViewHidden: Bool = false
        var logoutAlertViewIsPresented: Bool = false
        var isLoading: Bool = false
    }
    
    enum Action {
        case onAppear
        
        case changePasswordButtonDidTap
        case privacyPolicyButtonDidTap
        case termsOfServiceButtonDidTap
        case contactUsButtonDidTap
        case notificationSettingButtonDidTap
        case deleteAccountButtonDidTap
        case copyReferralCodeButtonDidTap
        
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
    @Published var referralCode: String = ""
    @Published var isGuestMode: Bool = false
    
    public init(
        navigationRouter: NavigationRoutableType,
        windowRouter: WindowRoutableType,
        useCase: MyPageUseCaseType
    ) {
        self.navigationRouter = navigationRouter
        self.windowRouter = windowRouter
        self.useCase = useCase
        
        observe()
    }
    
    private let cancelBag = CancelBag()
    
    func send(_ action: Action) {
        switch action {
        case .onAppear:
            useCase.checkGuesetMode()
                .receive(on: RunLoop.main)
                .handleEvents(receiveOutput: { [weak self] isGuestMode in
                    self?.isGuestMode = isGuestMode
                })
                .map { _ in }
                .flatMap(useCase.getProfile)
                .receive(on: RunLoop.main)
                .handleEvents(receiveOutput: { [weak self] profileInfo in
                    self?.profileInfo = profileInfo
                })
                .filter { $0.university.nationality == .Malaysia }
                .map { _ in }
                .flatMap(useCase.getReferralCode)
                .receive(on: RunLoop.main)
                .assignLoading(to: \.state.isLoading, on: self)
                .assign(to: \.referralCode, on: self)
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
            Analytics.shared.track(.clickDeleteAccount)
            navigationRouter.push(to: .deleteAccount)
            
        case .logoutButtonDidTap:
            Analytics.shared.track(.clickLogOut)
            state.logoutAlertViewIsPresented = true
            
        case .copyReferralCodeButtonDidTap:
            UIPasteboard.general.string = referralCode
            
        case .logout:
            print("🏡")
            useCase.logout()
                .receive(on: RunLoop.main)
                .sink(receiveValue: { [weak self] _ in
                    Analytics.shared.track(.userLoggedOut)
                    self?.navigationRouter.destinations = []
                    self?.windowRouter.switch(to: .login)
                }).store(in: cancelBag)
            
        case .dismissLogoutAlertView:
            state.logoutAlertViewIsPresented = false
            
        case .signUpLogInButtonDidTap:
            windowRouter.switch(to: .login)
            
        case .editSchoolButtonDidTap:
            navigationRouter.push(to: .editSchool(profileInfo.university.nationality))
        }
    }
    
    private func observe() {
        $referralCode
            .receive(on: RunLoop.main)
            .map { $0.isEmpty }
            .assign(to: \.state.referralCodeViewHidden, on: self)
            .store(in: cancelBag)
    }
}

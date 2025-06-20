//
//  LogInViewModel.swift
//  OnboardingFeature
//
//  Created by 류희재 on 12/19/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

import BaseFeatureDependency
import Domain
import Core

public class LogInViewModel: ObservableObject {
    
    enum Action {
        case onAppear
        case closeButtonDidTap
        case loginButtonDidTap
        case dismissToastView
        case forgotPasswordButtonDidTap
        case signUpButtonDidTap
    }
    
    struct State {
        var loginButtonEnabled = true
        var errMessage: String = ""
        var showToast: Bool { return !errMessage.isEmpty }
        var showCloseBtn: Bool = false
        var isLoading = false
    }
    
    @Published var id: String = ""
    @Published var password: String = ""
    
    @Published var state = State()
    public var navigationRouter: NavigationRoutableType
    public var windowRouter: WindowRoutableType
    private var useCase: SignInUseCaseType
    private let cancelBag = CancelBag()
    
    public init(
        navigationRouter: NavigationRoutableType,
        windowRouter: WindowRoutableType,
        useCase: SignInUseCaseType
    ) {
        self.navigationRouter = navigationRouter
        self.windowRouter = windowRouter
        self.useCase = useCase
        
        observe()
        bindState()
    }
    
    @MainActor
    func send(_ action: Action) {
        switch action {
        case .onAppear:
            useCase.checkAccessTokenExisted()
                .receive(on: RunLoop.main)
                .map { [weak self] isTokenExisted in
                    guard let self else { return false }
                    return !(windowRouter.destination != WindowDestination.onboarding && !isTokenExisted)
                }
                .assign(to: \.state.showCloseBtn, on: self)
                .store(in: cancelBag)
            
        case .closeButtonDidTap:
            if windowRouter.destination == WindowDestination.onboarding {
                navigationRouter.pop()
            } else {
                windowRouter.switch(to: .timetable)
            }
            
        case .loginButtonDidTap:
            Analytics.shared.track(.clickLogin)
            useCase.logIn(id, password)
                .receive(on: RunLoop.main)
                .assignLoading(to: \.state.isLoading, on: self)
                .sink(receiveValue: { [weak self] _ in
                    Analytics.shared.track(.userLoggedIn)
                    self?.navigationRouter.destinations = []
                    self?.windowRouter.switch(to: .timetable)
                })
                .store(in: cancelBag)
            
        case .dismissToastView:
            state.errMessage = ""
            
        case .forgotPasswordButtonDidTap:
            navigationRouter.push(to: .resetPWVerifyEmail)
            
        case .signUpButtonDidTap:
            Analytics.shared.track(.clickSignUp)
            navigationRouter.push(to: .selectNationality)
        }
    }
    
    private func observe() {
        weak var owner = self
        guard let owner else { return }
        
        Publishers.CombineLatest($id, $password)
            .map { !$0.isEmpty && !$1.isEmpty }
            .assign(to: \.state.loginButtonEnabled, on: owner)
            .store(in: cancelBag)
    }
    
    private func bindState() {
        useCase.errMessage
            .receive(on: RunLoop.main)
            .assign(to: \.state.errMessage, on: self)
            .store(in: cancelBag)
    }
}

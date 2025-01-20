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
        case loginButtonDidTap
        case dismissToastView
        case forgotPasswordButtonDidTap
        case signUpButtonDidTap
    }
    
    struct State {
        var loginButtonEnabled = true
        var errMessage: String = ""
        var showToast: Bool {
            return !errMessage.isEmpty
        }
    }
    
    @Published var id: String = ""
    @Published var password: String = ""
    
    @Published var state = State()
    public var navigationRouter: NavigationRoutableType
    public var windowRouter: WindowRoutableType
    private var useCase: OnboardingUseCaseType
    private let cancelBag = CancelBag()
    
    public init(
        navigationRouter: NavigationRoutableType,
        windowRouter: WindowRoutableType,
        useCase: OnboardingUseCaseType
    ) {
        self.navigationRouter = navigationRouter
        self.windowRouter = windowRouter
        self.useCase = useCase
        
        observe()
        bindState()
    }
    
    func send(_ action: Action) {
        switch action {
        case .loginButtonDidTap:
            useCase.logIn(id, password)
                .sink(receiveValue: { [weak self] _ in
                    self?.windowRouter.switch(to: .timetable)
                })
                .store(in: cancelBag)
        case .dismissToastView:
            state.errMessage = ""
        case .forgotPasswordButtonDidTap:
            navigationRouter.push(to: .enterEmail)
        case .signUpButtonDidTap:
            navigationRouter.push(to: .selectUniversity)
        }
    }
    
    func observe() {
        weak var owner = self
        guard let owner else { return }
        
        Publishers.CombineLatest($id, $password)
            .map { !$0.isEmpty && !$1.isEmpty }
            .assign(to: \.state.loginButtonEnabled, on: owner)
            .store(in: cancelBag)
    }
    
    func bindState() {
        useCase.errMessage
            .receive(on: RunLoop.main)
            .assign(to: \.state.errMessage, on: self)
            .store(in: cancelBag)
    }
}


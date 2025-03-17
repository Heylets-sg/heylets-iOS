//
//  EnterEmailViewModel.swift
//  OnboardingFeature
//
//  Created by 류희재 on 12/19/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

import BaseFeatureDependency
import DSKit
import Core
import Domain

public class ResetVerifyEmailViewModel: ObservableObject {
    struct State {
        var emailIsValid: TextFieldState = .idle
        var continueButtonIsEnabled: Bool = false
        var errMessage: String = ""
    }
    
    enum Action {
        case closeButtonDidTap
        case nextButtonDidTap
    }
    
    @Published var state = State()
    public var navigationRouter: NavigationRoutableType
    private var useCase: OnboardingUseCaseType
    private let cancelBag = CancelBag()
    
    @Published var email: String = ""
    
    public init(
        navigationRouter: NavigationRoutableType,
        useCase: OnboardingUseCaseType
    ) {
        self.navigationRouter = navigationRouter
        self.useCase = useCase
        
        observe()
        bindState()
    }
    
    func send(_ action: Action) {
        weak var owner = self
        guard let owner else { return }
        
        switch action {
        case .closeButtonDidTap:
            navigationRouter.popToRootView()
        case .nextButtonDidTap:
            useCase.requestEmailVerifyCode(.resetPassword, email)
                .sink(receiveValue: { _ in
                    owner.navigationRouter.push(to: .signUpEnterSecurityCode(.resetPassword, owner.email))
                })
                .store(in: cancelBag)
        }
    }
    
    private func observe() {
        weak var owner = self
        guard let owner else { return }
        
        $email
            .map { $0.isEmpty ? .idle : ($0.isValidEmail() ? .valid : .invalid) }
            .sink {
                owner.state.emailIsValid = $0
                owner.state.continueButtonIsEnabled = $0 == .valid
            }
            .store(in: cancelBag)
    }
    
    private func bindState() {
        useCase.errMessage
            .receive(on: RunLoop.main)
            .assign(to: \.state.errMessage, on: self)
            .store(in: cancelBag)
    }
}


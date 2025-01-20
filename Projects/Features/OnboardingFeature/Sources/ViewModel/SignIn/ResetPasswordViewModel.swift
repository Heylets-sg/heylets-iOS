//
//  ResetPasswordViewModel.swift
//  OnboardingFeature
//
//  Created by 류희재 on 12/19/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

import BaseFeatureDependency
import DSKit
import Domain
import Core

public class ResetPasswordViewModel: ObservableObject {
    struct State {
        var passwordIsValid: TextFieldState = .idle
        var checkPasswordIsValid: TextFieldState = .idle
        var continueButtonIsEnabled: Bool = false
        var errorMessage: String = ""
    }
    
    enum Action {
        case backButtonDidTap
        case gotoLoginView
    }
    
    private var email: String = ""
    @Published var password = ""
    @Published var checkPassword = ""
    
    @Published var state = State()
    public var navigationRouter: NavigationRoutableType
    private var useCase: OnboardingUseCaseType
    private let cancelBag = CancelBag()
    
    public init(
        navigationRouter: NavigationRoutableType,
        useCase: OnboardingUseCaseType,
        email: String
    ) {
        self.navigationRouter = navigationRouter
        self.useCase = useCase
        self.email = email
    }
    
    func send(_ action: Action) {
        switch action {
        case .backButtonDidTap:
            navigationRouter.pop()
        case .gotoLoginView:
            useCase.resetPassword(email, password)
                .sink(receiveValue: { [weak self] _ in
                    self?.navigationRouter.popToRootView()
                })
                .store(in: cancelBag)
        }
    }
    
    private func observe() {
        weak var owner = self
        guard let owner else { return }
        
        $password
            .map { $0.isEmpty ? .idle : ($0.isValidPassword() ? .valid : .invalid) }
            .assign(to: \.state.passwordIsValid, on: owner)
            .store(in: cancelBag)
        
        $checkPassword
            .map { $0.isEmpty ? .idle : ($0 == self.password ? .valid : .invalid) }
            .assign(to: \.state.checkPasswordIsValid, on: owner)
            .store(in: cancelBag)
        
        Publishers.CombineLatest($password, $checkPassword)
            .map { _ in
                owner.state.passwordIsValid == .valid &&
                owner.state.checkPasswordIsValid == .valid
            }
            .assign(to: \.state.continueButtonIsEnabled, on: owner)
            .store(in: cancelBag)
    }
}


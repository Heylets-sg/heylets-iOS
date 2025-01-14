//
//  EnterIdPasswordViewModel.swift
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

public class EnterIdPasswordViewModel: ObservableObject {
    struct State {
        var nickNameIsValid: TextFieldState = .idle
        var passwordIsValid: TextFieldState = .idle
        var checkPasswordIsValid: TextFieldState = .idle
        var continueButtonIsEnabled: Bool = false
    }
    
    enum Action {
        case backButtonDidTap
        case nextButtonDidTap
        case checkIDAvailabilityButtonDidTap
    }
    
    public var navigationRouter: NavigationRoutableType
    private let cancelBag = CancelBag()
    
    @Published var state = State()
    @Published var nickName = ""
    @Published var password = ""
    @Published var checkPassword = ""
    
    private var useCase: OnboardingUseCaseType
    
    public init(
        navigationRouter: NavigationRoutableType,
        useCase: OnboardingUseCaseType
    ) {
        self.navigationRouter = navigationRouter
        self.useCase = useCase
        
        observe()
    }
    
    func send(_ action: Action) {
        switch action {
        case .backButtonDidTap:
            navigationRouter.pop()
        case .nextButtonDidTap:
            useCase.userInfo.profile.nickName = nickName
            useCase.userInfo.password = password
            navigationRouter.push(to: .addProfile)
        case .checkIDAvailabilityButtonDidTap:
            useCase.checkUserName(nickName)
                .sink(receiveValue: { [weak self] available in
                    if available {
                        self?.state.nickNameIsValid = .valid
                    }
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
        
        Publishers.CombineLatest3($nickName, $password, $checkPassword)
            .map { _ in
                owner.state.nickNameIsValid == .valid &&
                owner.state.passwordIsValid == .valid &&
                owner.state.checkPasswordIsValid == .valid
            }
            .assign(to: \.state.continueButtonIsEnabled, on: owner)
            .store(in: cancelBag)
    }
    
    private func bindState() {
        useCase.checkUserNameFailed
            .map { _ in TextFieldState.invalid }
            .receive(on: RunLoop.main)
            .assign(to: \.state.nickNameIsValid, on: self)
            .store(in: cancelBag)
    }
}


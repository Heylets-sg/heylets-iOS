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
    
    public var navigationRouter: OnboardingNavigationRouter
    private var user: UserInfo
    private let cancelBag = CancelBag()
    
    @Published var state = State()
    @Published var nickName = ""
    @Published var password = ""
    @Published var checkPassword = ""
    
    public init(
        navigationRouter: OnboardingNavigationRouter,
        user: UserInfo
    ) {
        self.navigationRouter = navigationRouter
        self.user = user
        
        observe()
    }
    
    func send(_ action: Action) {
        switch action {
        case .backButtonDidTap:
            navigationRouter.pop()
        case .nextButtonDidTap:
            user.profile.nickName = nickName
            user.password = password
            navigationRouter.push(to: .addProfile(user))
        case .checkIDAvailabilityButtonDidTap:
            //TODO: 아이디 중복 확인하는 API 연결
            break
        }
    }
    
    private func observe() {
        weak var owner = self
        guard let owner else { return }
        
        $nickName
            .map { $0.isEmpty ? .idle : ($0.isValidNickname() ? .valid : .invalid) }
            .assign(to: \.state.nickNameIsValid, on: owner)
            .store(in: cancelBag)
        
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
}


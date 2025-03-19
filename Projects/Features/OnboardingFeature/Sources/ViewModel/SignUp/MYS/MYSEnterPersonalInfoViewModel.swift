//
//  MYSEnterPersonalInfoViewModel.swift
//  OnboardingFeatureInterface
//
//  Created by 류희재 on 3/19/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

import BaseFeatureDependency
import Domain
import DSKit
import Core

public class MYSEnterPersonalInfoViewModel: ObservableObject {
    struct State {
        var passwordIsValid: TextFieldState = .idle
        var checkPasswordIsValid: TextFieldState = .idle
        var continueButtonIsEnabled: Bool = false
    }
    
    enum Action {
        case backButtonDidTap
        case nextButtonDidTap
        case genderButtonDidTap(Gender)
        case birthDayDidChange(Date)
    }
    
    var genderList: [Gender] = [.men, .women, .others]
    @Published var gender: Gender?
    @Published var birth: Date = Date()
    @Published var password = ""
    @Published var checkPassword = ""
    
    @Published var state = State()
    public var navigationRouter: NavigationRoutableType
    private var useCase: SignUpUseCaseType
    private let cancelBag = CancelBag()
    
    public init(
        navigationRouter: NavigationRoutableType,
        useCase: SignUpUseCaseType
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
            guard let gender else { return }
            useCase.userInfo.gender = gender.rawValue
            useCase.userInfo.birth = birth
            navigationRouter.push(to: .enterIdPassword)
            
        case .genderButtonDidTap(let gender):
            self.gender = gender
            
        case .birthDayDidChange(let date):
            self.birth = date
        }
    }
    
    private func observe() {
        weak var owner = self
        guard let owner else { return }
        
        $gender
            .map { $0 != nil }
            .assign(to: \.state.continueButtonIsEnabled, on: owner)
            .store(in: cancelBag)
        
        $password
            .map { $0.isEmpty ? .idle : ($0.isValidPassword() ? .valid : .invalid) }
            .assign(to: \.state.passwordIsValid, on: owner)
            .store(in: cancelBag)
        
        $checkPassword
            .map { $0.isEmpty ? .idle : ($0 == self.password ? .valid : .invalid) }
            .assign(to: \.state.checkPasswordIsValid, on: owner)
            .store(in: cancelBag)
        
        Publishers.CombineLatest3($gender, $password, $checkPassword)
            .map { _ in
                owner.gender != nil &&
                owner.state.passwordIsValid == .valid &&
                owner.state.checkPasswordIsValid == .valid
            }
            .assign(to: \.state.continueButtonIsEnabled, on: owner)
            .store(in: cancelBag)
    }
}

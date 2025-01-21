//
//  EnterSecurityCodeViewModel.swift
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

public class EnterSecurityCodeViewModel: ObservableObject {
    struct State {
        var hiddenEmail: String = ""
        var continueButtonIsEnabled: Bool = false
        var errMessage = ""
    }
    
    enum Action {
        case backButtonDidTap
        case nextButtonDidTap
    }
    
    @Published var otpCode: String = ""
    
    @Published var state = State()
    public var navigationRouter: NavigationRoutableType
    private var useCase: OnboardingUseCaseType
    private var type: VerifyCodeType
    private var email: String
    private let cancelBag = CancelBag()
    
    public init(
        navigationRouter: NavigationRoutableType,
        useCase: OnboardingUseCaseType,
        type: VerifyCodeType,
        email: String
    ) {
        self.navigationRouter = navigationRouter
        self.useCase = useCase
        self.type = type
        self.email = email
        
        observe()
    }
    
    func send(_ action: Action) {
        weak var owner = self
        guard let owner else { return }
        
        switch action {
        case .backButtonDidTap:
            navigationRouter.pop()
        case .nextButtonDidTap:
            useCase.verifyEmail(type, email, Int(otpCode)!)
                .sink(receiveValue: {  _ in
                    switch owner.type {
                    case .email:
                        owner.navigationRouter.push(to: .enterPersonalInfo)
                    case .resetPassword:
                        owner.navigationRouter.push(to: .resetPassword(owner.email))
                    }
                })
                .store(in: cancelBag)
        }
    }
    
    private func observe() {
        weak var owner = self
        guard let owner else { return }
        
        $otpCode
            .map { $0.count >= 6 }
            .assign(to: \.state.continueButtonIsEnabled, on: owner)
            .store(in: cancelBag)
    }
    
    private func bindState() {
        useCase.errMessage
            .receive(on: RunLoop.main)
            .assign(to: \.state.errMessage, on: self)
            .store(in: cancelBag)
    }
}


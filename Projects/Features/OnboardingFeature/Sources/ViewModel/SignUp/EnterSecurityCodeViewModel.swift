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
    }
    
    enum Action {
        case onAppear
        case backButtonDidTap
        case nextButtonDidTap
    }
    
    @Published var otpCode: String = ""
    
    @Published var state = State()
    public var navigationRouter: NavigationRoutableType
    private var useCase: OnboardingUseCaseType
    private var type: VerifyCodeType
    private let cancelBag = CancelBag()
    
    public init(
        navigationRouter: NavigationRoutableType,
        useCase: OnboardingUseCaseType,
        type: VerifyCodeType
    ) {
        self.navigationRouter = navigationRouter
        self.useCase = useCase
        self.type = type
        self.state.hiddenEmail = useCase.userInfo.email.maskedEmail()
        dump(useCase.userInfo)
        
        observe()
    }
    
    func send(_ action: Action) {
        switch action {
        case .onAppear:
            useCase.requestEmailVerifyCode(type)
                .sink(receiveValue: { _ in })
                .store(in: cancelBag)
            
        case .backButtonDidTap:
            navigationRouter.pop()
        case .nextButtonDidTap:
            useCase.verifyEmail(type, Int(otpCode)!)
                .sink(receiveValue: { [weak self] _ in
                    switch self?.type {
                    case .email:
                        self?.navigationRouter.push(to: .enterPersonalInfo)
                    case .resetPassword:
                        self?.navigationRouter.push(to: .resetPassword)
                    case .none:
                        break
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
}


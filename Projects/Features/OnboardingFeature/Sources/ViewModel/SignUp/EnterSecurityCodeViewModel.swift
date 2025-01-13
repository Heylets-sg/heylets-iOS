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
        case backButtonDidTap
        case nextButtonDidTap
    }
    
    public var navigationRouter: NavigationRoutableType
    
    @Published var state = State()
    @Published var otpCode: String = ""
    private var type: VerifyCodeType
    private let cancelBag = CancelBag()
    
    private var useCase: OnboardingUseCaseType
    
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
        case .backButtonDidTap:
            navigationRouter.pop()
        case .nextButtonDidTap:
            //TODO: 인증번호 확인 API 연결
            switch type {
            case .email:
                navigationRouter.push(to: .enterPersonalInfo)
            case .resetPassword:
                navigationRouter.push(to: .resetPassword)
            }
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


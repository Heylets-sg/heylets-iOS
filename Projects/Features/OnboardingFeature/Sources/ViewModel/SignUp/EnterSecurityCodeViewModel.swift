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
    private var user: UserInfo?
    
    @Published var state = State()
    @Published var otpCode: String = ""
    private let cancelBag = CancelBag()
    
    public init(
        navigationRouter: NavigationRoutableType,
        user: UserInfo?,
        email: String
    ) {
        self.navigationRouter = navigationRouter
        self.user = user
        self.state.hiddenEmail = email.maskedEmail()
        
        observe()
    }
    
    func send(_ action: Action) {
        switch action {
        case .backButtonDidTap:
            navigationRouter.pop()
        case .nextButtonDidTap:
            //TODO: 인증번호 확인 API 연결
            if let user = user {
                navigationRouter.push(to: .enterPersonalInfo(user))
            } else {
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


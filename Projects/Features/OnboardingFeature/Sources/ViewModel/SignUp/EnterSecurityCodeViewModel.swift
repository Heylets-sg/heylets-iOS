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

public class EnterSecurityCodeViewModel: ObservableObject {
    struct State {
        var hiddenEmail: String = ""
    }
    
    enum Action {
        case backButtonDidTap
        case nextButtonDidTap
    }
    
    public var navigationRouter: OnboardingNavigationRouter
    private var user: User
    @Published var state = State()
    
    public init(
        navigationRouter: OnboardingNavigationRouter,
        user: User
    ) {
        self.navigationRouter = navigationRouter
        self.user = user
        self.state.hiddenEmail = user.email.maskedEmail()
    }
    
    func send(_ action: Action) {
        switch action {
        case .backButtonDidTap:
            navigationRouter.pop()
        case .nextButtonDidTap:
            //TODO: 인증번호 확인 API 연결
            navigationRouter.push(to: .enterPersonalInfo(user))
        }
    }
}


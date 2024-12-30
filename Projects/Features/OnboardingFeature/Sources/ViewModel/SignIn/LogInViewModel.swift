//
//  LogInViewModel.swift
//  OnboardingFeature
//
//  Created by 류희재 on 12/19/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

import BaseFeatureDependency
import Core

public class LogInViewModel: ObservableObject {
    
    enum Action {
        case loginButtonDidTap
        case forgotPasswordButtonDidTap
        case signUpButtonDidTap
    }
    
    struct State {
        var id: String = ""
        var password: String = ""
    }
    
    @Published var state = State()
    private let cancelBag = CancelBag()
    
    public var navigationRouter: OnboardingNavigationRouter
    public var windowRouter: WindowRoutableType
    
    public init(
        navigationRouter: OnboardingNavigationRouter,
        windowRouter: WindowRoutableType
    ) {
        self.navigationRouter = navigationRouter
        self.windowRouter = windowRouter
    }
    
    func send(_ action: Action) {
        switch action {
        case .loginButtonDidTap:
            //TODO: 로그인 API 연결
            windowRouter.switch(to: .timetable)
        case .forgotPasswordButtonDidTap:
            navigationRouter.push(to: .enterEmail)
        case .signUpButtonDidTap:
            navigationRouter.push(to: .selectUniversity)
        }
    }
}


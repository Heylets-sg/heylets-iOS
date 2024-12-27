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

public class LogInViewModel: ObservableObject {
    
    enum Action {
        case loginButtonDidTap
        case forgotPasswordButtonDidTap
    }
    
    public var navigationRouter: OnboardingNavigationRouter
    
    public init(navigationRouter: OnboardingNavigationRouter) {
        self.navigationRouter = navigationRouter
    }
    
    func send(_ action: Action) {
        switch action {
        case .loginButtonDidTap:
            print("로그인 버튼 클릭")
        case .forgotPasswordButtonDidTap:
            print("버튼클릭")
//            navigationRouter.push(to: .resetPasswordView)
        }
    }
}


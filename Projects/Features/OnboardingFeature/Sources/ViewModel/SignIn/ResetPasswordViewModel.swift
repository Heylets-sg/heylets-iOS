//
//  ResetPasswordViewModel.swift
//  OnboardingFeature
//
//  Created by 류희재 on 12/19/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

import BaseFeatureDependency

public class ResetPasswordViewModel: ObservableObject {
    
    enum Action {
        case loginButtonDidTap
        case resetButtonDidTap
    }
    
    public var navigationRouter: NavigationRoutableType
    
    public init(navigationRouter: NavigationRoutableType) {
        self.navigationRouter = navigationRouter
        print(navigationRouter.destinations)
    }
    
    func send(_ action: Action) {
        switch action {
        case .loginButtonDidTap:
            print("버튼 클릭")
//            navigationRouter.push(to: .login)
        case .resetButtonDidTap:
            print("버튼 클릭")
//            navigationRouter.push(to: .resetPasswordView)
        }
    }
}


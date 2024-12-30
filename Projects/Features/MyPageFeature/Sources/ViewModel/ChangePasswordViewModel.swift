//
//  ChangePasswordViewModel.swift
//  MyPageFeature
//
//  Created by 류희재 on 12/26/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

import BaseFeatureDependency

public class ChangePasswordViewModel: ObservableObject {
    enum Action {
        case backButtonDidTap
        case nextButtonDidTap
        case changePasswordButtonDidTap
    }
    
    public var navigationRouter: MyPageNavigationRouter
    
    public init(navigationRouter: MyPageNavigationRouter) {
        self.navigationRouter = navigationRouter
        print(navigationRouter.destinations)
    }
    
    func send(_ action: Action) {
        switch action {
        case .backButtonDidTap:
            break
        case .nextButtonDidTap:
            break
        case .changePasswordButtonDidTap:
            navigationRouter.pop()
        }
    }
}

//
//  OnboardingViewModel.swift
//  OnboardingFeature
//
//  Created by 류희재 on 12/19/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

import BaseFeatureDependency

public class OnboardingViewModel: ObservableObject {
    
    enum Action {
        case startButtonDidTap
        case alreadyRegisteredButtonDidTap
    }
    
    @Published var index: Int = 0
    public var navigationRouter: NavigationRoutableType
    
    public init(navigationRouter: NavigationRoutableType) {
        self.navigationRouter = navigationRouter
    }
    
    func send(_ action: Action) {
        switch action {
        case .startButtonDidTap:
            navigationRouter.push(to: .selectGuestUniversity)
        case .alreadyRegisteredButtonDidTap:
            navigationRouter.push(to: .login)
        }
    }
}


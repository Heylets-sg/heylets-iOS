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
import Core

public class OnboardingViewModel: ObservableObject {
    
    enum Action {
        case loginButtonDidTap
        case guestModeButtonDidTap
    }
    
    @Published var index: Int = 0
    public var navigationRouter: NavigationRoutableType
    
    public init(navigationRouter: NavigationRoutableType) {
        self.navigationRouter = navigationRouter
    }
    
    func send(_ action: Action) {
        switch action {
        case .loginButtonDidTap:
            Analytics.shared.track(.clickAlreadyRegistered)
            navigationRouter.push(to: .login)
        case .guestModeButtonDidTap:
            Analytics.shared.track(.clickExplore)
            navigationRouter.push(to: .selectNationality)
        }
    }
}


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
            Analytics.shared.track(.clickExplore)
            navigationRouter.push(to: .selectGuestUniversity)
        case .alreadyRegisteredButtonDidTap:
            Analytics.shared.track(.clickAlreadyRegistered)
            navigationRouter.push(to: .login)
        }
    }
}


//
//  VerifyEmailViewModel.swift
//  OnboardingFeature
//
//  Created by 류희재 on 12/19/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

import BaseFeatureDependency

public class VerifyEmailViewModel: ObservableObject {
    enum Action {
        case backButtonDidTap
        case nextButtonDidTap
    }
    
    public var navigationRouter: NavigationRoutableType
    
    public init(navigationRouter: NavigationRoutableType) {
        self.navigationRouter = navigationRouter
        print(navigationRouter.destinations)
    }
    
    func send(_ action: Action) {
        switch action {
        case .backButtonDidTap:
            navigationRouter.pop()
        case .nextButtonDidTap:
            navigationRouter.push(to: .enterSecurityCode)
        }
    }}

//
//  AddProfileViewModel.swift
//  OnboardingFeature
//
//  Created by 류희재 on 12/19/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

import BaseFeatureDependency
import Core

public class AddProfileViewModel: ObservableObject {
    struct State {
    }
    
    enum Action {
        case backButtonDidTap
        case nextButtonDidTap
    }
    
    public var navigationRouter: OnboardingNavigationRouter
    private var user: User
    private let cancelBag = CancelBag()
    
    @Published var state = State()
    
    public init(
        navigationRouter: OnboardingNavigationRouter,
        user: User
    ) {
        self.navigationRouter = navigationRouter
        self.user = user
    }
    
    func send(_ action: Action) {
        switch action {
        case .backButtonDidTap:
            navigationRouter.pop()
        case .nextButtonDidTap:
            navigationRouter.popToRootView()
        }
    }
}


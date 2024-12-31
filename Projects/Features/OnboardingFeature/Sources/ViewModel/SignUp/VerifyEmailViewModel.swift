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
import Core

public class VerifyEmailViewModel: ObservableObject {
    struct State {
        var domainListViewIsVisible = false
        var continueButtonEnabled = false
    }
    
    enum Action {
        case backButtonDidTap
        case nextButtonDidTap
        case domainListButtonDidTap
        case selectDomain
    }
    
    public var navigationRouter: OnboardingNavigationRouter
    public var user: User
    
    @Published var state = State()
    private let cancelBag = CancelBag()
    
    @Published var email: String = ""
    @Published var domain: String = ""
    
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
            navigationRouter.push(to: .enterSecurityCode)
        case .domainListButtonDidTap:
            state.domainListViewIsVisible.toggle()
            print(state.domainListViewIsVisible)
        case .selectDomain:
            state.domainListViewIsVisible = false
        }
    }}

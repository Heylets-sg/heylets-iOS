//
//  EnterEmailViewModel.swift
//  OnboardingFeature
//
//  Created by 류희재 on 12/19/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

import BaseFeatureDependency
import DSKit
import Core
import Domain

public class EnterEmailViewModel: ObservableObject {
    struct State {
        var emailIsValid: TextFieldState = .idle
        var continueButtonIsEnabled: Bool = false
    }
    
    enum Action {
        case gotoLoginView
        case nextButtonDidTap
    }
    
    @Published var state = State()
    public var navigationRouter: NavigationRoutableType
    private var useCase: OnboardingUseCaseType
    private let cancelBag = CancelBag()
    
    @Published var email: String = ""
    
    public init(
        navigationRouter: NavigationRoutableType,
        useCase: OnboardingUseCaseType
    ) {
        self.navigationRouter = navigationRouter
        self.useCase = useCase
        
        observe()
    }
    
    func send(_ action: Action) {
        switch action {
        case .gotoLoginView:
            navigationRouter.popToRootView()
        case .nextButtonDidTap:
            navigationRouter.push(to: .enterSecurityCode(.resetPassword(email)))
        }
    }
    
    private func observe() {
        weak var owner = self
        guard let owner else { return }
        
        $email
            .map { $0.isEmpty ? .idle : ($0.isValidEmail() ? .valid : .invalid) }
            .sink {
                owner.state.emailIsValid = $0
                owner.state.continueButtonIsEnabled = $0 == .valid
            }
            .store(in: cancelBag)
    }
}


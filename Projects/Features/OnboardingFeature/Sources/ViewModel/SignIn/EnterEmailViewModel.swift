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

public class EnterEmailViewModel: ObservableObject {
    struct State {
        var emailIsValid: TextFieldState = .idle
    }
    
    enum Action {
        case gotoLoginView
        case nextButtonDidTap
    }
    
    public var navigationRouter: OnboardingNavigationRouter
    
    @Published var state = State()
    private let cancelBag = CancelBag()
    
    @Published var email: String = ""
    
    public init(navigationRouter: OnboardingNavigationRouter) {
        self.navigationRouter = navigationRouter
        
        observe()
    }
    
    func send(_ action: Action) {
        switch action {
        case .gotoLoginView:
            navigationRouter.popToRootView()
        case .nextButtonDidTap:
            navigationRouter.push(to: .enterSecurityCode(nil, email))
        }
    }
    
    private func observe() {
        weak var owner = self
        guard let owner else { return }
        
        $email
            .map { $0.isEmpty ? .idle : ($0.isValidEmail() ? .valid : .invalid) }
            .assign(to: \.state.emailIsValid, on: owner)
            .store(in: cancelBag)
        
        //TODO: email 빈칸 아니면 따라서 ContinueButtonEnable 처리
    }
}


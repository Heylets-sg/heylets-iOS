//
//  EnterReferralCodeViewModel.swift
//  OnboardingFeatureInterface
//
//  Created by 류희재 on 3/20/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

import BaseFeatureDependency
import Domain
import DSKit
import Core

public class EnterReferralCodeViewModel: ObservableObject {
    struct State {
        var referralIsValid: TextFieldState = .idle
        var continueButtonIsEnabled: Bool = false
        var referralState: (Color, String) = (Color.heyBlack, "")
    }
    
    enum Action {
        case backButtonDidTap
        case skipButtonDidTap
        case nextButtonDidTap
    }
    
    @Published var referralCode = ""
    
    @Published var state = State()
    public var navigationRouter: NavigationRoutableType
    private var useCase: SignUpUseCaseType
    private let cancelBag = CancelBag()
    
    public init(
        navigationRouter: NavigationRoutableType,
        useCase: SignUpUseCaseType
    ) {
        self.navigationRouter = navigationRouter
        self.useCase = useCase
        
        observe()
    }
    
    func send(_ action: Action) {
        switch action {
        case .backButtonDidTap:
            navigationRouter.pop()
            
        case .nextButtonDidTap:
            useCase.userInfo.referralCode = referralCode
            navigationRouter.push(to: .termsOfService)
        
        case .skipButtonDidTap:
            break
        }
    }
    
    private func observe() {
        weak var owner = self
        guard let owner else { return }
        
        $referralCode
            .map { !$0.isEmpty }
            .assign(to: \.state.continueButtonIsEnabled, on: owner)
            .store(in: cancelBag)
    }
}


//
//  ResetEnterSecurityCodeViewModel.swift
//  OnboardingFeature
//
//  Created by 류희재 on 3/17/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

import BaseFeatureDependency
import Domain
import Core

public class ResetEnterSecurityCodeViewModel: ObservableObject {
    struct State {
        var hiddenEmail: String = ""
        var continueButtonIsEnabled: Bool = false
        var errMessage = ""
    }
    
    enum Action {
        case backButtonDidTap
        case nextButtonDidTap
    }
    
    @Published var otpCode: String = ""
    
    @Published var state = State()
    public var navigationRouter: NavigationRoutableType
    private var useCase: SignUpUseCaseType
    private var email: String
    private let cancelBag = CancelBag()
    
    public init(
        navigationRouter: NavigationRoutableType,
        useCase: SignUpUseCaseType,
        email: String
    ) {
        self.navigationRouter = navigationRouter
        self.useCase = useCase
        self.email = email
        
        observe()
        bindState()
    }
    
    func send(_ action: Action) {
        weak var owner = self
        guard let owner else { return }
        
        switch action {
        case .backButtonDidTap:
            navigationRouter.pop()
        case .nextButtonDidTap:
            useCase.verifyEmail(email, Int(otpCode)!)
                .sink(receiveValue: {  _ in
                    owner.navigationRouter.push(to: .resetPassword(owner.email))
                })
                .store(in: cancelBag)
        }
    }
    
    private func observe() {
        weak var owner = self
        guard let owner else { return }
        
        $otpCode
            .map { $0.count >= 6 }
            .assign(to: \.state.continueButtonIsEnabled, on: owner)
            .store(in: cancelBag)
    }
    
    private func bindState() {
        weak var owner = self
        guard let owner else { return }
        
        useCase.errMessage
            .receive(on: RunLoop.main)
            .handleEvents(receiveOutput: { _ in
                owner.otpCode = ""
            })
            .assign(to: \.state.errMessage, on: self)
            .store(in: cancelBag)
    }
}

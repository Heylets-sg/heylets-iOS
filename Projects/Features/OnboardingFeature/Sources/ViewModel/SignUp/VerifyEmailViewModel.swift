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
import Domain
import Core

public class VerifyEmailViewModel: ObservableObject {
    struct State {
        var domainListViewIsVisible = false
        var continueButtonIsEnabled = false
    }
    
    enum Action {
        case backButtonDidTap
        case nextButtonDidTap
        case domainListButtonDidTap
        case selectDomain(String)
    }
    
    @Published var localPart: String = ""
    @Published var domain: String = ""
    @Published var email: String = ""
    
    @Published var state = State()
    public var navigationRouter: NavigationRoutableType
    private var useCase: OnboardingUseCaseType
    private let cancelBag = CancelBag()
    
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
        case .backButtonDidTap:
            navigationRouter.pop()
        case .nextButtonDidTap:
            useCase.userInfo.email = email
            navigationRouter.push(to: .enterSecurityCode(.email(email)))
        case .domainListButtonDidTap:
            state.domainListViewIsVisible.toggle()
        case .selectDomain(let domain):
            state.domainListViewIsVisible = false
            self.domain = domain
        }
    }
    
    private func observe() {
        weak var owner = self
        guard let owner else { return }
        
        Publishers.CombineLatest($localPart, $domain)
            .filter { !$0.isEmpty && !$1.isEmpty }
            .map { "\($0)@\($1)" }
            .assign(to: \.email, on: owner)
            .store(in: cancelBag)
        
        Publishers.CombineLatest($localPart, $domain)
            .map { !$0.isEmpty && !$1.isEmpty }
            .assign(to: \.state.continueButtonIsEnabled, on: owner)
            .store(in: cancelBag)
    }
}

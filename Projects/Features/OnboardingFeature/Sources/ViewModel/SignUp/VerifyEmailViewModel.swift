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
        case selectDomain(String)
    }
    
    public var navigationRouter: OnboardingNavigationRouter
    public var user: User
    
    @Published var state = State()
    private let cancelBag = CancelBag()
    
    @Published var localPart: String = ""
    @Published var domain: String = ""
    @Published var email: String = ""
    
    public init(
        navigationRouter: OnboardingNavigationRouter,
        user: User
    ) {
        self.navigationRouter = navigationRouter
        self.user = user
        
        observe()
    }
    
    func send(_ action: Action) {
        switch action {
        case .backButtonDidTap:
            navigationRouter.pop()
        case .nextButtonDidTap:
            user.email = email
            navigationRouter.push(to: .enterSecurityCode(user))
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
            .map { 
                print("\($0)@\($1)")
                return "\($0)@\($1)"
            }
            .assign(to: \.email, on: owner)
            .store(in: cancelBag)
        
        //TODO: email 여부에 따라서 ContinueButtonEnable 처리
    }
}

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
        var errMessage = ""
    }
    
    enum Action {
        case backButtonDidTap
        case nextButtonDidTap
        case domainListButtonDidTap
        case dismissFocus
        case selectDomain(String)
    }
    
    @Published var localPart: String = ""
    @Published var domain: String = ""
    @Published var email: String = ""
    
    @Published var state = State()
    public var navigationRouter: NavigationRoutableType
    private var useCase: OnboardingUseCaseType
    private let cancelBag = CancelBag()
    
    let domainList: [String] = [
        "u.nus.edu",
        "e.ntu.edu.sg",
        "smu.edu.sg",
        "smu.edu.sg",
        "accountancy.smu.edu.sg",
        "computing.smu.edu.sg",
        "economics.smu.edu.sg",
        "scis.smu.edu.sg",
        "law.smu.edu.sg",
        "business.edu.sg",
        "socsc.smu.edu.sg",
        "business.smu.edu.sg",
        "gmail.com",
        "naver.com"
    ]
    
    public init(
        navigationRouter: NavigationRoutableType,
        useCase: OnboardingUseCaseType
    ) {
        self.navigationRouter = navigationRouter
        self.useCase = useCase
        
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
            //MARK: Test용 삭제 필수
//            useCase.requestEmailVerifyCode(.email, email)
//                .sink(receiveValue: { _ in
//                    owner.useCase.userInfo.email = owner.email
//                    owner.navigationRouter.push(to: .enterSecurityCode(.email, owner.email))
//                })
//                .store(in: cancelBag)
            owner.useCase.userInfo.email = owner.email
            owner.navigationRouter.push(to: .enterPersonalInfo)
        case .domainListButtonDidTap:
            state.domainListViewIsVisible.toggle()
        case .dismissFocus:
            state.domainListViewIsVisible = false
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
    
    private func bindState() {
        useCase.errMessage
            .receive(on: RunLoop.main)
            .assign(to: \.state.errMessage, on: self)
            .store(in: cancelBag)
    }
}

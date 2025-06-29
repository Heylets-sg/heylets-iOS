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
    private var useCase: SignUpUseCaseType
    private let cancelBag = CancelBag()
    
    var nationality: NationalityInfo = .empty
    var university: UniversityInfo = .empty
    
    public init(
        navigationRouter: NavigationRoutableType,
        useCase: SignUpUseCaseType,
        nationality: NationalityInfo
    ) {
        self.navigationRouter = navigationRouter
        self.useCase = useCase
        self.nationality = nationality
        
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
            if Config.isDevEnvironment {
                owner.useCase.userInfo.email = owner.email
                if let university = self.domainToUniversity(owner.domain) {
                    owner.useCase.userInfo.university = university
                }
                if nationality == .Malaysia {
                    navigationRouter.push(to: .enterPersonalInfo_MYS)
                } else {
                    navigationRouter.push(to: .enterPersonalInfo_SG)
                }
            } else {
                useCase.requestEmailVerifyCode(email)
                    .sink(receiveValue: { _ in
                        owner.useCase.userInfo.email = owner.email
                        if let university = self.domainToUniversity(owner.domain) {
                            owner.useCase.userInfo.university = university
                        }
                        owner.navigationRouter.push(to: .signUpEnterSecurityCode(owner.email, owner.nationality))
                    })
                    .store(in: cancelBag)
            }
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

extension VerifyEmailViewModel {
    func domainToUniversity(_ domain: String) -> UniversityInfo? {
        switch domain {
        case "student.uitm.edu.my": return .UiTM
        case "siswa.um.edu.my": return .UM
        case "live.iium.edu.my": return .IIUM
        case "naver.com", "gmail.com": return .UM
        default: return .empty
        }
    }
}

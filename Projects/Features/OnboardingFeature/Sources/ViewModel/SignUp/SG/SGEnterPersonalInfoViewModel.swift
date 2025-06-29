//
//  EnterPersonalInfoViewModel.swift
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

public class SGEnterPersonalInfoViewModel: ObservableObject {
    struct State {
        var continueButtonIsEnabled: Bool = false
    }
    
    enum Action {
        case backButtonDidTap
        case nextButtonDidTap
        case genderButtonDidTap(Gender)
        case birthDayDidChange(Date)
    }
    
    @Published var gender: Gender?
    @Published var birth: Date = Date()
    
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
            guard let gender else { return }
            useCase.userInfo.gender = gender.rawValue
            useCase.userInfo.birth = birth
            navigationRouter.push(to: .enterIdPassword)
        case .genderButtonDidTap(let gender):
            self.gender = gender
        case .birthDayDidChange(let date):
            self.birth = date
        }
    }
    
    private func observe() {
        weak var owner = self
        guard let owner else { return }
        
        $gender
            .map { $0 != nil }
            .assign(to: \.state.continueButtonIsEnabled, on: owner
            )
            .store(in: cancelBag)
    }
}

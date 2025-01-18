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

enum Gender: String {
    case men = "M"
    case women = "W"
    case others = "O"
    
    var title: String {
        switch self {
        case .men:
            return "Men"
        case .women:
            return "Women"
        case .others:
            return "Others"
        }
    }
}

public class EnterPersonalInfoViewModel: ObservableObject {
    struct State {
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
    private var useCase: OnboardingUseCaseType
    
    public init(
        navigationRouter: NavigationRoutableType,
        useCase: OnboardingUseCaseType
    ) {
        self.navigationRouter = navigationRouter
        self.useCase = useCase
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
}

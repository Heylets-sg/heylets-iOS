//
//  SelectUniversityViewModel.swift
//  OnboardingFeature
//
//  Created by 류희재 on 12/19/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine
import BaseFeatureDependency
import Core

public class SelectUniversityViewModel: ObservableObject {
    // MARK: - Nested Types
    struct State {
        var continueButtonEnabled = false
    }
    
    enum Action {
        case backButtonDidTap
        case nextButtonDidTap
        case selectUniversity(String)
    }
    
    // MARK: - Properties
    public var navigationRouter: OnboardingNavigationRouter
    public var user = User(
        nickName: "",
        email: "",
        password: "",
        university: "",
        sex: "",
        birth: ""
    )
    
    @Published var state = State()
    private let cancelBag = CancelBag()
    @Published var selectedUniversity: String? = nil
    
    // MARK: - Init
    public init(navigationRouter: OnboardingNavigationRouter) {
        self.navigationRouter = navigationRouter
    }
    
    // MARK: - Methods
    func send(_ action: Action) {
        switch action {
        case .backButtonDidTap:
            navigationRouter.pop()
        case .nextButtonDidTap:
            guard let university = selectedUniversity else { return }
            user.university = university
            navigationRouter.push(to: .verifyEmail(user))
        case .selectUniversity(let university):
            selectedUniversity = university
            state.continueButtonEnabled = true
        }
    }
}

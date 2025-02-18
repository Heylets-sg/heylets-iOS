//
//  TermsOfServiceViewModel.swift
//  OnboardingFeature
//
//  Created by 류희재 on 2/18/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import UIKit

import BaseFeatureDependency
import Domain
import Core

public class TermsOfServiceViewModel: ObservableObject {
    struct State {
        var termsOfServiceIsAgree = false
        var personalInformationIsAgree = false
        var allAgree = false
        var continueButtonIsEnabled = false
        var errMessage = ""
    }
    
    enum Action {
        case termsOfServiceDidTap
        case personalInformationDidTap
        case allAgreeButtonDidTap
        case agreeButtonDidTap
    }
    
    // MARK: - Properties
    
    @Published var state = State()
    public var windowRouter: WindowRoutableType
    public var navigationRouter: NavigationRoutableType
    private var useCase: GuestUseCaseType
    private var university: String
    private let cancelBag = CancelBag()
    
    // MARK: - Init
    public init(
        navigationRouter: NavigationRoutableType,
        windowRouter: WindowRoutableType,
        useCase: GuestUseCaseType,
        university: String
    ) {
        self.navigationRouter = navigationRouter
        self.windowRouter = windowRouter
        self.useCase = useCase
        self.university = university
    }
    
    // MARK: - Methods
    func send(_ action: Action) {
        switch action {
        case .agreeButtonDidTap:
            useCase.startGuestMode(university: university)
                .sink(receiveValue: { [weak self] _ in
                    self?.windowRouter.switch(to: .timetable)
                })
                .store(in: cancelBag)
        case .termsOfServiceDidTap:
            state.termsOfServiceIsAgree.toggle()
            state.allAgree = state.termsOfServiceIsAgree && state.personalInformationIsAgree
        case .personalInformationDidTap:
            state.personalInformationIsAgree.toggle()
            state.allAgree = state.termsOfServiceIsAgree && state.personalInformationIsAgree
        case .allAgreeButtonDidTap:
            state.allAgree.toggle()
            state.termsOfServiceIsAgree = state.allAgree
            state.personalInformationIsAgree =  state.allAgree
        }
    }
}



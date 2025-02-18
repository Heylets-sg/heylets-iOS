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
    private var university: String
    private let cancelBag = CancelBag()
    
    // MARK: - Init
    public init(
        navigationRouter: NavigationRoutableType,
        windowRouter: WindowRoutableType,
        university: String
    ) {
        self.navigationRouter = navigationRouter
        self.windowRouter = windowRouter
        self.university = university
    }
    
    // MARK: - Methods
    func send(_ action: Action) {
        switch action {
        case .agreeButtonDidTap:
            //게스트 시작 API 연결
            //            guard let university = university else { return }
            windowRouter.switch(to: .timetable)
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



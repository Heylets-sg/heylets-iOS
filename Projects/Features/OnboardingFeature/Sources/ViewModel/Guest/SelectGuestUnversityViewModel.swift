//
//  SelectGuestUnversityViewModel.swift
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

public class SelectGuestUnversityViewModel: ObservableObject {
    struct State {
        var continueButtonIsEnabled = false
        var errMessage = ""
    }
    
    enum Action {
        case closeButtonDidTap
        case nextButtonDidTap
        case selectUniversity(UniversityInfo)
    }
    
    // MARK: - Properties
    
    var universityList: [UniversityInfo] = []
    @Published var university: UniversityInfo? = nil
    
    @Published var state = State()
    public var navigationRouter: NavigationRoutableType
    private let cancelBag = CancelBag()
    
    // MARK: - Init
    public init(
        navigationRouter: NavigationRoutableType,
        universityList: [UniversityInfo]
    ) {
        self.navigationRouter = navigationRouter
        self.universityList = universityList
    }
    
    // MARK: - Methods
    func send(_ action: Action) {
        switch action {
        case .closeButtonDidTap:
            navigationRouter.pop()
            
        case .nextButtonDidTap:
            guard let university = university else { return }
            navigationRouter.push(to: .termsOfServiceAgreement(university))
            
        case .selectUniversity(let university):
            self.university = university
            state.continueButtonIsEnabled = true
        }
    }
}


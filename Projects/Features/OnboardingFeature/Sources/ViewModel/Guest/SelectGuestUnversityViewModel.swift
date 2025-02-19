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
    
    let allUniversityItems: [UniversityInfo] = [.NTU, .NUS, .SMU]
    @Published var university: UniversityInfo? = nil
    
    @Published var state = State()
    public var navigationRouter: NavigationRoutableType
    private let cancelBag = CancelBag()
    
    // MARK: - Init
    public init(
        navigationRouter: NavigationRoutableType
    ) {
        self.navigationRouter = navigationRouter
    }
    
    // MARK: - Methods
    func send(_ action: Action) {
        switch action {
        case .closeButtonDidTap:
            navigationRouter.pop()
            
        case .nextButtonDidTap:
            guard let university = university else { return }
            navigationRouter.push(to: .termsOfServiceAgreement(university.rawValue))
            
        case .selectUniversity(let university):
            self.university = university
            state.continueButtonIsEnabled = true
        }
    }
}


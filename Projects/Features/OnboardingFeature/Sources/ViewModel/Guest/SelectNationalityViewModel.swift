//
//  SelectNationalityViewModel.swift
//  OnboardingFeature
//
//  Created by 류희재 on 3/19/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import UIKit

import BaseFeatureDependency
import Domain
import Core

public class SelectNationalityViewModel: ObservableObject {
    struct State {
        var continueButtonIsEnabled = false
        var errMessage = ""
    }
    
    enum Action {
        case closeButtonDidTap
        case nextButtonDidTap
        case selectNationality(NationalityInfo?)
    }
    
    // MARK: - Properties
    
    let allNationalityItems: [NationalityInfo] = [.Malaysia, .Singapore]
    @Published var nationality: NationalityInfo? = nil
    
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
            guard let nationality else { return }
//            navigationRouter.push(to: .termsOfServiceAgreement(university.rawValue))
            
        case .selectNationality(let nationality):
            self.nationality = nationality
            state.continueButtonIsEnabled = true
        }
    }
}

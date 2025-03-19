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
        case onAppear
        case closeButtonDidTap
        case nextButtonDidTap
        case selectNationality(NationalityInfo?)
    }
    
    // MARK: - Properties
    
    let allNationalityItems: [NationalityInfo] = [.Malaysia, .Singapore]
    @Published var nationality: NationalityInfo? = nil
    
    @Published var state = State()
    public var navigationRouter: NavigationRoutableType
    public var useCase: SignUpUseCaseType
    private let cancelBag = CancelBag()
    
    // MARK: - Init
    public init(
        navigationRouter: NavigationRoutableType,
        useCase: SignUpUseCaseType
    ) {
        self.navigationRouter = navigationRouter
        self.useCase = useCase
    }
    
    // MARK: - Methods
    func send(_ action: Action) {
        switch action {
        case .onAppear:
            useCase.getUniversityInfo()
                .receive(on: RunLoop.main)
                .map { $0.nationality }
                .assign(to: \.nationality, on: self)
                .store(in: cancelBag)
            
        case .closeButtonDidTap:
            navigationRouter.pop()
            
        case .nextButtonDidTap:
            guard let nationality else { return }
            if nationality == .Malaysia { navigationRouter.push(to: .verifyEmail) }
            else { navigationRouter.push(to: .selectGuestUniversity(nationality.universityList)) }
            
            
        case .selectNationality(let nationality):
            self.nationality = nationality
            state.continueButtonIsEnabled = true
        }
    }
}

//
//  EditSchoolViewModel.swift
//  MyPageFeature
//
//  Created by 류희재 on 2/18/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import UIKit

import BaseFeatureDependency
import Domain
import Core

public class EditSchoolViewModel: ObservableObject {
    struct State {
        var continueButtonIsEnabled = false
        var errMessage = ""
    }
    
    enum Action {
        case closeButtonDidTap
        case continueButtonDidTap
        case selectUniversity(UniversityInfo)
    }
    
    // MARK: - Properties
    
    let allUniversityItems: [UniversityInfo] = [.NTU, .NUS, .SMU]
    @Published var university: UniversityInfo? = nil
    
    @Published var state = State()
    public var navigationRouter: NavigationRoutableType
    private let useCase: MyPageUseCaseType
    private let cancelBag = CancelBag()
    
    // MARK: - Init
    public init(
        navigationRouter: NavigationRoutableType,
        useCase: MyPageUseCaseType
    ) {
        self.navigationRouter = navigationRouter
        self.useCase = useCase
    }
    
    // MARK: - Methods
    func send(_ action: Action) {
        switch action {
        case .closeButtonDidTap:
            navigationRouter.pop()
            
        case .continueButtonDidTap:
            Analytics.shared.track(.clickEditSchool)
            guard let university = university else { return }
            state.continueButtonIsEnabled = false
            useCase.changeGuestUniversity(university: university.rawValue)
                .sink(receiveValue: { [weak self] _ in
                    Analytics.shared.track(.schoolEdited)
                    self?.navigationRouter.pop()
                })
                .store(in: cancelBag)
            
        case .selectUniversity(let university):
            self.university = university
            state.continueButtonIsEnabled = true
        }
    }
}



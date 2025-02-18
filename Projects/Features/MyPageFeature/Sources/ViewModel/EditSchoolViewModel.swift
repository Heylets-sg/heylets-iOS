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

public enum UniversityInfo: String {
    case NUS
    case NTU
    case SMU
    
    var icon: UIImage {
        switch self {
        case .NUS:
            return .nus
        case .NTU:
            return .ntu
        case .SMU:
            return .smu
        }
    }
}

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
    private let useCase: GuestUseCaseType
    private let cancelBag = CancelBag()
    
    // MARK: - Init
    public init(
        navigationRouter: NavigationRoutableType,
        useCase: GuestUseCaseType
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
            guard let university = university else { return }
            useCase.changeGuestUniversity(university: university.rawValue)
                .sink(receiveValue: { [weak self] _ in
                    self?.navigationRouter.pop()
                })
                .store(in: cancelBag)
            
        case .selectUniversity(let university):
            self.university = university
            state.continueButtonIsEnabled = true
        }
    }
}



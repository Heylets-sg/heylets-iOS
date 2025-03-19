//
//  SelectUniversityViewModel.swift
//  OnboardingFeature
//
//  Created by 류희재 on 12/19/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import Foundation
import UIKit

import BaseFeatureDependency
import Domain
import Core

public class SelectUniversityViewModel: ObservableObject {
    struct State {
        var filteredItems: [UniversityInfo] = []
        var continueButtonIsEnabled = false
        var errMessage = ""
    }
    
    enum Action {
        case backButtonDidTap
        case nextButtonDidTap
        case textFieldDidTap
        case selectUniversity(UniversityInfo)
    }
    
    // MARK: - Properties
    
    private let allUniversityItems: [UniversityInfo] = [.NTU, .NUS, .SMU]
    @Published var searchText = ""
    @Published var university: UniversityInfo? = nil
    
    @Published var state = State()
    public var navigationRouter: NavigationRoutableType
    private var useCase: SignUpUseCaseType
    private let cancelBag = CancelBag()
    
    // MARK: - Init
    public init(
        navigationRouter: NavigationRoutableType,
        useCase: SignUpUseCaseType
    ) {
        self.navigationRouter = navigationRouter
        self.useCase = useCase
        
        observe()
    }
    
    // MARK: - Methods
    func send(_ action: Action) {
        switch action {
        case .backButtonDidTap:
            navigationRouter.pop()
            
        case .textFieldDidTap:
            state.filteredItems = allUniversityItems
            
        case .nextButtonDidTap:
            guard let university = university else { return }
            useCase.userInfo.university = university
            navigationRouter.push(to: .verifyEmail)
            
        case .selectUniversity(let university):
            self.university = university
            searchText = university.rawValue
        }
    }
    
    private func observe() {
        weak var owner = self
        guard let owner else { return }
        
        $university
            .map { $0 != nil }
            .assign(to: \.state.continueButtonIsEnabled, on: self)
            .store(in: cancelBag)
        
        $searchText
            .map { text in
                return text.isEmpty
                ? []
                : owner.allUniversityItems.filter {
                    $0.rawValue.localizedCaseInsensitiveContains(text)
                }
            }
            .assign(to: \.state.filteredItems, on: owner)
            .store(in: cancelBag)
        
        $searchText
            .map { text in
                owner.allUniversityItems.first {
                    $0.rawValue.caseInsensitiveCompare(text) == .orderedSame
                }
            }
            .handleEvents(receiveOutput: { university in
                print(university ?? "nil")
            })
            .assign(to: \.university, on: self)
            .store(in: cancelBag)
    }
}

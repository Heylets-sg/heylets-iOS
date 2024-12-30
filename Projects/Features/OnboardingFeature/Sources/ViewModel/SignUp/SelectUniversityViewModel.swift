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
    @Published var searchText: String = "" {
        didSet {
            updateFilteredItems()
        }
    }
    @Published var filteredItems: [UniversityInfo] = [.NTU, .NUS]
    @Published var selectedUniversity: String? = nil
    private var allUniversityItems: [UniversityInfo] = [.NTU, .NUS]
    
    // MARK: - Init
    public init(navigationRouter: OnboardingNavigationRouter) {
        self.navigationRouter = navigationRouter
        updateFilteredItems()
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
            searchText = university
            filteredItems = []
            state.continueButtonEnabled = true
        }
    }
    
    private func updateFilteredItems() {
        if searchText.isEmpty {
            filteredItems = []
        } else {
            filteredItems = allUniversityItems.filter {
                $0.rawValue.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
}

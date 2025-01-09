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

enum UniversityInfo: String {
    case NUS
    case NTU
    
    var icon: UIImage {
        switch self {
        case .NUS:
            return .nus
        case .NTU:
            return .ntu
        }
    }
}

public class SelectUniversityViewModel: ObservableObject {
    struct State {
        var filteredItems: [UniversityInfo] = []
        var continueButtonIsEnabled = false
    }
    
    enum Action {
        case backButtonDidTap
        case nextButtonDidTap
        case selectUniversity(UniversityInfo)
    }
    
    // MARK: - Properties
    public var navigationRouter: OnboardingNavigationRouter
    public var user: UserInfo = .init(
        email: "",
        password: "",
        gender: "",
        birth: Date(),
        profile: .init(
            nickName: "",
            university: ""
        )
    )
    
    @Published var state = State()
    private let cancelBag = CancelBag()
    
    private let allUniversityItems: [UniversityInfo] = [.NTU, .NUS]
    @Published var searchText = ""
    @Published var university: UniversityInfo? = nil
    
    // MARK: - Init
    public init(navigationRouter: OnboardingNavigationRouter) {
        self.navigationRouter = navigationRouter
        
        observe()
    }
    
    // MARK: - Methods
    func send(_ action: Action) {
        switch action {
        case .backButtonDidTap:
            navigationRouter.pop()
        case .nextButtonDidTap:
            guard let university = university else { return }
            user.profile.university = university.rawValue
            navigationRouter.push(to: .verifyEmail(user))
        case .selectUniversity(let university):
            self.university = university
            searchText = university.rawValue
        }
    }
    
    private func observe() {
        weak var owner = self
        guard let owner else { return }
        
        $university
            .filter { $0 != nil }
            .map { owner.allUniversityItems.contains($0!) }
            .assign(to: \.state.continueButtonIsEnabled, on: self)
            .store(in: cancelBag)
        
        $searchText
            .map { text in
                if text.isEmpty {
                    return []
                } else {
                    return owner.allUniversityItems.filter {
                        $0.rawValue.localizedCaseInsensitiveContains(text)
                    }
                }
            }
            .assign(to: \.state.filteredItems, on: owner)
            .store(in: cancelBag)
    }
}

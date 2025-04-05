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
        var continueButtonIsEnabled = false { didSet {print(self)}}
        var errMessage = ""
    }
    
    enum Action {
        case onAppear
        case closeButtonDidTap
        case nextButtonDidTap
        case selectNationality(NationalityInfo?)
    }
    
    let allNationalityItems: [NationalityInfo] = [.Malaysia, .Singapore]
    @Published var nationality: NationalityInfo? = nil
    
    @Published var state = State()
    public var navigationRouter: NavigationRoutableType
    public var windowRouter: WindowRoutableType
    public var useCase: SignUpUseCaseType
    private let cancelBag = CancelBag()
    
    public init(
        navigationRouter: NavigationRoutableType,
        windowRouter: WindowRoutableType,
        useCase: SignUpUseCaseType
    ) {
        self.navigationRouter = navigationRouter
        self.windowRouter = windowRouter
        self.useCase = useCase
        
        observe()
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
            
            let preview = navigationRouter.destinations.first!
            
            if (preview == .login || windowRouter.destination == .login) {
                if nationality == .Malaysia { navigationRouter.push(to: .verifyEmail(nationality)) }
                else { navigationRouter.push(to: .selectUniversity) }
            } else {
                navigationRouter.push(to: .selectGuestUniversity(nationality.universityList))
            }
            
        case .selectNationality(let nationality):
            self.nationality = nationality
            state.continueButtonIsEnabled = true
        }
    }
    
    private func observe() {
        weak var owner = self
        guard let owner else { return }
        
        $nationality
            .receive(on: RunLoop.main)
            .map {
                return !($0?.universityList.isEmpty ?? false || $0 == nil )
            }
            .assign(to: \.state.continueButtonIsEnabled, on: owner)
            .store(in: cancelBag)
    }
}

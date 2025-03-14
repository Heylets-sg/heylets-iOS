//
//  TermsOfServiceViewModel.swift
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

public class TermsOfServiceViewModel: ObservableObject {
    struct State {
        var termsOfServiceIsAgree = false
        var personalInformationIsAgree = false
        var allAgree = false
        var continueButtonIsEnabled = false
        var errMessage = ""
    }
    
    enum Action {
        case termsOfServiceDidTap
        case personalInformationDidTap
        case allAgreeButtonDidTap
        case agreeButtonDidTap
    }
    
    // MARK: - Properties
    
    @Published var state = State()
    public var windowRouter: WindowRoutableType
    public var navigationRouter: NavigationRoutableType
    private var useCase: OnboardingUseCaseType
    private var university: String
    private let cancelBag = CancelBag()
    
    // MARK: - Init
    public init(
        navigationRouter: NavigationRoutableType,
        windowRouter: WindowRoutableType,
        useCase: OnboardingUseCaseType,
        university: String
    ) {
        self.navigationRouter = navigationRouter
        self.windowRouter = windowRouter
        self.useCase = useCase
        self.university = university
        
        bindState()
    }
    
    // MARK: - Methods
    func send(_ action: Action) {
        switch action {
        case .agreeButtonDidTap:
            let agreementList = AgreementInfo.agreementList
            if useCase.userInfo.email.isEmpty {
                Analytics.shared.track(.clickStartHeylets)
                useCase.startGuestMode(university: university, agreements: agreementList)
                    .receive(on: RunLoop.main)
                    .sink(receiveValue: { [weak self] _ in
                        Analytics.shared.track(.guestModeStarted)
                        self?.windowRouter.switch(to: .timetable)
                        self?.navigationRouter.destinations = []
                    })
                    .store(in: cancelBag)
            } else {
                useCase.userInfo.agreements = agreementList
                useCase.signUp()
                    .sink(receiveValue: { [weak self] _ in
                        self?.navigationRouter.popToRootView()
                    })
                    .store(in: cancelBag)
            }
        case .termsOfServiceDidTap:
            state.termsOfServiceIsAgree.toggle()
            state.allAgree = state.termsOfServiceIsAgree && state.personalInformationIsAgree
            
        case .personalInformationDidTap:
            state.personalInformationIsAgree.toggle()
            state.allAgree = state.termsOfServiceIsAgree && state.personalInformationIsAgree
            
        case .allAgreeButtonDidTap:
            state.allAgree.toggle()
            state.termsOfServiceIsAgree = state.allAgree
            state.personalInformationIsAgree =  state.allAgree
        }
    }
    
    private func bindState() {
//        useCase.errMessage
//            .receive(on: RunLoop.main)
//            .assign(to: \.state.errMessage, on: self)
//            .store(in: cancelBag)
    }
}



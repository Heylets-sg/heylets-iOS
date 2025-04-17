//
//  EnterReferralCodeViewModel.swift
//  OnboardingFeatureInterface
//
//  Created by 류희재 on 3/20/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

import BaseFeatureDependency
import Domain
import DSKit
import Core

public class EnterReferralCodeViewModel: ObservableObject {
    struct State {
        var referralIsValid: TextFieldState = .idle
        var referralMessage: String = ""
    }
    
    enum Action {
        case backButtonDidTap
        case skipButtonDidTap
        case nextButtonDidTap
    }
    
    @Published var referralCode = ""
    
    @Published var state = State()
    public var navigationRouter: NavigationRoutableType
    public var windowRouter: WindowRoutableType
    private var useCase: SignUpUseCaseType
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
    
    func send(_ action: Action) {
        switch action {
        case .backButtonDidTap:
            navigationRouter.pop()
            
        case .nextButtonDidTap:
            Analytics.shared.track(.enterReferralCode(referralCode: referralCode))
            useCase.userInfo.referralCode = referralCode
            useCase.signUp()
                .receive(on: RunLoop.main)
                .sink(receiveValue: { [weak self] _ in
                    self?.navigationRouter.destinations = []
                    self?.windowRouter.switch(to: .timetable)
                })
                .store(in: cancelBag)
            
        case .skipButtonDidTap:
            useCase.signUp()
                .receive(on: RunLoop.main)
                .sink(receiveValue: { [weak self] _ in
                    self?.navigationRouter.destinations = []
                    self?.windowRouter.switch(to: .timetable)
                })
                .store(in: cancelBag)
        }
    }
    
    private func observe() {
        $referralCode
            .flatMap(useCase.checkReferraalCode)
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] isValid in
                guard let self else { return }
                if isValid {
                    Analytics.shared.track(.referralCodeValidated(referralCode: self.referralCode))
                    self.state.referralIsValid = .valid
                    self.state.referralMessage = "Check which themes you received on the\ntimetable theme page!"
                } else {
                    self.state.referralIsValid = .invalid
                    self.state.referralMessage = "Invalid invite code, Please check again!"
                }
            })
            .store(in: cancelBag)
    }
}


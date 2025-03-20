//
//  InviteCodeViewModel.swift
//  TimeTableFeature
//
//  Created by 류희재 on 3/20/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

import BaseFeatureDependency
import Domain
import DSKit
import Core
import UIKit

public class InviteCodeViewModel: ObservableObject {
    enum Action {
        case onAppear
        case copyButtonDidTap
        case backButtonDidTap
    }
    
    public var navigationRouter: NavigationRoutableType
    private let useCase: MyPageUseCaseType
    private let cancelBag = CancelBag()
    @Published var referralCode: String = ""
    var shareText: String = ""
    
    public init(
        _ navigationRouter: NavigationRoutableType,
        _ useCase: MyPageUseCaseType
    ) {
        self.navigationRouter = navigationRouter
        self.useCase = useCase
    }
    
    func send(_ action: Action) {
        weak var owner = self
        guard let owner else { return }
        
        switch action {
        case .onAppear:
            useCase.getReferralCode()
                .receive(on: RunLoop.main)
                .handleEvents(receiveOutput: { code in
                    owner.shareText = owner.makeShareText(code)
                })
                .assign(to: \.referralCode, on: self)
                .store(in: cancelBag)
            
        case .backButtonDidTap:
            navigationRouter.pop()
            
        case .copyButtonDidTap:
            UIPasteboard.general.string = referralCode
        }
    }
}

extension InviteCodeViewModel {
    func makeShareText(_ code: String?) -> String {
        if code == nil {
            return ""
        } else {
            return """
        I've sent you 3 timetable color themes! 🎨
        Sign up with a friend code and customize your school timetable!

        Use this code when signing up: \(code!)
        
        Make sure to enter the invite code during signup
        to receive 3 free themes!
        
        Heylets link: https://play.google.com/store/apps/details?id=com.haeum.heylets&hl=en
        """
        }
        
    }
}


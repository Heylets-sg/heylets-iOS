//
//  AddProfileViewModel.swift
//  OnboardingFeature
//
//  Created by 류희재 on 12/19/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine
import _PhotosUI_SwiftUI

import BaseFeatureDependency
import Core
import Domain


public class AddProfileViewModel: ObservableObject {
    struct State {
        var errMessage: String = ""
    }
    
    enum Action {
        case backButtonDidTap
        case nextButtonDidTap
        case profileImageDidChange(PhotosPickerItem?)
    }
    
    public var navigationRouter: NavigationRoutableType
    private let cancelBag = CancelBag()
    
    @Published var state = State()
    @Published var profileImage: UIImage? = nil
    
    private var useCase: OnboardingUseCaseType
    
    public init(
        navigationRouter: NavigationRoutableType,
        useCase: OnboardingUseCaseType
    ) {
        self.navigationRouter = navigationRouter
        self.useCase = useCase
        
        bindState()
    }
    
    func send(_ action: Action) {
        switch action {
        case .backButtonDidTap:
            navigationRouter.pop()
        case .nextButtonDidTap:
            useCase.userInfo.profileImage = profileImage
            navigationRouter.push(to: .termsOfServiceAgreement(useCase.userInfo.university))
            
        case .profileImageDidChange(let newPhoto):
            guard let newPhoto else { return }

            newPhoto.loadTransferable(type: Data.self) { result in
                switch result {
                case .success(let data):
                    if let data = data, let newImage = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.profileImage = newImage
                        }
                    }
                case .failure:
                    self.state.errMessage = "load Image Failed"
                }
            }
        }
    }
    
    private func bindState() {
        useCase.errMessage
            .receive(on: RunLoop.main)
            .assign(to: \.state.errMessage, on: self)
            .store(in: cancelBag)
    }
}


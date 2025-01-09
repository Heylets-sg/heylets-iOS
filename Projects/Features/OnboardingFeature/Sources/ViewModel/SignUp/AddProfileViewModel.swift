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
    }
    
    enum Action {
        case backButtonDidTap
        case nextButtonDidTap
        case profileImageDidChange(PhotosPickerItem?)
    }
    
    public var navigationRouter: OnboardingNavigationRouter
    private var user: UserInfo
    private let cancelBag = CancelBag()
    
    @Published var state = State()
    @Published var profileImage: UIImage? = nil
    
    public init(
        navigationRouter: OnboardingNavigationRouter,
        user: UserInfo
    ) {
        self.navigationRouter = navigationRouter
        self.user = user
    }
    
    func send(_ action: Action) {
        switch action {
        case .backButtonDidTap:
            navigationRouter.pop()
        case .nextButtonDidTap:
            user.profileImage = profileImage
            navigationRouter.popToRootView()
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
                    DispatchQueue.main.async {
//                        isPresentedError = true
                    }
                }
            }
        }
    }
}


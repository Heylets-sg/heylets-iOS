////
////  ThemeCoordinator.swift
////  TimeTableFeature
////
////  Created by 류희재 on 3/26/25.
////  Copyright © 2025 Heylets-iOS. All rights reserved.
////
//
//import Foundation
//import Combine
//import SwiftUI
//
//import BaseFeatureDependency
//import Domain
//import DSKit
//import Core
//
//public class ThemeCoordinator: ObservableObject, TimeTableCoordinator {
//    weak public var viewModel: TimeTableViewModel?
//    
//    private let useCase: TimeTableUseCaseType
//    private let navigationRouter: NavigationRoutableType
//    private let cancelBag = CancelBag()
//    
//    @Published var themes: [Theme] = []
//    @Published var selectedTheme: String?
//    @Published var isShowingSelectInfoView: Bool = false
//    
//    init(useCase: TimeTableUseCaseType, navigationRouter: NavigationRoutableType) {
//        self.useCase = useCase
//        self.navigationRouter = navigationRouter
//        
//        loadThemes()
//    }
//    
//    private func loadThemes() {
//        useCase.getThemes()
//            .receive(on: RunLoop.main)
//            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] themes in
//                self?.themes = themes
//            })
//            .store(in: cancelBag)
//    }
//    
//    func selectTheme(_ themeName: String) {
//        selectedTheme = themeName
//        viewModel?.send(.selectedTheme(themeName))
//    }
//    
//    func gotoInviteCode() {
//        viewModel?.send(.gotoInviteCodeView)
//    }
//    
//    func showThemeSelectInfo(_ show: Bool) {
//        isShowingSelectInfoView = show
//    }
//}
//

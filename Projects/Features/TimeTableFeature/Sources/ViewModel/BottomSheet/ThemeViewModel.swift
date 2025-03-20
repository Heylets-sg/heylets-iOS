//
//  ThemeViewModel.swift
//  TimeTableFeature
//
//  Created by 류희재 on 1/7/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

import BaseFeatureDependency
import Domain
import DSKit
import Core

public class ThemeViewModel: ObservableObject {
    struct State {
        var isShowingSelectInfoView: Bool = false
        var saveSettingInfoSucced: Bool = false
        var selectedTheme: Theme? = nil
        var isShowingSelectView: Bool = false
    }
    
    enum Action {
        case onAppear
        case saveButtonDidTap
        case themeButtonDidTap(Theme)
        case selectDisplayTypeButtonDidTap
        case selectDisplayType(DisplayTypeInfo)
        case reportButtonDidTap
    }
    
    private let useCase: TimeTableUseCaseType
    public var navigationRouter: NavigationRoutableType
    var selectThemeClosure: ((String) -> Void)?
    
    @Published var state = State()
    @Published var themeList: [Theme] = []
    @Published var displayType: DisplayTypeInfo = .MODULE_CODE
    @Published var theme: String = ""
    
    
    let options: [DisplayTypeInfo] = [
        .MODULE_CODE,
        .MODULE_CODE_CLASSROOM,
        .MODULE_CODE_CLASSROOM_CREDIT,
        .MODULE_CODE_CREDIT
    ]
    
    
    private let cancelBag = CancelBag()
    
    public init(
        _ useCase: TimeTableUseCaseType,
        _ navigationRouter: NavigationRoutableType
    ) {
        self.useCase = useCase
        self.navigationRouter = navigationRouter
    }
    
    func send(_ action: Action) {
        switch action {
        case .onAppear:
            useCase.getSettingInfo()
                .receive(on: RunLoop.main)
                .sink(receiveValue: { [weak self] settingInfo in
                    self?.displayType = settingInfo.displayType
                    self?.theme = settingInfo.theme
                })
                .store(in: cancelBag)
            
            useCase.getThemeList()
                .receive(on: RunLoop.main)
                .assign(to: \.themeList, on: self)
                .store(in: cancelBag)
            
        case .saveButtonDidTap:
            navigationRouter.push(to: .inviteCode)
//            Analytics.shared.track(.clickSaveTimetableSetting(
//                theme: theme,
//                displayType: displayType.rawValue
//            ))
//            useCase.patchSettingInfo(displayType, theme)
//                .receive(on: RunLoop.main)
//                .sink(receiveValue: {  _ in
//                    Analytics.shared.track(.timetableSettingSaved)
//                })
//                .store(in: cancelBag)
            
        case .themeButtonDidTap(let selectedTheme):
            state.selectedTheme = selectedTheme
            theme = selectedTheme.name
            guard let selectThemeClosure else { return }
            selectThemeClosure(selectedTheme.name)
            
        case .selectDisplayTypeButtonDidTap:
            state.isShowingSelectInfoView.toggle()
            
        case .selectDisplayType(let displayType):
            self.displayType = displayType
            state.isShowingSelectInfoView.toggle()
            
        case .reportButtonDidTap:
            state.isShowingSelectInfoView = false
        }
    }
}

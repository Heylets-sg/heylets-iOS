//
//  ThemeViewModel.swift
//  TimeTableFeature
//
//  Created on 3/27/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

import BaseFeatureDependency
import Domain
import DSKit
import Core

@MainActor
public class ThemeViewModel: ObservableObject {
    struct State {
        var isShowingSelectInfoView: Bool = false
        var selectedTheme: Theme? = nil
        var inviteCodeViewHidden: Bool = true
        var isShowingPopup: Bool = false
    }
    
    enum Action {
        case onAppear
        case saveButtonDidTap
        case themeButtonDidTap(Theme)
        case selectDisplayTypeButtonDidTap
        case selectDisplayType(DisplayTypeInfo)
        case reportButtonDidTap
        case inviteFriendViewDidTap
        case popUpOkButtonDidTap
    }
    
    @Published var state = State()
    @Published var themeList: [Theme] = []
    private let useCase: SettingUseCaseType
    private let store: TimeTableStoreType
    @Published var displayType: DisplayTypeInfo = .MODULE_CODE
    @Published var theme: String = ""
    
    public var timeTableState: TimeTableState
    
    private let navigationRouter: NavigationRoutableType
    var gotoInviteCodeClosure: (() -> Void)?
   
    private let cancelBag = CancelBag()
    
    public init(
        _ timeTableState: TimeTableState,
        _ useCase: SettingUseCaseType,
        _ store: TimeTableStoreType,
        _ navigationRouter: NavigationRoutableType
    ) {
        self.timeTableState = timeTableState
        self.useCase = useCase
        self.store = store
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
            
            useCase.handleInviteCodeView()
                .receive(on: RunLoop.main)
                .assign(to: \.state.inviteCodeViewHidden, on: self)
                .store(in: cancelBag)
            
        case .saveButtonDidTap:
            Analytics.shared.track(.clickSaveTimetableSetting(
                theme: theme,
                displayType: displayType.rawValue
            ))
            useCase.patchSettingInfo(displayType, theme)
                .receive(on: RunLoop.main)
                .sink(receiveValue: { [weak self] _ in
                    Analytics.shared.track(.timetableSettingSaved)
//                    self?.viewTypeService.reset()
                })
                .store(in: cancelBag)
            
        case .themeButtonDidTap(let selectedTheme):
            state.selectedTheme = selectedTheme
            theme = selectedTheme.name
            useCase.getThemeDetailInfo(selectedTheme.name)
                .receive(on: RunLoop.main)
                .assign(to: \.timeTableState.selectedThemeColor, on: self)
                .store(in: cancelBag)
            
        case .selectDisplayTypeButtonDidTap:
            state.isShowingSelectInfoView.toggle()
            
        case .selectDisplayType(let displayType):
            self.displayType = displayType
            state.isShowingSelectInfoView.toggle()
            
        case .reportButtonDidTap:
            state.isShowingSelectInfoView = false
            
        case .inviteFriendViewDidTap:
            navigationRouter.push(to: .inviteCode)
            
        case .popUpOkButtonDidTap:
            state.isShowingPopup = false
        }
    }
}

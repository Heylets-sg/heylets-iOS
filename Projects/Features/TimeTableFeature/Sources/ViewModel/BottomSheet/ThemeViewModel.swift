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

public class ThemeViewModel: ObservableObject {
    struct State {
        var isShowingSelectInfoView: Bool = false
        var saveSettingInfoSucced: Bool = false
        var selectedTheme: Theme? = nil
        var inviteCodeViewHidden: Bool = true
    }
    
    enum Action {
        case onAppear
        case saveButtonDidTap
        case themeButtonDidTap(Theme)
        case selectDisplayTypeButtonDidTap
        case selectDisplayType(DisplayTypeInfo)
        case reportButtonDidTap
        case inviteFriendViewDidTap
    }
    
    @Published var state = State()
    @Published var themeList: [Theme] = []
    private let useCase: TimeTableUseCaseType
    @Published var displayType: DisplayTypeInfo = .MODULE_CODE
    @Published var theme: String = ""
    
    // 싱글톤 사용
    private var viewTypeService: TimeTableViewTypeService  = TimeTableViewTypeService.shared
    private let navigationRouter: NavigationRoutableType
    
    var selectThemeClosure: ((String) -> Void)?
    var gotoInviteCodeClosure: (() -> Void)?
   
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
                    self?.viewTypeService.reset()
                })
                .store(in: cancelBag)
            
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
            
        case .inviteFriendViewDidTap:
            navigationRouter.push(to: .inviteCode)
        }
    }
}

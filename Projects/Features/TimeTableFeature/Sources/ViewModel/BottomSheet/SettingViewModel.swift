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
        var timeTableName: String = ""
        var isShowingSelectView: Bool = false
        var settingAlertType: TimeTableSettingAlertType? = nil
    }
    
    enum Action {
        case onAppear
        case saveButtonDidTap
        case themeButtonDidTap(Theme)
        case selectDisplayTypeButtonDidTap
        case selectDisplayType(DisplayTypeInfo)
        case reportButtonDidTap
    }
    
    enum SettingAction {
        case saveImage
        case settingAlertDismiss
        case editTimeTableName
        case deleteTimeTable
        case shareURL
        case selectedTheme(String)
    }
    
    private let useCase: TimeTableUseCaseType
    public var navigationRouter: NavigationRoutableType
    var selectThemeClosure: ((String) -> Void)?
    @Published var selectedThemeColor: [String] = []
    
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
            Analytics.shared.track(.clickSaveTimetableSetting(
                theme: theme,
                displayType: displayType.rawValue
            ))
            useCase.patchSettingInfo(displayType, theme)
                .receive(on: RunLoop.main)
                .sink(receiveValue: {  _ in
                    Analytics.shared.track(.timetableSettingSaved)
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
        }
    }
    
    func send(_ action: SettingAction) {
        switch action {
        case .saveImage:
            let mainView = MainCaptureContentView(
                weekList: Week.weekDay,
                hourList: Array(8...21),
                timeTable: [],
                displayType: .MODULE_CODE
            )
            
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                let image = mainView.captureAsImage(size: CGSize(
//                    width: CGFloat(self.Week.weekDaY.count * 100),
//                    height: CGFloat(self.hourList.count * 52)
//                ))
//                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
//            }
            state.settingAlertType = nil
            
        case .deleteTimeTable:
            useCase.deleteAllSection()
                .receive(on: RunLoop.main)
                .map { _ in nil}
                .assign(to: \.state.settingAlertType, on: self)
                .store(in: cancelBag)
            
        case .shareURL:
            state.settingAlertType = nil
            
        case .settingAlertDismiss:
            state.settingAlertType = nil
            
        case .editTimeTableName:
            Analytics.shared.track(.clickChangeTimetableName(state.timeTableName))
            useCase.changeTimeTableName(state.timeTableName)
                .receive(on: RunLoop.main)
                .handleEvents(receiveOutput: {
                    Analytics.shared.track(.timetableNameChanged)
                })
                .map {  _ in nil }
                .assign(to: \.state.settingAlertType, on: self)
                .store(in: cancelBag)
            
        case .selectedTheme(let themeName):
            useCase.getThemeDetailInfo(themeName)
                .receive(on: RunLoop.main)
                .assign(to: \.selectedThemeColor, on: self)
                .store(in: cancelBag)
        }
    }
}

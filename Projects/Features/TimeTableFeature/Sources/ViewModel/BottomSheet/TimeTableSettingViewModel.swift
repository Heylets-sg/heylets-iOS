//
//  TimeTableSettingViewModel.swift
//  TimeTableFeature
//
//  Created by 류희재 on 3/21/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

import BaseFeatureDependency
import Domain
import DSKit
import Core

public class TimeTableSettingViewModel: ObservableObject {
    struct State {
        var dimmed: Bool = false
        var hiddenSetUpBottomView: Bool = false
        var isShowingSelectInfoView: Bool = false
        var saveSettingInfoSucced: Bool = false
        var timeTableName: String = ""
        var isShowingSelectView: Bool = false
        
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
    @Published var selectedThemeColor: [String] = []
    @Published var viewType: TimeTableSettingViewType = .main
    @Published var settingAlertType: TimeTableSettingAlertType = .none
    @Published var state = State()
    
    private let cancelBag = CancelBag()
    
    public init(
        _ useCase: TimeTableUseCaseType,
        _ navigationRouter: NavigationRoutableType
    ) {
        self.useCase = useCase
        self.navigationRouter = navigationRouter
        
        observe()
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
            settingAlertType = .none
            
        case .deleteTimeTable:
            useCase.deleteAllSection()
                .receive(on: RunLoop.main)
                .map { _ in .none}
                .assign(to: \.settingAlertType, on: self)
                .store(in: cancelBag)
            
        case .shareURL:
            settingAlertType = .none
            
        case .settingAlertDismiss:
            settingAlertType = .none
            
        case .editTimeTableName:
            Analytics.shared.track(.clickChangeTimetableName(state.timeTableName))
            useCase.changeTimeTableName(state.timeTableName)
                .receive(on: RunLoop.main)
                .handleEvents(receiveOutput: {
                    Analytics.shared.track(.timetableNameChanged)
                })
                .map {  _ in .none }
                .assign(to: \.settingAlertType, on: self)
                .store(in: cancelBag)
            
        case .selectedTheme(let themeName):
            useCase.getThemeDetailInfo(themeName)
                .receive(on: RunLoop.main)
                .assign(to: \.selectedThemeColor, on: self)
                .store(in: cancelBag)
        }
    }
    
    private func observe() {
        Publishers.CombineLatest($viewType, $settingAlertType)
            .map { viewType, settingAlertType in
                return !(viewType == .main && settingAlertType == .none)
            }
            .assign(to: \.state.hiddenSetUpBottomView, on: self)
            .store(in: cancelBag)
        
        $viewType
            .map { $0 == .main }
            .assign(to: \.state.dimmed, on: self)
            .store(in: cancelBag)
            
    }
}


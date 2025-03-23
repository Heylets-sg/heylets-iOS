//
//  TimeTableSettingViewModel.swift
//  TimeTableFeature
//
//  Created by 류희재 on 3/21/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

import BaseFeatureDependency
import Domain
import DSKit
import Core

public class TimeTableSettingViewModel: ObservableObject {
    struct State {
        var timeTableName: String = ""
    }
    
    enum Action {
        case saveImage
        case settingAlertDismiss
        case editTimeTableName
        case deleteTimeTable
        case shareURL
        case selectedTheme(String)
    }
    
    @Published var state = State()
    private let cancelBag = CancelBag()
    private let useCase: TimeTableUseCaseType
    @Published var selectedThemeColor: [String] = []
    @Published var settingAlertType: TimeTableSettingAlertType? = nil

    var settingsUpdated: (() -> Void)?
    
    public init(
        _ useCase: TimeTableUseCaseType) {
        self.useCase = useCase
    }
    
    func send(_ action: Action) {
        switch action {
        case .saveImage:
//            alertTypeUpdated?(nil)
            settingAlertType = nil
            
        case .deleteTimeTable:
            useCase.deleteAllSection()
                .receive(on: RunLoop.main)
                .handleEvents(receiveOutput: { [weak self] _ in
                    self?.settingAlertType = nil
                    self?.settingsUpdated?()
                })
                .sink { _ in }
                .store(in: cancelBag)
            
        case .shareURL:
            settingAlertType = nil
            
        case .settingAlertDismiss:
            settingAlertType = nil
            
        case .editTimeTableName:
            Analytics.shared.track(.clickChangeTimetableName(state.timeTableName))
            useCase.changeTimeTableName(state.timeTableName)
                .receive(on: RunLoop.main)
                .handleEvents(receiveOutput: { [weak self] _ in
                    Analytics.shared.track(.timetableNameChanged)
                    self?.settingAlertType = nil
                    self?.settingsUpdated?()
                })
                .sink { _ in }
                .store(in: cancelBag)
            
        case .selectedTheme(let themeName):
            useCase.getThemeDetailInfo(themeName)
                .receive(on: RunLoop.main)
                .assign(to: \.selectedThemeColor, on: self)
                .store(in: cancelBag)
        }
    }
    
    // Method to capture the image of the timetable
    func captureTimeTableImage(
        mainView: some View,
        weekList: [Week],
        hourList: [Int]
    ) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let image = mainView.captureAsImage(size: CGSize(
                width: CGFloat(weekList.count * 100),
                height: CGFloat(hourList.count * 52)
            ))
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        }
    }
}

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
    }
    
    @Published var state = State()
    private let cancelBag = CancelBag()
    private let useCase: TimeTableUseCaseType
    @Published var settingAlertType: TimeTableSettingAlertType? = nil

    var settingsUpdated: (() -> Void)?
    
    public init(_ useCase: TimeTableUseCaseType) {
        self.useCase = useCase
    }
    
    func send(_ action: Action) {
        switch action {
        case .saveImage:
            initSettingAlertType() // 연결 복잡하니까 일단 이렇게 두고 안되면 수정
            
        case .deleteTimeTable:
            useCase.deleteAllSection()
                .receive(on: RunLoop.main)
                .handleEvents(receiveOutput: { [weak self] _ in
                    self?.settingAlertType = nil
                    self?.settingsUpdated?()
                })
                .sink { _ in }
                .store(in: cancelBag)
            
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
            
        case .settingAlertDismiss:
            settingAlertType = nil
        }
    }
    
    
}

extension TimeTableSettingViewModel {
    func initSettingAlertType() {
        settingAlertType = nil
    }
    
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

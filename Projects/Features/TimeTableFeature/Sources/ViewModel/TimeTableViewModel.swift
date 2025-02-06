//
//  TimeTableViewModel.swift
//  TimeTableFeature
//
//  Created by 류희재 on 1/5/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

import BaseFeatureDependency
import Domain
import DSKit
import Core

public class TimeTableViewModel: ObservableObject {
    struct State {
        struct Alerts {
            var settingAlertType: TimeTableSettingAlertType? = nil
            var showDeleteAlert: Bool = false
            var showReposrtMissingModuleAlert: Bool = false
            var showAddCustomAlert: Bool = false
        }
        
        var alerts: Alerts = Alerts()
        var timeTableName: String = ""
        var isScrollDisabled: Bool = false
        var profile: ProfileInfo = .init()
        var error: (Bool, String) = (false, "")
    }
    
    enum Action {
        case onAppear
        case tableCellDidTap(Int)
        case deleteModule
        case addLecture(SectionInfo)
        case deleteModuleAlertCloseButtonDidTap
        case errorAlertViewCloseButtonDidTap
    }
    
    enum SettingAction {
        case saveImage
        case settingAlertDismiss
        case editTimeTableName
        case deleteTimeTable
        case shareURL
    }
    
    @Published var state = State()
    private let cancelBag = CancelBag()
    private let useCase: TimeTableUseCaseType
    @Published var viewType: TimeTableViewType = .main
    
    @Published var timeTableInfo: TimeTableInfo = .stub //TODO: QA용 -> .empty로 변경
    @Published var displayTypeInfo: DisplayTypeInfo = .MODULE_CODE
    @Published var sectionList: [SectionInfo] = [
        .timetable_stub1,
        .timetable_stub1_1,
        .timetable_stub2,
        .timetable_stub2_1,
        .timetable_stub3,
        .timetable_stub4
    ]
    @Published var weekList: [Week] = Week.dayOfWeek
    @Published var hourList: [Int] = Array(8...21)
    @Published var timeTable: [TimeTableCellInfo] = []
    @Published var detailSectionInfo: SectionInfo = .empty
    
    
    public init(_ useCase: TimeTableUseCaseType) {
        self.useCase = useCase
        
        bindState()
        
        timeTable = sectionList.createTimeTableCellList()
    }
    
    func send(_ action: Action) {
        switch action {
        case .onAppear:
            useCase.getProfileInfo()
                .receive(on: RunLoop.main)
                .assign(to: \.state.profile, on: self)
                .store(in: cancelBag)
            
            useCase.fetchTableInfo()
                .sink(receiveValue: { _ in })
                .store(in: cancelBag)
            
        case .tableCellDidTap(let sectionId):
            if let detailInfo = sectionList.first(where: { $0.id == sectionId }) {
                detailSectionInfo = detailInfo
                viewType = .detail
            } else {
                state.error = (true, "선택한 섹션 정보를 찾을 수 없습니다.")
            }
            
        case .deleteModule:
            useCase.deleteSection(
                detailSectionInfo.isCustom,
                detailSectionInfo.id
            )
            .map { _ in false}
            .assign(to: \.state.alerts.showDeleteAlert, on: self)
            .store(in: cancelBag)
            
        case .deleteModuleAlertCloseButtonDidTap:
            state.alerts.showDeleteAlert = false
            
        case .errorAlertViewCloseButtonDidTap:
            state.error = (false, "")
            
        case .addLecture(let lecture):
            useCase.addSection(lecture.id)
                .receive(on: RunLoop.main)
                .map { _ in TimeTableViewType.main }
                .assign(to: \.viewType, on: self)
                .store(in: cancelBag)
        }
    }
    
    func send(_ action: SettingAction) {
        switch action {
        case .saveImage:
            let mainView = MainCaptureContentView(
                weekList: weekList,
                hourList: hourList,
                timeTable: timeTable,
                displayType: displayTypeInfo
            )
            
            let image = mainView.captureAsImage()
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            state.alerts.settingAlertType = nil
            
        case .deleteTimeTable:
            useCase.deleteAllSection()
                .receive(on: RunLoop.main)
                .map { _ in nil}
                .assign(to: \.state.alerts.settingAlertType, on: self)
                .store(in: cancelBag)
            
        case .shareURL:
            state.alerts.settingAlertType = nil
            
        case .settingAlertDismiss:
            state.alerts.settingAlertType = nil
            
        case .editTimeTableName:
            useCase.changeTimeTableName(state.timeTableName)
                .receive(on: RunLoop.main)
                .map { _ in nil }
                .assign(to: \.state.alerts.settingAlertType, on: self)
                .store(in: cancelBag)
        }
    }
    
    private func bindState() {
        weak var owner = self
        guard let owner else { return }
        
        useCase.timeTableInfo
            .receive(on: RunLoop.main)
            .assign(to: \.timeTableInfo, on: self)
            .store(in: cancelBag)
        
        useCase.displayInfo
            .receive(on: RunLoop.main)
            .assign(to: \.displayTypeInfo, on: self)
            .store(in: cancelBag)
        
        useCase.sectionList
            .receive(on: RunLoop.main)
            .handleEvents(receiveOutput: { sectionList in
                owner.sectionList = sectionList
            })
            .map { $0.createTimeTableCellList() }
            .flatMap { timeTableCellList in
                owner.configWeekList(timeTableCellList)
                    .handleEvents(receiveOutput: {
                        owner.weekList = $0
                        owner.state.isScrollDisabled = $0 == Week.weekDay
                    })
                    .map { _ in timeTableCellList }
            }
            .map { _ in owner.sectionList.createTimeTableCellList() }
            .flatMap { timeTableCellList in
                owner.configHourList(timeTableCellList)
                    .handleEvents(receiveOutput: { owner.hourList = $0 })
                    .map { _ in timeTableCellList }
            }
            .assign(to: \.timeTable, on: owner)
            .store(in: cancelBag)
        
        useCase.errMessage
            .receive(on: RunLoop.main)
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.viewType = .main
                self?.state.alerts.settingAlertType = nil
            })
            .map { message in (true, message)}
            .assign(to: \.state.error, on: self)
            .store(in: cancelBag)
    }
}

extension TimeTableViewModel {
    private func configHourList(
        _ timeTableCellList: [TimeTableCellInfo]
    ) -> AnyPublisher<[Int], Never> {
        var startTime = 8
        var endTime = 21
        var hourList: [Int] = []
        
        let allTimeList = Set(
            timeTableCellList.map { $0.schedule.startHour } +
            timeTableCellList.map { $0.schedule.endHour }
        )
        
        if allTimeList.isEmpty { hourList = Array(startTime...endTime) }
        
        startTime = min(allTimeList.min()!, startTime)
        endTime = max(allTimeList.max()!, endTime)
        hourList = Array(startTime...endTime)
        return Just(hourList)
            .eraseToAnyPublisher()
    }
    
    private func configWeekList(
        _ timeTableCellList: [TimeTableCellInfo]
    ) -> AnyPublisher<[Week], Never> {
        var updatedWeekList = weekList
        for cell in timeTableCellList {
            if cell.schedule.day == .Sun {
                updatedWeekList = Week.dayOfWeek
                break
            }
            if cell.schedule.day == .Sat && !updatedWeekList.contains(.Sat) {
                updatedWeekList.append(.Sat)
            }
        }
        return Just(updatedWeekList)
            .eraseToAnyPublisher()
    }
}



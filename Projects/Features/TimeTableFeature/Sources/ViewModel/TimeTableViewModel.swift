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
        var settingAlertType: TimeTableSettingAlertType? = nil
        var deleteModuleAlertIsPresented: Bool = false
        var inValidregisterModuleIsPresented: Bool = false
        var reportMissingModuleAlertIsPresented: Bool = false
        var isShowingAddCustomModuleView = false
        var timeTableName: String = ""
        var scrollDisabled: Bool = true
        var profileInfo: ProfileInfo = .init()
        var errMessage: String = ""
    }
    
    enum Action {
        case onAppear
        case tableCellDidTap(Int)
        case deleteModule
        case addLecture(SectionInfo)
        case deleteModuleAlertCloseButtonDidTap
        case inValidregisterModuleAlertCloseButtonDidTap
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
    
    @Published var timeTableInfo: TimeTableInfo = .empty
    @Published var displayTypeInfo: DisplayTypeInfo = .MODULE_CODE
    @Published var sectionList: [SectionInfo] = []
    @Published var weekList: [Week] = Week.weekDay
    @Published var timeTable: [[TimeTableCellInfo?]] = []
    @Published var detailSectionInfo: SectionInfo = .empty
    
    
    public init(useCase: TimeTableUseCaseType) {
        self.useCase = useCase
        
        observe()
        bindState()
    }
    
    func send(_ action: Action) {
        switch action {
        case .onAppear:
            useCase.getProfileInfo()
                .receive(on: RunLoop.main)
                .assign(to: \.state.profileInfo, on: self)
                .store(in: cancelBag)
            
            useCase.fetchTableInfo()
                .sink(receiveValue: { _ in })
                .store(in: cancelBag)
            
        case .tableCellDidTap(let sectionId):
            detailSectionInfo = sectionList.first(where: {
                $0.id == sectionId })!
            viewType = .detail
            
        case .deleteModule:
            useCase.deleteSection(
                detailSectionInfo.isCustom,
                detailSectionInfo.id
            )
            .map { _ in false}
            .assign(to: \.state.deleteModuleAlertIsPresented, on: self)
            .store(in: cancelBag)
            
        case .deleteModuleAlertCloseButtonDidTap:
            state.deleteModuleAlertIsPresented = false
            
        case .inValidregisterModuleAlertCloseButtonDidTap:
            state.inValidregisterModuleIsPresented = false
            state.errMessage = ""
            viewType = .search
            
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
                timeTable: timeTable
            )
            let image = mainView.captureAsImage()
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
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
            useCase.changeTimeTableName(state.timeTableName)
                .receive(on: RunLoop.main)
                .map { _ in nil }
                .assign(to: \.state.settingAlertType, on: self)
                .store(in: cancelBag)
        }
    }
    
    private func observe() {
        
        
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
            .flatMap {
                owner.configWeekList($0)
            }
            .handleEvents(receiveOutput: {
                owner.weekList = $0
                owner.state.scrollDisabled = $0 == Week.weekDay
            })
            .map { _ in owner.sectionList.createTimeTableCellList() }
            .flatMap(configTimeTable)
            .assign(to: \.timeTable, on: self)
            .store(in: cancelBag)
        
        useCase.errMessage
            .receive(on: RunLoop.main)
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.state.inValidregisterModuleIsPresented = true
                self?.viewType = .main
            })
            .assign(to: \.state.errMessage, on: self)
            .store(in: cancelBag)
    }
}

extension TimeTableViewModel {
    
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
    
    private func configTimeTable(
        _ timeTableCellList: [TimeTableCellInfo]
    ) -> AnyPublisher<[[TimeTableCellInfo?]], Never> {
        let updatedTimeTable: [[TimeTableCellInfo?]] = Array(repeating: Array(repeating: nil, count: 17), count: weekList.count)
        let resultTimeTable = timeTableCellList.reduce(into: updatedTimeTable) { timeTable, cell in
            if let weekIndex = weekList.firstIndex(of: cell.schedule.day) {
                for s in cell.slot {
                    timeTable[weekIndex][s.key] = cell
                }
            }
        }
        return Just(resultTimeTable)
            .eraseToAnyPublisher()
    }
    
}



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
    @Published var lectureList: [SectionInfo] = []
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
                .handleEvents(receiveOutput: { [weak self]  profileInfo in
                    self?.state.profileInfo = profileInfo
                })
                .map { _ in }
                .flatMap(useCase.fetchTableInfo)
                .assign(to: \.lectureList, on: self)
                .store(in: cancelBag)
            
        case .tableCellDidTap(let sectionId):
            detailSectionInfo = lectureList.first(where: {
                $0.id == sectionId })!
            viewType = .detail
            
        case .deleteModule:
            useCase.deleteSection(detailSectionInfo.isCustom, detailSectionInfo.id)
                .map { _ in }
                .flatMap(useCase.fetchTableInfo)
                .receive(on: RunLoop.main)
                .sink { [weak self] lectureList in
                    self?.lectureList = lectureList // lectureList를 먼저 업데이트
                    self?.state.deleteModuleAlertIsPresented = false
                }
                .store(in: cancelBag)
            
        case .deleteModuleAlertCloseButtonDidTap:
            state.deleteModuleAlertIsPresented = false
            
        case .inValidregisterModuleAlertCloseButtonDidTap:
            state.inValidregisterModuleIsPresented = false
            state.errMessage = ""
            viewType = .search
            
        case .addLecture(let lecture):
            useCase.addSection(lecture.id)
                .map { _ in }
                .flatMap(useCase.fetchTableInfo)
                .receive(on: RunLoop.main)
                .sink { [weak self] lectureList in
                    self?.lectureList = lectureList
                    self?.viewType = .main
                }
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
                .sink(receiveValue: { [weak self] _ in
                    self?.state.settingAlertType = nil
                })
                .store(in: cancelBag)
            
        case .shareURL:
            state.settingAlertType = nil
            
        case .settingAlertDismiss:
            state.settingAlertType = nil
            
        case .editTimeTableName:
            useCase.changeTimeTableName(state.timeTableName)
                .flatMap(useCase.fetchTableInfo)
                .receive(on: RunLoop.main)
                .sink { [weak self] lectureList in
                    self?.lectureList = lectureList
                    self?.state.settingAlertType = nil
                }
                .store(in: cancelBag)
        }
    }
    
    private func observe() {
        weak var owner = self
        guard let owner else { return }
        
    }
    
    private func bindState() {
        useCase.timeTableInfo
            .receive(on: RunLoop.main)
            .assign(to: \.timeTableInfo, on: self)
            .store(in: cancelBag)
        
        useCase.timeTableCellInfo
            .receive(on: RunLoop.main)
            .flatMap(configWeekList)
            .handleEvents(receiveOutput: { [weak self] weekList in
                self?.state.scrollDisabled = weekList == Week.weekDay
            })
            .assign(to: \.weekList, on: self)
            .store(in: cancelBag)
        
        useCase.timeTableCellInfo
            .receive(on: RunLoop.main)
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



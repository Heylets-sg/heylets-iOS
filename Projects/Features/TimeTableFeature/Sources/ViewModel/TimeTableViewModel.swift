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

typealias InValidRegisterModelType = (Bool, String)

public class TimeTableViewModel: ObservableObject {
    struct State {
        var settingAlertType: TimeTableSettingAlertType? = nil
        var deleteModuleAlertIsPresented: Bool = false
        var inValidregisterModuleIsPresented: InValidRegisterModelType = (false, "")
        var reportMissingModuleAlertIsPresented: Bool = false
        var isShowingAddCustomModuleView = false
        var timeTableName: String = ""
    }
    
    enum Action {
        case onAppear
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
    //TODO: lectureList -> timeTableCellList -> weekList, timaTable 컴바인으로 서버통신하면서 연결
    
    
    private let cancelBag = CancelBag()
    private let useCase: TimeTableUseCaseType
    
    @Published var timeTableInfo: TimeTableInfo = .stub
    @Published var lectureList: [SectionInfo] = []
    @Published var weekList: [Week] = Week.weekDay
    @Published var timeTable: [[TimeTableCellInfo?]] = []
    
    
    public init(useCase: TimeTableUseCaseType) {
        self.useCase = useCase
        
        observe()
        bindState()
    }
    
    func send(_ action: Action) {
        switch action {
        case .onAppear:
            useCase.fetchTableInfo()
                .receive(on: RunLoop.main)
                .assign(to: \.lectureList, on: self)
                .store(in: cancelBag)
        case .deleteModule:
            //TODO: 삭제 API 호출
            state.deleteModuleAlertIsPresented = false
        case .deleteModuleAlertCloseButtonDidTap:
            state.deleteModuleAlertIsPresented = false
        case .inValidregisterModuleAlertCloseButtonDidTap:
            state.inValidregisterModuleIsPresented = (false, "")
        case .addLecture(let lecture):
            if lectureList.contains(where: { $0 == lecture }) {
                state.inValidregisterModuleIsPresented = (true, "This module is already exist")
            } else {
                useCase.addSection(lecture.id!)
                    .sink(receiveValue: {_  in })
                    .store(in: cancelBag)
            }
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
            //TODO: 시간표 삭제 API 호출
            //성공하면 settingAlertType = nil
            print("시간표 삭제 API 호출")
            state.settingAlertType = nil
            
        case .shareURL:
            //TODO: 시간표 URL 복사 -> 근데 URL 어디서 나옴?
            state.settingAlertType = nil
            
        case .settingAlertDismiss:
            state.settingAlertType = nil
            
        case .editTimeTableName:
            //TODO: 시간표 이름 변경 API 호출 with timeTableName
            useCase.changeTimeTableName(state.timeTableName)
                .receive(on: RunLoop.main)
                .map { _ in  nil}
                .assign(to: \.state.settingAlertType, on: self)
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
            .assign(to: \.weekList, on: self)
            .store(in: cancelBag)
        
        useCase.timeTableCellInfo
            .receive(on: RunLoop.main)
            .flatMap(configTimeTable)
            .assign(to: \.timeTable, on: self)
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
        let updatedTimeTable: [[TimeTableCellInfo?]] = Array(repeating: Array(repeating: nil, count: 16), count: weekList.count)
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



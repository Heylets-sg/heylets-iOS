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
        case deleteModule
        case addLecture(LectureInfo)
        case deleteModuleAlertCloseButtonDidTap
        case inValidregisterModuleAlertCloseButtonDidTap
        
        
    }
    
    enum SettingAction {
        case settingAlertDismiss
        case editTimeTableName
        case deleteTimeTable
        case shareURL
    }
    
    @Published var state = State()
    @Published var viewType: TimeTableViewType = .main
    @Published var lectureList: [LectureInfo] = [
        .timetable_stub1,
        .timetable_stub2,
        .timetable_stub3,
        .timetable_stub4
    ]
    @Published var timeTableInfo: TimeTableInfo = TimeTableInfo(
        id: 1,
        name: "A+++",
        semester: "sem 1",
        academicYear: 2024
    )
    //    @Published var userInfo: User
    private let cancelBag = CancelBag()
    
    public init() {
        
        observe()
    }
    
    func send(_ action: Action) {
        switch action {
        case .deleteModule:
            //TODO: 삭제 API 호출
            state.deleteModuleAlertIsPresented = false
        case .deleteModuleAlertCloseButtonDidTap:
            state.deleteModuleAlertIsPresented = false
        case .inValidregisterModuleAlertCloseButtonDidTap:
            viewType = .search
            state.inValidregisterModuleIsPresented = (false, "")
        case .addLecture(let lecture):
            if lectureList.contains(where: { $0 == lecture }) {
                viewType = .main
                state.inValidregisterModuleIsPresented = (true, "This module is already exist")
            } else {
                //TODO: 정규 강의 추가 API 호출
            }
        }
    }
    
    func send(_ action: SettingAction) {
        switch action {
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
            print("시간표 이름 변경 메소드 호출: \(state.timeTableName)")
            state.settingAlertType = nil
        }
    }
    
    private func observe() {
        weak var owner = self
        guard let owner else { return }
        
    }
}



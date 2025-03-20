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
            var showGuestErrorAlert: Bool = false
        }
        
        struct TimeTable {
            var columnCount: Int = 5
            var rowCount: Int = 17
            var isScrollEnabled: Bool = true
        }
        
        var alerts: Alerts = Alerts()
        var timeTable: TimeTable = TimeTable()
        var timeTableName: String = ""
        var profile: ProfileInfo = .init()
        var error: (Bool, String) = (false, "")
        var isLoading: Bool = false
    }
    
    enum Action {
        case onAppear
        case tableCellDidTap(Int)
        case deleteModule
        case selectLecture(SectionInfo)
        case addLecture(SectionInfo)
        case deleteModuleAlertCloseButtonDidTap
        case errorAlertViewCloseButtonDidTap
        case addCustomModuleButtonDidTap
        case initMainView
        case notRightNowButtonDidTap
        case loginButtonDidTap
    }
    
    enum SettingAction {
        case saveImage
        case settingAlertDismiss
        case editTimeTableName
        case deleteTimeTable
        case shareURL
        case selectedTheme(String)
    }
    
    enum WindowAction {
        case gotoTodo
        case gotoMyPage
    }
    
    @Published var state = State()
    private let cancelBag = CancelBag()
    public var navigationRouter: NavigationRoutableType
    public var windowRouter: WindowRoutableType
    private let useCase: TimeTableUseCaseType
    @Published var viewType: TimeTableViewType = .main {
        didSet {
            if viewType == .main {
                selectLecture = []
                selectedThemeColor = []
            }
        }
    }
    
    @Published var timeTableInfo: TimeTableInfo = .empty
    @Published var displayTypeInfo: DisplayTypeInfo = .MODULE_CODE
    @Published var sectionList: [SectionInfo] = []
    @Published var weekList: [Week] = Week.weekDay
    @Published var hourList: [Int] = Array(8...21)
    @Published var timeTable: [TimeTableCellInfo] = []
    @Published var detailSectionInfo: SectionInfo = .empty
    
    @Published var selectLecture: [TimeTableCellInfo] = []
    @Published var selectedThemeColor: [String] = []
    
    
    public init(
        _ navigationRouter: NavigationRoutableType,
        _ windowRouter: WindowRoutableType,
        _ useCase: TimeTableUseCaseType
    ) {
        self.useCase = useCase
        self.windowRouter = windowRouter
        self.navigationRouter = navigationRouter
        
        bindState()
        
        timeTable = sectionList.createTimeTableCellList()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleViewTypeChange),
            name: .timeTableViewTypeChanged,
            object: nil
        )
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func handleViewTypeChange(_ notification: Notification) {
        if let userInfo = notification.userInfo,
           let viewType = userInfo["viewType"] as? TimeTableViewType {
            DispatchQueue.main.async { [weak self] in
                self?.viewType = viewType
            }
        }
    }
    
    func send(_ action: Action) {
        switch action {
        case .onAppear:
            useCase.getProfileInfo()
                .receive(on: RunLoop.main)
                .assign(to: \.state.profile, on: self)
                .store(in: cancelBag)
            
            useCase.fetchTableInfo()
                .receive(on: RunLoop.main)
                .assignLoading(to: \.state.isLoading, on: self)
                .sink(receiveValue: { _ in })
                .store(in: cancelBag)
            
        case .tableCellDidTap(let sectionId):
            Analytics.shared.track(.screenView("module_info", .bottom_sheet))
            viewType = .detail
            if let detailInfo = sectionList.first(where: { $0.id == sectionId }) {
                detailSectionInfo = detailInfo
            } else {
                state.error = (true, "선택한 섹션 정보를 찾을 수 없습니다.")
            }
            
        case .deleteModule:
            Analytics.shared.track(.clickDeleteModule)
            useCase.deleteSection(
                detailSectionInfo.isCustom,
                detailSectionInfo.id
            )
            .receive(on: RunLoop.main)
            .handleEvents(receiveOutput: {
                Analytics.shared.track(.moduleDeleted)
            })
            .map { _ in false }
            .assign(to: \.state.alerts.showDeleteAlert, on: self)
            .store(in: cancelBag)
            
        case .deleteModuleAlertCloseButtonDidTap:
            state.alerts.showDeleteAlert = false
            
        case .errorAlertViewCloseButtonDidTap:
            viewType = .search
            state.error = (false, "")
            
        case .selectLecture(let lecture):
            selectLecture = lecture.timeTableCellInfo
            
        case .addLecture(let lecture):
            Analytics.shared.track(.clickAddModule(
                courseCode: lecture.code ?? "",
                courseName: lecture.name,
                sectionId: lecture.id,
                professor: lecture.professor
            )
            )
            useCase.addSection(lecture.id)
                .receive(on: RunLoop.main)
                .map { _ in TimeTableViewType.search }
                .sink(receiveValue: { [weak self] viewType in
                    Analytics.shared.track(.moduleAdded)
                    self?.viewType = viewType
                    self?.selectLecture = []
                })
                .store(in: cancelBag)
            
        case .initMainView:
            if !(viewType == .search || viewType == .theme || viewType == .addCustom) {
                viewType = .main
            }
            
        case .addCustomModuleButtonDidTap:
            Analytics.shared.track(.screenView("add_custom_module", .bottom_sheet))
            viewType = .addCustom
            state.alerts.showAddCustomAlert = true
            selectLecture = []
            
        case .notRightNowButtonDidTap:
            Analytics.shared.track(.clickGuestConfirmReject)
            state.alerts.showGuestErrorAlert = false
            
        case .loginButtonDidTap:
            Analytics.shared.track(.clickGuestConfirmLogin)
            windowRouter.switch(to: .login)
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
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                let image = mainView.captureAsImage(size: CGSize(
                    width: CGFloat(self.weekList.count * 100),
                    height: CGFloat(self.hourList.count * 52)
                ))
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            }
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
            Analytics.shared.track(.clickChangeTimetableName(state.timeTableName))
            useCase.changeTimeTableName(state.timeTableName)
                .receive(on: RunLoop.main)
                .handleEvents(receiveOutput: {
                    Analytics.shared.track(.timetableNameChanged)
                })
                .map {  _ in nil }
                .assign(to: \.state.alerts.settingAlertType, on: self)
                .store(in: cancelBag)
            
        case .selectedTheme(let themeName):
            useCase.getThemeDetailInfo(themeName)
                .receive(on: RunLoop.main)
                .assign(to: \.selectedThemeColor, on: self)
                .store(in: cancelBag)
        }
    }
    
    func send(_ action: WindowAction) {
        switch action {
        case .gotoTodo:
            windowRouter.switch(to: .todo)
        case .gotoMyPage:
            windowRouter.switch(to: .mypage)
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
            .handleEvents(receiveOutput: {
                owner.sectionList = $0
            })
            .map { $0.createTimeTableCellList() }
            .assign(to: \.timeTable, on: owner)
            .store(in: cancelBag)
        
        useCase.sectionList
            .receive(on: RunLoop.main)
            .map { $0.createTimeTableCellList() }
            .flatMap(configWeekList)
            .sink(receiveValue: {
                owner.weekList = $0
                owner.state.timeTable.isScrollEnabled = $0 != Week.weekDay
                owner.state.timeTable.columnCount = $0.count
            })
            .store(in: cancelBag)
        
        useCase.sectionList
            .receive(on: RunLoop.main)
            .map { $0.createTimeTableCellList() }
            .flatMap(configHourList)
            .sink(receiveValue: {
                owner.hourList = $0
                owner.state.timeTable.rowCount = $0.count
            })
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
        
        useCase.guestModeError
            .receive(on: RunLoop.main)
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.viewType = .main
                self?.state.alerts.settingAlertType = nil
            })
            .map { _ in true }
            .assign(to: \.state.alerts.showGuestErrorAlert, on: self)
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
        
        if allTimeList.isEmpty {
            hourList = Array(startTime...endTime)
        } else {
            startTime = min(allTimeList.min()!, startTime)
            endTime = max(allTimeList.max()!, endTime)
            hourList = Array(startTime...endTime)
        }
        
        return Just(hourList)
            .eraseToAnyPublisher()
    }
    
    private func configWeekList(
        _ timeTableCellList: [TimeTableCellInfo]
    ) -> AnyPublisher<[Week], Never> {
        var updatedWeekList = Week.weekDay
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



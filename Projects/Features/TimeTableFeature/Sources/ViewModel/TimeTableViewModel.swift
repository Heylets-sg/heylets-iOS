import Foundation
import Combine
import SwiftUI

import BaseFeatureDependency
import Domain
import DSKit
import Core

@MainActor
public class TimeTableViewModel: ObservableObject {
    struct State {
        struct Alerts {
            var showDeleteAlert: Bool = false
            var showReposrtMissingModuleAlert: Bool = false
            var showAddCustomAlert: Bool = false
            var showGuestErrorAlert: Bool = false
            var showEmptyScheduleErrorAlert: (Bool, String) = (false, "")
            var showSelectInfoView: Bool = false
        }
        
        struct TimeTable {
            var columnCount: Int = 5
            var rowCount: Int = 17
            var isScrollEnabled: Bool = true
        }
        
        var alerts: Alerts = Alerts()
        var timeTable: TimeTable = TimeTable()
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
        case selectedTheme(String)
        case deleteModuleAlertCloseButtonDidTap
        case errorAlertViewCloseButtonDidTap
        case emptyScheduleErrorAddButtonDidTap(String)
        case addCustomModuleButtonDidTap
        case initMainView
        case notRightNowButtonDidTap
        case loginButtonDidTap
    }
    
    enum TransitionAction {
        case gotoTodo
        case gotoMyPage
        case gotoInviteCodeView
    }
    
    @ObservedObject var searchModuleViewModel: SearchModuleViewModel
    @ObservedObject var addCustomModuleViewModel: AddCustomModuleViewModel
    @ObservedObject var themeViewModel: ThemeViewModel
    // 싱글톤 사용
    @ObservedObject private var viewTypeService = TimeTableViewTypeService.shared
    
    @Published var state = State()
    private let cancelBag = CancelBag()
    public var windowRouter: WindowRoutableType
    public var navigationRouter: NavigationRoutableType
    private let useCase: TimeTableUseCaseType
    public var settingViewModel: TimeTableSettingViewModel
    
    var viewType: TimeTableViewType { viewTypeService.viewType }
    
    @Published var timeTableInfo: TimeTableInfo = .empty
    @Published var displayTypeInfo: DisplayTypeInfo = .MODULE_CODE
    @Published var sectionList: [SectionInfo] = []
    @Published var weekList: [Week] = Week.weekDay
    @Published var hourList: [Int] = Array(8...21)
    @Published var timeTable: [TimeTableCellInfo] = []
    @Published var detailSectionInfo: SectionInfo = .empty
    
    @Published var selectLecture: [TimeTableCellInfo] = []
    @Published var selectedThemeColor: [String] = []
    
    private var viewTypeSubscription: AnyCancellable?
    
    public init(
        _ searchModuleViewModel: SearchModuleViewModel,
        _ addCustomModuleViewModel: AddCustomModuleViewModel,
        _ themeViewModel: ThemeViewModel,
        _ settingViewModel: TimeTableSettingViewModel,
        _ navigationRouter: NavigationRoutableType,
        _ windowRouter: WindowRoutableType,
        _ useCase: TimeTableUseCaseType
    ) {
        self.searchModuleViewModel = searchModuleViewModel
        self.addCustomModuleViewModel = addCustomModuleViewModel
        self.themeViewModel = themeViewModel
        self.settingViewModel = settingViewModel
        
        self.useCase = useCase
        self.windowRouter = windowRouter
        self.navigationRouter = navigationRouter
        
        bindState()
        
        timeTable = sectionList.createTimeTableCellList()
        
        viewTypeSubscription = viewTypeService.$viewType
            .sink { [weak self] viewType in
                if viewType == .main {
                    self?.selectLecture = []
                }
            }
    }
    
    func send(_ action: Action) {
        switch action {
        case .onAppear:
            useCase.getProfileInfo()
                .sink(receiveValue: {_ in })
                .store(in: cancelBag)
            
            useCase.fetchTableInfo()
                .receive(on: RunLoop.main)
                .assignLoading(to: \.state.isLoading, on: self)
                .sink(receiveValue: { _ in })
                .store(in: cancelBag)
            
        case .tableCellDidTap(let sectionId):
            Analytics.shared.track(.screenView("module_info", .bottom_sheet))
            viewTypeService.switchTo(.detail)
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
            viewTypeService.switchTo(.search)
            state.error = (false, "")
            
        case .emptyScheduleErrorAddButtonDidTap(let name):
            addCustomModuleViewModel.schedule = name
            state.alerts.showEmptyScheduleErrorAlert = (false, "")
            viewTypeService.switchTo(.addCustom)
            
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
            useCase.addSection(lecture.id, lecture.name, lecture.schedule.isEmpty)
                .receive(on: RunLoop.main)
                .sink(receiveValue: { [weak self] _ in
                    Analytics.shared.track(.moduleAdded)
                    self?.viewTypeService.switchTo(.search)
                    self?.selectLecture = []
                })
                .store(in: cancelBag)
            
        case .initMainView:
            if !(viewType == .search || viewType == .theme(false) || viewType == .addCustom) {
                viewTypeService.reset()
                // Also clear selectLecture when manually resetting to main view
                selectLecture = []
            }
            
        case .addCustomModuleButtonDidTap:
            Analytics.shared.track(.screenView("add_custom_module", .bottom_sheet))
            viewTypeService.switchTo(.addCustom)
            state.alerts.showAddCustomAlert = true
            selectLecture = []
            
        case .notRightNowButtonDidTap:
            Analytics.shared.track(.clickGuestConfirmReject)
            state.alerts.showGuestErrorAlert = false
            
        case .loginButtonDidTap:
            Analytics.shared.track(.clickGuestConfirmLogin)
            windowRouter.switch(to: .login)
            
        case .selectedTheme(let themeName):
            useCase.getThemeDetailInfo(themeName)
                .receive(on: RunLoop.main)
                .assign(to: \.selectedThemeColor, on: self)
                .store(in: cancelBag)
        }
    }
    
    func send(_ action: TransitionAction) {
        switch action {
        case .gotoTodo:
            windowRouter.switch(to: .todo)
        case .gotoMyPage:
            windowRouter.switch(to: .mypage)
        case .gotoInviteCodeView:
            navigationRouter.push(to: .inviteCode)
        }
    }
    
    private func bindState() {
        weak var owner = self
        guard let owner else { return }
        
        useCase.timeTableInfo
            .receive(on: RunLoop.main)
            .assign(to: \.timeTableInfo, on: self)
            .store(in: cancelBag)
        
        useCase.profileInfo
            .receive(on: RunLoop.main)
            .assign(to: \.state.profile, on: self)
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
                self?.viewTypeService.reset()
                self?.settingViewModel.settingAlertType = nil
                // Clear selectLecture on error
                self?.selectLecture = []
            })
            .map { message in (true, message)}
            .assign(to: \.state.error, on: self)
            .store(in: cancelBag)
        
        useCase.guestModeError
            .receive(on: RunLoop.main)
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.viewTypeService.reset()
                self?.settingViewModel.settingAlertType = nil
                // Clear selectLecture on guest mode error
                self?.selectLecture = []
            })
            .map { _ in true }
            .assign(to: \.state.alerts.showGuestErrorAlert, on: self)
            .store(in: cancelBag)
        
        useCase.emptyScheduleError
            .receive(on: RunLoop.main)
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.viewTypeService.reset()
                self?.settingViewModel.settingAlertType = nil
                // Clear selectLecture on empty schedule error
                self?.selectLecture = []
            })
            .map { name in (true, name)}
            .assign(to: \.state.alerts.showEmptyScheduleErrorAlert, on: self)
            .store(in: cancelBag)
    }
}

// Rest of the functions remain the same
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

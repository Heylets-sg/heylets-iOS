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
        struct TimeTable {
            var columnCount: Int = 5
            var rowCount: Int = 17
            var isScrollEnabled: Bool = true
        }
        
        var alertType: HeyTimeTableAlertType? = nil
        var showGuestErrorAlert: Bool = false
        var timeTable: TimeTable = TimeTable()
        var profile: ProfileInfo = .init()
        var isLoading: Bool = false
    }
    
    enum Action {
        case onAppear
        case tableCellDidTap(Int)
        case deleteButtonDidTap
        case selectLecture(SectionInfo)
        case addLecture(SectionInfo)
        case selectedTheme(String)
        case addCustomModuleButtonDidTap
        case initMainView
    }
    
    enum AlertAction {
        case deleteModule
        case deleteModuleAlertCloseButtonDidTap
        case errorAlertViewCloseButtonDidTap
        case emptyScheduleErrorAddButtonDidTap(String)
        case notRightNowButtonDidTap
        case loginButtonDidTap
    }
    
    enum TransitionAction {
        case gotoTodo
        case gotoMyPage
        case gotoInviteCodeView
    }
    
    let searchModuleViewModel: SearchModuleViewModel
    let addCustomModuleViewModel: AddCustomModuleViewModel
    let themeViewModel: ThemeViewModel
    
    @Published var state = State()
    private let cancelBag = CancelBag()
    
    private let store: TimeTableStoreType
    public var windowRouter: WindowRoutableType
    public var navigationRouter: NavigationRoutableType
    
    public var presentCoordinator: any PresentCoordinatorType
    public var sheetCoordinator: SheetCoordinatorType
    
    private let useCase: MainUseCaseType
    public var settingViewModel: TimeTableSettingViewModel
    
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
        _ searchModuleViewModel: SearchModuleViewModel,
        _ addCustomModuleViewModel: AddCustomModuleViewModel,
        _ themeViewModel: ThemeViewModel,
        _ settingViewModel: TimeTableSettingViewModel,
        
        _ store: TimeTableStoreType,
        _ useCase: MainUseCaseType,
        
        _ windowRouter: WindowRoutableType,
        _ navigationRouter: NavigationRoutableType,
        
        _ presentCoordinator: any PresentCoordinatorType,
        _ sheetCoordinator: SheetCoordinatorType
    ) {
        self.searchModuleViewModel = searchModuleViewModel
        self.addCustomModuleViewModel = addCustomModuleViewModel
        self.themeViewModel = themeViewModel
        self.settingViewModel = settingViewModel
        
        self.store = store
        self.useCase = useCase
        
        self.windowRouter = windowRouter
        self.navigationRouter = navigationRouter
        
        self.presentCoordinator = presentCoordinator
        self.sheetCoordinator = sheetCoordinator
        
        bindStore()
        
        timeTable = sectionList.createTimeTableCellList()
    }
    
    func send(_ action: Action) {
        switch action {
        case .onAppear:
            useCase.getProfileInfo()
                .receive(on: RunLoop.main)
                .sink(receiveValue: {_ in })
                .store(in: cancelBag)
            
            useCase.fetchTableInfo()
                .receive(on: RunLoop.main)
                .assignLoading(to: \.state.isLoading, on: self)
                .sink(receiveValue: { _ in })
                .store(in: cancelBag)
            
        case .tableCellDidTap(let sectionId):
            Analytics.shared.track(.screenView("module_info", .bottom_sheet))
            if let detailInfo = sectionList.first(where: { $0.id == sectionId }) {
                detailSectionInfo = detailInfo
                sheetCoordinator.sheet(to: .detail)
            } else { state.alertType = .error("선택한 색션 정보를 찾을 수 없습니다.") }
            
        case .deleteButtonDidTap:
            state.alertType = .deleteAlert
            Analytics.shared.track(.screenView("delete_module", .modal))
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
                    self?.presentCoordinator.switchTo(.search)
                    self?.selectLecture = []
                })
                .store(in: cancelBag)
        case .initMainView:
            let viewType = presentCoordinator.viewType
            if !(viewType == .search || viewType == .theme(false) || viewType == .addCustom) {
                presentCoordinator.reset()
                selectLecture = []
            }
        case .addCustomModuleButtonDidTap:
            Analytics.shared.track(.screenView("add_custom_module", .bottom_sheet))
            presentCoordinator.switchTo(.addCustom)
            selectLecture = []
        case .selectedTheme(let themeName):
            useCase.getThemeDetailInfo(themeName)
                .receive(on: RunLoop.main)
                .assign(to: \.selectedThemeColor, on: self)
                .store(in: cancelBag)
        }
    }
    
    func send(_ action: AlertAction) {
        switch action {
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
            .map { _ in nil }
            .assign(to: \.state.alertType, on: self)
            .store(in: cancelBag)
        case .deleteModuleAlertCloseButtonDidTap:
            state.alertType = nil
        case .errorAlertViewCloseButtonDidTap:
            presentCoordinator.switchTo(.search)
            state.alertType = nil
        case .emptyScheduleErrorAddButtonDidTap(let name):
            addCustomModuleViewModel.schedule = name
            state.alertType = nil
            presentCoordinator.switchTo(.addCustom)
        case .notRightNowButtonDidTap:
            Analytics.shared.track(.clickGuestConfirmReject)
        case .loginButtonDidTap:
            Analytics.shared.track(.clickGuestConfirmLogin)
            windowRouter.switch(to: .login)
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
    
    private func bindStore() {
        weak var owner = self
        guard let owner else { return }
        
        store.timeTableInfo
            .receive(on: RunLoop.main)
            .assign(to: \.timeTableInfo, on: self)
            .store(in: cancelBag)
        
        store.profileInfo
            .receive(on: RunLoop.main)
            .assign(to: \.state.profile, on: self)
            .store(in: cancelBag)
        
        store.displayInfo
            .receive(on: RunLoop.main)
            .assign(to: \.displayTypeInfo, on: self)
            .store(in: cancelBag)
        
        let timeTableCellList = store.sectionList
            .receive(on: RunLoop.main)
            .handleEvents(receiveOutput: {
                owner.sectionList = $0
            })
            .map { $0.createTimeTableCellList() }
            .share()
            
        
        timeTableCellList
            .assign(to: \.timeTable, on: owner)
            .store(in: cancelBag)
        
        timeTableCellList
            .flatMap(configWeekList)
            .sink(receiveValue: {
                owner.weekList = $0
                owner.state.timeTable.isScrollEnabled = $0 != Week.weekDay
                owner.state.timeTable.columnCount = $0.count
            })
            .store(in: cancelBag)
        
        timeTableCellList
            .flatMap(configHourList)
            .sink(receiveValue: {
                owner.hourList = $0
                owner.state.timeTable.rowCount = $0.count
            })
            .store(in: cancelBag)
        
        store.errMessage
            .receive(on: RunLoop.main)
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.presentCoordinator.reset()
                self?.settingViewModel.settingAlertType = nil
                self?.selectLecture = []
            })
            .map { message in .error(message)}
            .assign(to: \.state.alertType, on: self)
            .store(in: cancelBag)
        
        store.guestModeError
            .receive(on: RunLoop.main)
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.presentCoordinator.reset()
                self?.settingViewModel.settingAlertType = nil
                self?.selectLecture = []
            })
            .map { _ in true }
            .assign(to: \.state.showGuestErrorAlert, on: self)
            .store(in: cancelBag)
        
        store.emptyScheduleError
            .receive(on: RunLoop.main)
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.presentCoordinator.reset()
                self?.settingViewModel.settingAlertType = nil
                self?.selectLecture = []
            })
            .map { name in .emptyScheduleError(name)}
            .assign(to: \.state.alertType, on: self)
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

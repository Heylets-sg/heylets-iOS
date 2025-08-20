import Foundation
import Combine
import SwiftUI

import BaseFeatureDependency
import Domain
import DSKit
import Core

@MainActor
public class MainViewModel: ObservableObject {
    struct State {
        var alertType: HeyTimeTableAlertType? = nil
        var showGuestErrorAlert: Bool = false
        var isScrollEnabled: Bool = true
        var profile: ProfileInfo = .init()
        var isLoading: Bool = false
    }
    
    enum Action {
        case onAppear
        case tableCellDidTap(Int)
        case deleteButtonDidTap
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

    @Published var state = State()
    private let cancelBag = CancelBag()
    
    public var store: TimeTableStoreType
    public var windowRouter: WindowRoutableType
    public var navigationRouter: NavigationRoutableType
    
    public var presentCoordinator: any PresentCoordinatorType
    public var sheetCoordinator: SheetCoordinatorType
    
    private let useCase: MainUseCaseType
    public var addCustomViewModel: AddCustomModuleViewModel
    public var settingViewModel: SettingViewModel
    
    @Published var timeTableInfo: TimeTableInfo = .empty
    @Published var displayTypeInfo: DisplayTypeInfo = .MODULE_CODE
    @Published var sectionList: [SectionInfo] = []
    
    @Published var weekList: [Week] = Week.weekDay
    @Published var hourList: [Int] = Array(8...21)
    @Published var timeTable: [TimeTableCellInfo] = []
    
    @Published var detailSectionInfo: SectionInfo = .empty
    
    @Published var timeTableState: TimeTableState
    
    public init(
        _ addCustomViewModel: AddCustomModuleViewModel,
        _ settingViewModel: SettingViewModel,
        
        _ store: TimeTableStoreType,
        _ state: TimeTableState,
        _ useCase: MainUseCaseType,
        
        _ windowRouter: WindowRoutableType,
        _ navigationRouter: NavigationRoutableType,
        
        _ presentCoordinator: any PresentCoordinatorType,
        _ sheetCoordinator: SheetCoordinatorType
    ) {
        self.addCustomViewModel = addCustomViewModel
        self.settingViewModel = settingViewModel
        
        self.store = store
        self.timeTableState = state
        self.useCase = useCase
        
        self.windowRouter = windowRouter
        self.navigationRouter = navigationRouter
        
        self.presentCoordinator = presentCoordinator
        self.sheetCoordinator = sheetCoordinator
        
        bindStore()
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
            Analytics.shared.track(.screenView("delete_module", .modal))
            state.alertType = .deleteAlert
            
        case .initMainView:
            let viewType = presentCoordinator.viewType
            if !(viewType == .search || viewType == .theme(false) || viewType == .addCustom) {
                presentCoordinator.reset()
                timeTableState.selectLecture = []
            }
        case .addCustomModuleButtonDidTap:
            Analytics.shared.track(.screenView("add_custom_module", .bottom_sheet))
            presentCoordinator.switchTo(.addCustom)
            timeTableState.selectLecture = []
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
            addCustomViewModel.schedule = name
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
        store.timeTableDetailInfo
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] detailInfo in
                self?.sectionList = detailInfo.sectionList
                self?.timeTableInfo = detailInfo.tableInfo
                self?.displayTypeInfo = detailInfo.tableInfo.displayType!
                self?.timeTable = detailInfo.timeTableCellList
                self?.weekList = detailInfo.weekList
                self?.hourList = detailInfo.hourList
                self?.state.isScrollEnabled = detailInfo.weekList != Week.weekDay
            })
            .store(in: cancelBag)
        
        store.profileInfo
            .receive(on: RunLoop.main)
            .assign(to: \.state.profile, on: self)
            .store(in: cancelBag)
        
        store.timeTableError
            .receive(on: RunLoop.main)
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.initState()
            })
            .sink(receiveValue: { [weak self] error in
                switch error {
                case .error(let message):
                    self?.state.alertType = .error(message)
                case .emptyScheduleError(let name):
                    self?.state.alertType = .emptyScheduleError(name)
                case .guestModeError:
                    self?.state.showGuestErrorAlert = true
                }
            })
            .store(in: cancelBag)
    }
}

extension MainViewModel {
    func initState() {
        presentCoordinator.reset()
        settingViewModel.settingAlertType = nil
        timeTableState.selectLecture = []
    }
}

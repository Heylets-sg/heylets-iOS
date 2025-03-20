//
//  TimeTableCoordinator.swift
//  TimeTableFeature
//
//  Created by 류희재 on 3/20/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

import Domain
import Core

public class TimeTableCoordinator: ObservableObject {
    // 현재 표시할 화면 타입
    @Published var viewType: TimeTableViewType = .main
    
    // 화면별 필요한 상태값
    @Published var selectedSectionId: Int?
    @Published var selectedSectionInfo: SectionInfo?
    @Published var settingAlertType: TimeTableSettingAlertType?
    @Published var deleteModuleAlertIsPresented: Bool = false
    @Published var reportMissingModuleAlertIsPresented: Bool = false
    
    // 테마 관련 상태
    @Published var isShowingSelectThemeInfoView: Bool = false
    @Published var selectedTheme: Theme?
    
    // 커스텀 모듈 관련 상태
    @Published var isAddCustomSuccess: Bool = false
    
    // 상태 추적을 위한 프로퍼티
    private var previousViewType: TimeTableViewType = .main
    private let cancelBag = CancelBag()
    
    public init() {}
    
    // 화면 전환 함수들
    func showMainView() {
        withAnimation {
            viewType = .main
            clearSelections()
        }
    }
    
    func showDetailView(sectionInfo: SectionInfo) {
        withAnimation {
            selectedSectionInfo = sectionInfo
            viewType = .detail
        }
    }
    
    func showSearchView() {
        withAnimation {
            viewType = .search
        }
    }
    
    func showSettingView() {
        withAnimation {
            viewType = .setting
        }
    }
    
    func showThemeView() {
//        withAnimation {
//            viewType = .theme
//        }
    }
    
    // 테마 관련 함수들
    func showSelectThemeInfoView(isShowing: Bool) {
        withAnimation {
            isShowingSelectThemeInfoView = isShowing
        }
    }
    
    func selectTheme(theme: Theme?) {
        selectedTheme = theme
    }

    // 커스텀 모듈 관련 함수들
    func showAddCustomView() {
        withAnimation {
            viewType = .addCustom
        }
    }
    
    func setAddCustomSuccess(isSuccess: Bool) {
        isAddCustomSuccess = isSuccess
        if isSuccess {
            showMainView()
        }
    }
    
    // 알림창 관련 함수들
    func showSetting(alertType: TimeTableSettingAlertType?) {
        settingAlertType = alertType
        if alertType != nil {
            showMainView()
        }
    }
    
    func showReportMissingModule(isPresented: Bool) {
        reportMissingModuleAlertIsPresented = isPresented
    }
    
    func showDeleteModuleAlert(isPresented: Bool) {
        deleteModuleAlertIsPresented = isPresented
    }
    
    // 상태 초기화
    private func clearSelections() {
        selectedSectionId = nil
        selectedSectionInfo = nil
    }
}

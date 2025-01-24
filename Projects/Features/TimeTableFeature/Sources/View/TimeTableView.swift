//
//  TimeTableView.swift
//  TimeTableFeature
//
//  Created by 류희재 on 12/27/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

import DSKit
import BaseFeatureDependency
import Domain

public enum TimeTableViewType: Equatable {
    case main
    case detail
    case search
    case setting
    case theme
    case addCustom
}

public enum TimeTableSettingAlertType {
    case editTimeTableName
    case shareURL
    case saveImage
    case removeTimeTable
}

public struct TimeTableView: View {
    @EnvironmentObject var container: Router
    @ObservedObject var viewModel: TimeTableViewModel
    @ObservedObject var searchModuleViewModel: SearchModuleViewModel
    @ObservedObject var addCustomModuleViewModel: AddCustomModuleViewModel
    @ObservedObject var themeViewModel: ThemeViewModel
    
    public init(
        viewModel: TimeTableViewModel,
        searchModuleViewModel: SearchModuleViewModel,
        addCustomModuleViewModel: AddCustomModuleViewModel,
        settingTimeTableViewModel: SettingTimeTableViewModel,
        themeViewModel: ThemeViewModel
    ) {
        self.viewModel = viewModel
        self.searchModuleViewModel = searchModuleViewModel
        self.addCustomModuleViewModel = addCustomModuleViewModel
        self.themeViewModel = themeViewModel
    }
    
    public var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Spacer()
                    .frame(height: 1)
                createTopView(viewModel.viewType)
                
                Spacer()
                    .frame(height: 19)
                
                MainView(
                    viewModel: viewModel,
                    viewType: $viewModel.viewType
                )
                Spacer()
                    .frame(height: 1)
            }
            .onTapGesture {
                withAnimation {
                    viewModel.viewType = .main
                }
            }
            .onAppear {
                viewModel.send(.onAppear)
                searchModuleViewModel.addLectureClosure = { lecture in
                    viewModel.send(.addLecture(lecture))
                }
            }
            .heyAlert(
                isPresented: viewModel.state.error.0,
                title: viewModel.state.error.1,
                primaryButton: ("Close", .gray, {
                    viewModel.send(.errorAlertViewCloseButtonDidTap)
                })
            )
            .heyAlert(
                isPresented: viewModel.state.alerts.showDeleteAlert,
                title: "Delete module?",
                primaryButton: ("Delete", .error, {
                    viewModel.send(.deleteModule)
                }),
                secondaryButton: ("Close", .gray, {
                    viewModel.send(.deleteModuleAlertCloseButtonDidTap)
                })
            )
            .sheet(isPresented: $viewModel.state.alerts.showReposrtMissingModuleAlert) {
                ReportMissingModuleView(
                    reportMissingModuleAlertIsPresented: $viewModel.state.alerts.showReposrtMissingModuleAlert
                )
                .transition(.move(edge: .trailing))
                .presentationDetents([.height(802)])
                .presentationDragIndicator(.visible)
            }
            
            SettingTimeTableAlertView(viewModel: viewModel)
        }
        createBottomSheetView(viewModel.viewType)
    }
}

extension TimeTableView {
    @ViewBuilder
    private func createBottomSheetView(_ viewType: TimeTableViewType) -> some View {
        switch viewType {
        case .search:
            SearchModuleView(
                viewType: $viewModel.viewType,
                reportMissingModuleAlertIsPresented: $viewModel.state.alerts.showReposrtMissingModuleAlert,
                viewModel: searchModuleViewModel
            )
            .bottomSheetTransition()
        case .theme:
            SettingTimeTableInfoView(viewModel: themeViewModel)
                .bottomSheetTransition()
        case .detail:
            DetailModuleInfoView(
                viewType: $viewModel.viewType,
                deleteModuleAlertIsPresented: $viewModel.state.alerts.showDeleteAlert,
                sectionInfo: viewModel.detailSectionInfo
            )
            .bottomSheetTransition()
        case .addCustom:
            AddCustomModuleView(viewModel: addCustomModuleViewModel)
                .bottomSheetTransition()
        default:
            EmptyView()
        }
    }
    
    @ViewBuilder
    private func createTopView(_ viewType: TimeTableViewType) -> some View {
        switch viewType {
        case .search:
            SearchModuleTopView(
                viewType: $viewModel.viewType,
                isShowingAddCustomModuleView: $viewModel.state.alerts.showAddCustomAlert,
                viewModel: searchModuleViewModel,
                addCustomViewModel: addCustomModuleViewModel
            )
        case .theme:
            ThemeTopView(
                viewType: $viewModel.viewType,
                viewModel: themeViewModel
            )
        case .addCustom:
            AddCustomModuleTopView(
                viewType: $viewModel.viewType,
                viewModel: addCustomModuleViewModel
            )
        default:
            TopView(
                timeTableInfo: $viewModel.timeTableInfo,
                viewType: $viewModel.viewType,
                settingAlertType: $viewModel.state.alerts.settingAlertType,
                profileInfo: $viewModel.state.profile
            )
            .environmentObject(container)
        }
    }
}

//
//  TimeTableView.swift
//  TimeTableFeature
//
//  Created on 3/27/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import SwiftUI

import DSKit
import BaseFeatureDependency
import Domain
import Core

public struct TimeTableView: View {
    @EnvironmentObject var container: Router
    @ObservedObject var viewModel: TimeTableViewModel
    @ObservedObject var viewTypeService = TimeTableViewTypeService.shared
    
    public init(viewModel: TimeTableViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        NavigationStack(path: $container.navigationRouter.destinations) {
            GeometryReader { proxy in
            ZStack {
                VStack(alignment: .leading) {
                    createTopView(viewTypeService.viewType)
                        .padding(.top, proxy.size.height * viewTypeService.viewType.topViewSpacingRatio)
                    
                    Spacer()
                        .frame(height: proxy.size.height * 0.06)
                    
                    MainView(
                        viewModel: viewModel,
                        viewType: viewTypeService.binding
                    )
                    
                    Spacer()
                        .frame(height: 1)
                }
                .ignoresSafeArea()
                .onAppear {
                    viewModel.send(.onAppear)
                    viewModel.searchModuleViewModel.selectLectureClosure = { lecture in
                        viewModel.send(.selectLecture(lecture))
                    }
                    viewModel.searchModuleViewModel.addLectureClosure = { lecture in
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
                .onAppear {
                    Analytics.shared.track(.screenView("delete_module", .modal))
                }
                .heyAlert(
                    isPresented: viewModel.state.alerts.showGuestErrorAlert,
                    loginButtonAction: {
                        viewModel.send(.loginButtonDidTap)
                    },
                    notRightNowButton: {
                        viewModel.send(.notRightNowButtonDidTap)
                    })
                .sheet(isPresented: $viewModel.state.alerts.showReposrtMissingModuleAlert) {
                    ReportMissingModuleView(
                        reportMissingModuleAlertIsPresented: $viewModel.state.alerts.showReposrtMissingModuleAlert
                    )
                    .transition(.move(edge: .trailing))
                    .presentationDetents([.fraction(0.95)])
                    .presentationDragIndicator(.visible)
                }
                .sheet(isPresented: .constant(viewTypeService.viewType == .setting)) {
                    SettingTimeTableView(
                        viewType: viewTypeService.binding,
                        settingAlertType: $viewModel.settingViewModel.settingAlertType
                    )
                    .presentationDetents([.height(267)])
                    .presentationDragIndicator(.hidden)
                    .ignoresSafeArea(.container, edges: .bottom)
                }
                .sheet(isPresented: .constant(viewTypeService.viewType == .detail)) {
                    DetailModuleInfoView(
                        viewType: viewTypeService.binding,
                        deleteModuleAlertIsPresented: $viewModel.state.alerts.showDeleteAlert,
                        sectionInfo: viewModel.detailSectionInfo
                    )
                    .presentationDetents([.height(280)])
                    .presentationDragIndicator(.hidden)
                    .ignoresSafeArea(.container, edges: .bottom)
                }
                
                if viewTypeService.viewType == .main {
                    TabBarView(
                        todoAction: { viewModel.send(.gotoTodo) },
                        mypageAction: { viewModel.send(.gotoMyPage) }
                    )
                }
                
                SettingTimeTableAlertView(viewModel: viewModel.settingViewModel)
            }
            .setTimeTableHeyNavigation()
            .ignoresSafeArea()
            .overlay {
                let config = OverlayConfiguration.configure(
                    viewType: viewTypeService.viewType,
                    isThemeSelectInfoShowing: viewModel.themeViewModel.state.isShowingSelectInfoView
                )
                
                if config.shouldShow {
                    Color.heyDimmed
                        .opacity(config.opacity)
                        .animation(.easeInOut(duration: 0.3), value: viewTypeService.viewType)
                        .ignoresSafeArea()
                }
            }
            .onTapGesture {
                withAnimation {
                    viewModel.send(.initMainView)
                }
            }
            
            
                VStack {
                    Spacer()
                    createBottomSheetView(viewTypeService.viewType)
                        .onAppear {
                            Analytics.shared.track(.screenView(viewTypeService.viewType.rawValue, .bottom_sheet))
                        }
                        .frame(height: proxy.size.height * viewTypeService.viewType.bottomSheetHeightRatio)
                }
                
            }
            
        }
    }
}

extension TimeTableView {
    @ViewBuilder
    private func createBottomSheetView(_ viewType: TimeTableViewType) -> some View {
        switch viewType {
        case .search:
            SearchModuleView(
                viewType: viewTypeService.binding,
                reportMissingModuleAlertIsPresented: $viewModel.state.alerts.showReposrtMissingModuleAlert,
                viewModel: viewModel.searchModuleViewModel
            )
            .bottomSheetTransition()
            
        case .theme:
            SettingTimeTableInfoView(viewModel: viewModel.themeViewModel)
                .bottomSheetTransition()
            
        case .addCustom:
            AddCustomModuleView(viewModel: viewModel.addCustomModuleViewModel)
                .bottomSheetTransition()
        default:
            EmptyView()
                .frame(height: 0)
        }
    }
    
    @ViewBuilder
    private func createTopView(_ viewType: TimeTableViewType) -> some View {
        switch viewType {
        case .search:
            SearchModuleTopView(
                viewType: viewTypeService.binding,
                addCustomModuleButtonDidTapEvent: {
                    viewModel.send(.addCustomModuleButtonDidTap)
                },
                closeButtonDidTapEvent: {
                    viewModel.searchModuleViewModel.send(.closeButtonDidTap)
                }
            )
            .frame(height: 16)
        case .theme:
            VStack {
                ThemeTopView(
                    viewType: viewTypeService.binding,
                    viewModel: viewModel.themeViewModel
                )
                .frame(height: 22)
                
                ThemeListTopView(
                    viewType: viewTypeService.binding,
                    viewModel: viewModel.themeViewModel
                )
            }
            .onAppear {
                viewModel.themeViewModel.selectThemeClosure = { themeName in
                    viewModel.send(.selectedTheme(themeName))
                }
            }
        case .addCustom:
            AddCustomModuleTopView(
                viewType: viewTypeService.binding,
                viewModel: viewModel.addCustomModuleViewModel
            )
            .frame(height: 19)
        default:
            TopView(
                timeTableInfo: $viewModel.timeTableInfo,
                viewType: viewTypeService.binding,
                profileInfo: $viewModel.state.profile
            )
            .frame(height: 53)
            .environmentObject(container)
        }
    }
}

#Preview {
    let useCase = StubHeyUseCase.stub.timeTableUseCase
    return TimeTableView(
        viewModel: .init(
            .init(useCase),
            .init(useCase),
            .init(useCase, Router.default.navigationRouter),
            .init(useCase),
            Router.default.navigationRouter,
            Router.default.windowRouter,
            useCase)
    )
    .environmentObject(Router.default)
}

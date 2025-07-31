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
    @EnvironmentObject var coordinator: TimeTableCoordinator
    @ObservedObject var viewModel: TimeTableViewModel

    public init(viewModel: TimeTableViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        NavigationStack(path: $container.navigationRouter.destinations) {
            ZStack {
                VStack(alignment: .leading, spacing: 0) {
                    createTopView()
                        .padding(.top, coordinator.presentCoordinator.viewType.topViewTopPadding.adjusted)
                        .padding(.bottom, coordinator.presentCoordinator.viewType.topViewBottomPadding.adjusted)
                        .background(Color.timeTableMain.TimeTableInfo.topNavi)

                    MainView(
                        viewModel: viewModel,
                        viewType: viewTypeService.binding
                    )

                    Spacer(minLength: 0)
                }
                .background(Color.common.Background.default)
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
                .heyAlert(viewModel.state.alertType, viewModel: viewModel)
                .heyAlert(
                    isPresented: viewModel.state.showGuestErrorAlert,
                    loginButtonAction: {
                        viewModel.send(.loginButtonDidTap)
                    },
                    notRightNowButton: {
                        viewModel.send(.notRightNowButtonDidTap)
                    })
//                .sheet(item: viewModel.state.sheetType) { _  in
//                    switch type {
//                    case .reportMissingModule:
//                        ReportMissingModuleView(
////                            reportMissingModuleAlertIsPresented: Binding(
////                                get: { viewModel.state.sheetType != nil },
////                                set: { if !$0 { viewModel.state.sheetType = nil } }
////                            )
//                        )
//                        .transition(.move(edge: .trailing))
//                        .presentationDetents([.fraction(0.95)])
//                        .presentationDragIndicator(.visible)
//
//                    case .setting:
//                        SettingTimeTableView(
//                            settingAlertType: $viewModel.settingViewModel.settingAlertType
//                        )
//                        .presentationDetents([.height(267)])
//                        .presentationDragIndicator(.hidden)
//                        .ignoresSafeArea(.container, edges: .bottom)
//                        .environmentObject(coordinator)
//
//                    case .detail:
//                        DetailModuleInfoView(
//                            sectionInfo: viewModel.detailSectionInfo,
//                            onDelete: { viewModel.send(.deleteButtonDidTap) }
//                        )
//                        .presentationDetents([.height(280)])
//                        .presentationDragIndicator(.hidden)
//                        .ignoresSafeArea(.container, edges: .bottom)
//                        .environmentObject(coordinator)
//                    }
//                }

                if coordinator.presentCoordinator.viewType == .main {
                    VStack {
                        Spacer()
                        TabBarView(
                            todoAction: { viewModel.send(.gotoTodo) },
                            mypageAction: { viewModel.send(.gotoMyPage) }
                        )
                        .frame(height: 82.adjusted)
                        
                        
                    }
                    .ignoresSafeArea(.keyboard, edges: .bottom)
                }

                SettingTimeTableAlertView(viewModel: viewModel.settingViewModel)

                let config = OverlayConfiguration.configure(
                    viewType: coordinator.presentCoordinator.viewType,
                    isThemeSelectInfoShowing: viewModel.themeViewModel.state.isShowingSelectInfoView
                )

                if config.shouldShow {
                    Color.common.Background.opacity60
                        .opacity(config.opacity)
                        .animation(.easeInOut(duration: 0.3), value: coordinator.presentCoordinator.viewType)
                        .ignoresSafeArea()
                }

                VStack {
                    Spacer()
                    createBottomSheetView()
                        .onAppear {
                            Analytics.shared.track(.screenView(coordinator.presentCoordinator.viewType.screenName, .bottom_sheet))
                        }
                        .frame(height: coordinator.presentCoordinator.viewType.bottomSheetHeight.adjusted)
                }
            }
            .setTimeTableHeyNavigation()
            .ignoresSafeArea()
            .onTapGesture {
                withAnimation {
                    viewModel.send(.initMainView)
                }
            }
        }
    }
}

extension TimeTableView {
    @ViewBuilder
    private func createBottomSheetView() -> some View {
        let viewType = coordinator.presentCoordinator.viewType
        switch viewType {
        case .search:
            SearchModuleView(
//                reportMissingModuleAlertIsPresented: $viewModel.state.sheetType,
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
    private func createTopView() -> some View {
        let viewType = coordinator.presentCoordinator.viewType
        switch viewType {
        case .search:
            SearchModuleTopView(
                addCustomModuleButtonDidTapEvent: {
                    viewModel.send(.addCustomModuleButtonDidTap)
                },
                closeButtonDidTapEvent: {
                    viewModel.searchModuleViewModel.send(.closeButtonDidTap)
                }
            )
            .environmentObject(coordinator)
            .frame(height: viewType.topViewHeight.adjusted)

        case .theme:
            VStack {
                ThemeTopView(viewModel: viewModel.themeViewModel)
                    .environmentObject(coordinator)
                    .frame(height: viewType.topViewHeight.adjusted)
                    .padding(.bottom, 23.adjusted)

                ThemeListTopView(viewModel: viewModel.themeViewModel)
                    .environmentObject(coordinator)
            }
            .onAppear {
                viewModel.themeViewModel.selectThemeClosure = { themeName in
                    viewModel.send(.selectedTheme(themeName))
                }
            }

        case .addCustom:
            AddCustomModuleTopView(
                viewModel: viewModel.addCustomModuleViewModel
            )
            .environmentObject(coordinator)
            .frame(height: viewType.topViewHeight.adjusted)

        default:
            TopView(
                timeTableInfo: viewModel.timeTableInfo,
                badgeImage: viewModel.state.profile.university.badgeImage,
                onSearch: { coordinator.presentCoordinator.switchTo(.search) },
                onSetting: { coordinator.sheetCoordinator.sheet(to: .setting) }
            )
            .frame(height: viewType.topViewHeight.adjusted)
            .environmentObject(container)
        }
    }
}





//#Preview {
//    let useCase = StubHeyUseCase.stub.timeTableUseCase
//    return TimeTableView(
//        viewModel: .init(
//            SearchModuleViewModel(useCase),
//            AddCustomModuleViewModel(useCase),
//            ThemeViewModel(useCase, Router.default.navigationRouter),
//            TimeTableSettingViewModel(useCase),
//            Router.default.navigationRouter,
//            Router.default.windowRouter,
//            useCase
//        )
//    )
//    .environmentObject(Router.default)
//    .preferredColorScheme(.dark)
//}

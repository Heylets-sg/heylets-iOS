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
                        .padding(.top, viewModel.presentCoordinator.viewType.topViewTopPadding.adjusted)
                        .padding(.bottom, viewModel.presentCoordinator.viewType.topViewBottomPadding.adjusted)
                        .background(Color.timeTableMain.TimeTableInfo.topNavi)

                    MainView(
                        viewModel: viewModel,
                        presentCoordinator: viewModel.presentCoordinator,
                        sheetCoordinator: viewModel.sheetCoordinator
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
                .sheet(item: $viewModel.sheetCoordinator.sheetType) { type  in
                    switch type {
                    case .reportMissingModule:
                        ReportMissingModuleView(
                            onBack: { coordinator.sheetCoordinator.reset() }
                        )
                        .transition(.move(edge: .trailing))
                        .presentationDetents([.fraction(0.95)])
                        .presentationDragIndicator(.visible)

                    case .setting:
                        SettingTimeTableView(
                            coordinator: coordinator,
                            settingAlertType: $viewModel.settingViewModel.settingAlertType
                        )
                        .presentationDetents([.height(267)])
                        .presentationDragIndicator(.hidden)
                        .ignoresSafeArea(.container, edges: .bottom)

                    case .detail:
                        DetailModuleInfoView(
                            coordinator: viewModel.presentCoordinator,
                            sectionInfo: viewModel.detailSectionInfo,
                            onDelete: { viewModel.send(.deleteButtonDidTap) }
                        )
                        .presentationDetents([.height(280)])
                        .presentationDragIndicator(.hidden)
                        .ignoresSafeArea(.container, edges: .bottom)
                    }
                }

                if viewModel.presentCoordinator.viewType == .main {
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
                    viewType: viewModel.presentCoordinator.viewType,
                    isThemeSelectInfoShowing: viewModel.themeViewModel.state.isShowingSelectInfoView
                )

                if config.shouldShow {
                    Color.common.Background.opacity60
                        .opacity(config.opacity)
                        .animation(.easeInOut(duration: 0.3), value: viewModel.presentCoordinator.viewType)
                        .ignoresSafeArea()
                }

                VStack {
                    Spacer()
                    createBottomSheetView()
                        .onAppear {
                            Analytics.shared.track(.screenView(viewModel.presentCoordinator.viewType.screenName, .bottom_sheet))
                        }
                        .frame(height: viewModel.presentCoordinator.viewType.bottomSheetHeight.adjusted)
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
        switch coordinator.presentCoordinator.viewType {
        case .search:
            SearchModuleView(
                viewModel: viewModel.searchModuleViewModel,
                onReport: { coordinator.sheetCoordinator.sheet(to: .reportMissingModule) }
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
        let viewType = viewModel.presentCoordinator.viewType
        switch viewType {
        case .search:
            SearchModuleTopView(
                coordinator: viewModel.presentCoordinator,
                addCustomModuleButtonDidTapEvent: {
                    viewModel.send(.addCustomModuleButtonDidTap)
                },
                closeButtonDidTapEvent: {
                    viewModel.searchModuleViewModel.send(.closeButtonDidTap)
                }
            )
            .frame(height: viewType.topViewHeight.adjusted)

        case .theme:
            VStack {
                ThemeTopView(
                    coordinator: viewModel.presentCoordinator,
                    viewModel: viewModel.themeViewModel
                )
                .frame(height: viewType.topViewHeight.adjusted)
                .padding(.bottom, 23.adjusted)

                ThemeListTopView(viewModel: viewModel.themeViewModel)
            }
            .onAppear {
                viewModel.themeViewModel.selectThemeClosure = { themeName in
                    viewModel.send(.selectedTheme(themeName))
                }
            }

        case .addCustom:
            AddCustomModuleTopView(
                coordinator: viewModel.presentCoordinator,
                viewModel: viewModel.addCustomModuleViewModel
            )
            .frame(height: viewType.topViewHeight.adjusted)

        default:
            TopView(
                timeTableInfo: viewModel.timeTableInfo,
                badgeImage: viewModel.state.profile.university.badgeImage,
                onSearch: { viewModel.presentCoordinator.switchTo(.search) },
                onSetting: { viewModel.sheetCoordinator.sheet(to: .setting) }
            )
            .frame(height: viewType.topViewHeight.adjusted)
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

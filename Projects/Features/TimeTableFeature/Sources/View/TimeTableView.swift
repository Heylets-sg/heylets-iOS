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

enum TimeTableViewType {
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
    @EnvironmentObject var router: Router
    @ObservedObject var viewModel: TimeTableViewModel
    @ObservedObject var searchModuleViewModel: SearchModuleViewModel
    @ObservedObject var addCustomModuleViewModel: AddCustomModuleViewModel
    
    public init(
        viewModel: TimeTableViewModel,
        searchModuleViewModel: SearchModuleViewModel,
        addCustomModuleViewModel: AddCustomModuleViewModel
    ) {
        self.viewModel = viewModel
        self.searchModuleViewModel = searchModuleViewModel
        self.addCustomModuleViewModel = addCustomModuleViewModel
    }
    
    public var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                switch viewModel.viewType {
                case .search:
                    SearchModuleTopView(
                        viewType: $viewModel.viewType, 
                        isShowingAddCustomModuleView: $viewModel.state.isShowingAddCustomModuleView,
                        viewModel: searchModuleViewModel,
                        addCustomViewModel: addCustomModuleViewModel
                    )
                case .theme:
                    ThemeTopView(viewType: $viewModel.viewType)
                case .addCustom:
                    AddCustomModuleTopView(
                        viewType: $viewModel.viewType,
                        viewModel: addCustomModuleViewModel
                    )
                default:
                    TopView(
                        timeTableInfo: $viewModel.timeTableInfo, 
                        viewType: $viewModel.viewType,
                        settingAlertType: $viewModel.state.settingAlertType
                    )
                    .environmentObject(router)
                }
                
                Spacer()
                    .frame(height: 19)
                
                MainView(
                    viewType: $viewModel.viewType,
                    viewModel: .init(
                        lectureList: viewModel.lectureList
                    )
                )
            }
            .onTapGesture {
                withAnimation {
                    viewModel.viewType = .main
                }
            }
            .onAppear {
                searchModuleViewModel.addLectureClosure = { lecture in
                    viewModel.send(.addLecture(lecture))
                }
            }
            .heyAlert(
                isPresented: viewModel.state.inValidregisterModuleIsPresented.0,
                title: viewModel.state.inValidregisterModuleIsPresented.1,
                primaryButton: ("Close", .gray, {
                    viewModel.send(.inValidregisterModuleAlertCloseButtonDidTap)
                })
            )
            .heyAlert(
                isPresented: viewModel.state.deleteModuleAlertIsPresented,
                title: "Delete module?",
                primaryButton: ("Delete", .error, {
                    viewModel.send(.deleteModule)
                }),
                secondaryButton: ("Close", .gray, {
                    viewModel.send(.deleteModuleAlertCloseButtonDidTap)
                })
            )
            .heySettingTimeTableAlert(viewModel.state.settingAlertType, closeBtnAction: {
                viewModel.send(.settingAlertDismiss)
            })
            .sheet(isPresented: $viewModel.state.reportMissingModuleAlertIsPresented) {
                ReportMissingModuleView(
                    reportMissingModuleAlertIsPresented: $viewModel.state.reportMissingModuleAlertIsPresented
                )
                .transition(.move(edge: .trailing))
                .presentationDetents([.height(802)])
                .presentationDragIndicator(.visible)
            }
        }
        
        switch viewModel.viewType {
        case .search:
            SearchModuleView(
                viewType: $viewModel.viewType, 
                reportMissingModuleAlertIsPresented: $viewModel.state.reportMissingModuleAlertIsPresented,
                viewModel: searchModuleViewModel
            )
            .bottomSheetTransition()
        case .theme:
            SettingTimeTableInfoView()
                .bottomSheetTransition()
        case .detail:
            DetailModuleInfoView(
                viewType: $viewModel.viewType,
                deleteModuleAlertIsPresented: $viewModel.state.deleteModuleAlertIsPresented, viewModel: .init()
            )
            .bottomSheetTransition()
        case .addCustom:
            AddCustomModuleView(viewModel: addCustomModuleViewModel)
            .bottomSheetTransition()
        default:
            EmptyView()
        }
    }
}

public extension View {
    func heySettingTimeTableAlert(
        _ type: TimeTableSettingAlertType?,
        closeBtnAction: @escaping () -> Void
    ) -> some View {
        self.overlay {
            if let type = type {
                ZStack {
                    Color.black.opacity(0.5)
                    
                    Group {
                        switch type {
                        case .editTimeTableName:
                            HeyAlertView(
                                title: "Enter name",
                                isEditedName: true,
                                primaryAction: ("Close", .gray, closeBtnAction),
                                secondaryAction: ("Ok", .primary, {})
                            )
                        case .shareURL:
                            Text("URL copied to clipboard")
                                .font(.medium_18)
                                .foregroundColor(.heyGray1)
                                .padding(.horizontal, 24)
                                .padding(.vertical, 24)
                                .background(Color.heyWhite)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        withAnimation {
                                            closeBtnAction()
                                        }
                                    }
                                }
                        case .saveImage:
                            HeyAlertView(
                                title: "The timetable has been\nsaved as an image.",
                                isEditedName: false,
                                primaryAction: ("Ok", .gray, closeBtnAction)
                            )
                        case .removeTimeTable:
                            HeyAlertView(
                                title: "The timetable has been\nsaved as an image.",
                                isEditedName: false,
                                primaryAction: ("Delete", .primary, {}),
                                secondaryAction: ("Close", .gray, closeBtnAction)
                            )
                        }
                    }
                    .padding(.horizontal, 44)
                    .shadow(radius: 10)
                }
                .ignoresSafeArea()
            } else {
                EmptyView()
            }
        }
    }
    
}

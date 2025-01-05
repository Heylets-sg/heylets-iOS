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
    @State private var viewType: TimeTableViewType = .main
    
    public init(viewModel: TimeTableViewModel) {
        self.viewModel = viewModel
    }
    
    
    public var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                switch viewType {
                case .search:
                    SearchModuleTopView(viewType: $viewType)
                case .theme:
                    ThemeTopView(viewType: $viewType)
                default:
                    TopView(
                        viewType: $viewType,
                        settingAlertType: $viewModel.state.settingAlertType
                    )
                    .environmentObject(router)
                }
                
                Spacer()
                    .frame(height: 19)
                
                MainView(viewType: $viewType, viewModel: .init())
            }
            .onTapGesture {
                withAnimation {
                    viewType = .main
                }
            }
            .heyAlert(
                isPresented: viewModel.state.inValidregisterModuleIsPresented,
                title: "해당 이유가 있겠죠 -> 비즈니스 로직 처리",
                primaryButton: ("Close", .gray, {
                    viewModel.send(.inValidregisterModuleAlertCloseButtonDidTap)
                    viewType = .search
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
        
        switch viewType {
        case .search:
            SearchModuleView(
                viewModel: .init(viewType: $viewType)
            )
            .bottomSheetTransition()
        case .theme:
            SettingTimeTableInfoView()
                .bottomSheetTransition()
        case .detail:
            DetailModuleInfoView(
                viewType: $viewType,
                deleteModuleAlertIsPresented: $viewModel.state.deleteModuleAlertIsPresented, viewModel: .init()
            )
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

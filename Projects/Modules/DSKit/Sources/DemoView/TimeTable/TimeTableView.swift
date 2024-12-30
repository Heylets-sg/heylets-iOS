//
//  TimeTableView.swift
//  TimeTableFeature
//
//  Created by 류희재 on 12/27/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

import DSKit
//import BaseFeatureDependency

enum TimeTableViewType {
    case main
    case detail
    case search
    case setting
    case theme
}

public struct TimeTableView: View {
    //    @EnvironmentObject var router: Router
    @State private var viewType: TimeTableViewType = .main
    @State private var settingAlertType: DemoTimeTableSettingAlertType? = nil
    @State var deleteModuleAlertIsPresented: Bool = false
    @State var inValidregisterModuleIsPresented: Bool = false
    @State var reportMissingModuleAlertIsPresented: Bool = false
    public  init() {}
    
    
    @State private var canTapped = true // 시간표 누를 수 있도록 하는 flag
    @State private var isShowingModuleDetailInfoView = false
    @State private var isShowingSearchModuleView = false
    @State private var isShowingSettingTimeTableView = false
    @State private var isShowingThemeView = false
    
    public var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                
                switch viewType {
                case .search:
                    SearchModuleTopView(viewType: $viewType)
                case .theme:
                    ThemeTopView(viewType: $viewType)
                default:
                    TopView(viewType: $viewType, settingAlertType: $settingAlertType)
                    //                    .environmentObject(router)
                }
                
                Spacer()
                    .frame(height: 19)
                
                MainView(viewType: $viewType)
            }
            .onTapGesture {
                withAnimation {
                    viewType = .main
                }
            }
            .heyAlert(
                isPresented: inValidregisterModuleIsPresented,
                title: "해당 이유가 있겠죠 -> 비즈니스 로직 처리",
                primaryButton: ("Close", .gray, {
                    inValidregisterModuleIsPresented = false
                    viewType = .search
                })
            )
            .heyAlert(
                isPresented: deleteModuleAlertIsPresented,
                title: "Delete module?",
                primaryButton: ("Delete", .error, {
                    //삭제 비즈니스 로직 추가
                    deleteModuleAlertIsPresented = false
                }),
                secondaryButton: ("Close", .gray, {
                    deleteModuleAlertIsPresented = false
                })
            )
//            .heySettingTimeTableAlert(settingAlertType, closeBtnAction: {
//                settingAlertType = nil
//            })
            
            .sheet(isPresented: $reportMissingModuleAlertIsPresented) {
                ReportMissingModuleView(reportMissingModuleAlertIsPresented: $reportMissingModuleAlertIsPresented)
                    .transition(.move(edge: .trailing))
                    .presentationDetents([.height(802)])
                    .presentationDragIndicator(.visible)
            }
        }
        
        switch viewType {
        case .search:
            SearchModuleView(
                viewType: $viewType, 
                reportMissingModuleAlertIsPresented: $reportMissingModuleAlertIsPresented,
                inValidregisterModuleIsPresented: $inValidregisterModuleIsPresented
            )
            .bottomSheetTransition()
        case .theme:
            SettingTimeTableInfoView()
                .bottomSheetTransition()
        case .detail:
            DetailModuleInfoView(
                viewType: $viewType,
                deleteModuleAlertIsPresented: $deleteModuleAlertIsPresented
            )
            .bottomSheetTransition()
        default:
            EmptyView()
        }
    }
}

#Preview {
    TimeTableView()
}

//
//  TimeTableSettingView.swift
//  TimeTableFeature
//
//  Created by 류희재 on 3/20/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import SwiftUI

import DSKit
import BaseFeatureDependency
import Domain
import Core

public enum TimeTableSettingViewType: Equatable {
    case main
    case theme
}

public struct TimeTableSettingView: View {
    @EnvironmentObject var container: Router
    @ObservedObject var themeViewModel: ThemeViewModel
    @State var viewType: TimeTableSettingViewType = .main
    
    public init(themeViewModel: ThemeViewModel) {
        self.themeViewModel = themeViewModel
    }
    
    public var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Spacer()
                    .frame(height: 60)
                
                createTopView(viewType)
                
                Spacer()
                    .frame(height: 19)
                
                MainCaptureContentView(
                    weekList: Week.weekDay,
                    hourList: Array(8...21),
                    timeTable: [],
                    displayType: .MODULE_CODE
                )
                
                Spacer()
                    .frame(height: 1)
            }
            .ignoresSafeArea()
            
            
            SettingTimeTableAlertView(viewModel: themeViewModel)
        }
        .setTimeTableHeyNavigation()
        .navigationBarBackButtonHidden()
        .ignoresSafeArea()
        .overlay {
            Color.heyDimmed
                .ignoresSafeArea()
        }
        //        .sheet(isPresented: $themeViewModel.state.isShowingSelectView) {
        //            SettingTimeTableView(
        ////                viewType: $viewType,
        ////                settingAlertType: $settingAlertType
        //            )
        //            .presentationDetents([.fraction(0.37)])
        //            .presentationDragIndicator(.hidden)
        //            .ignoresSafeArea(.container, edges: .bottom)
        //        }
        
        //        SettingTimeTableInfoView(viewModel: themeViewModel)
        //            .bottomSheetTransition()
        
        SettingTimeTableView(settingAlertType: $themeViewModel.state.settingAlertType)
    }
}

extension TimeTableSettingView {
    @ViewBuilder
    private func createTopView(_ viewType: TimeTableSettingViewType) -> some View {
        switch viewType {
        case .theme:
            ThemeTopView(
//                viewType: $viewModel.viewType,
                viewModel: themeViewModel
            )
            .onAppear {
                themeViewModel.selectThemeClosure = { themeName in
                    themeViewModel.send(.selectedTheme(themeName))
                }
            }
        default:
            SettingTopView(
                timeTableInfo: .stub,
                profileInfo: .stub
            )
            .environmentObject(container)
        }
    }
}

public struct SettingTopView: View {
    var timeTableInfo: TimeTableInfo
    var profileInfo: ProfileInfo
    
    public init(timeTableInfo: TimeTableInfo, profileInfo: ProfileInfo) {
        self.timeTableInfo = timeTableInfo
        self.profileInfo = profileInfo
    }
    
    public var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Spacer()
                    .frame(height: 34)
                
                HStack {
                    Image(uiImage: profileInfo.university.badgeImage)
                        .resizable()
                        .frame(width: 28, height: 14)
                    
                    
                    Text(timeTableInfo.fullSemester)
                        .font(.medium_12)
                        .foregroundColor(.heyGray2)
                }
                .padding(.bottom, 8)
                
                Text(timeTableInfo.timeTableName)
                    .lineLimit(1)
                    .font(.semibold_18)
                    .foregroundColor(.heyGray1)
            }
            
            Spacer()
            
            HStack {
                Image(uiImage: .icAdd.withRenderingMode(.alwaysTemplate))
                    .resizable()
                    .frame(width: 16, height: 16)
                    .tint(.heyGray2)
                    .padding(.trailing, 26)
                
                Image(uiImage: .icSetting.withRenderingMode(.alwaysTemplate))
                    .resizable()
                    .frame(width: 20, height: 20)
                    .tint(.heyGray2)
                    .padding(.trailing, 23)
            }
        }
        .padding(.top, 38)
        .padding(.horizontal, 16)
    }
}

#Preview {
    @State var stub: TimeTableViewType = .main
    let useCase = StubHeyUseCase.stub.timeTableUseCase
    return TimeTableSettingView(
        themeViewModel: .init(useCase, Router.default.navigationRouter)
    )
    .environmentObject(Router.default)
}

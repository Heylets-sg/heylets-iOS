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

public struct TimeTableView: View {
    //    @EnvironmentObject var router: Router
    @State private var viewType: TimeTableViewType = .main
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
                    TopView(viewType: $viewType)
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
        }
        
        switch viewType {
        case .search:
            SearchModuleView()
                .bottomSheetTransition()
        case .theme:
            SettingTimeTableInfoView()
                .bottomSheetTransition()
        case .detail:
            DetailModuleInfoView(viewType: $viewType)
                .bottomSheetTransition()
        default:
            EmptyView()
        }
    }
}

#Preview {
    TimeTableView()
}

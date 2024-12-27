//
//  TimeTableView.swift
//  TimeTableFeature
//
//  Created by 류희재 on 12/27/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

import DSKit

public struct TimeTableView: View {
    public  init() {} 
    @State private var canTapped = true // 시간표 누를 수 있도록 하는 flag
    @State private var isShowingModuleDetailInfoView = false
    @State private var isShowingSearchModuleView = false
    @State private var isShowingSettingTimeTableView = false
    @State private var isShowingThemeView = false
    
    public var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                if isShowingSearchModuleView {
                    SearchModuleTopView(
                        isShowingSearchModuleView: $isShowingSearchModuleView
                    )
                } else if isShowingThemeView {
                    ThemeTopView(
                        isShowingThemeView: $isShowingThemeView
                    )
                } else {
                    TopView(
                        isShowingSearchModuleView: $isShowingSearchModuleView,
                        isShowingSettingTimeTableView: $isShowingSettingTimeTableView, 
                        isShowingThemeView: $isShowingThemeView
                    )
                }
                
                Spacer()
                    .frame(height: 19)
                
                MainView(
                    canTapped: $canTapped, //이걸로 일단 관리하자!
                    isShowingModuleDetailInfoView: $isShowingModuleDetailInfoView
                )
            }
            .onTapGesture {
                isShowingModuleDetailInfoView = false
                isShowingSearchModuleView = false
            }
        }
        if isShowingModuleDetailInfoView {
            DetailModuleInfoView(isShowingModuleDetailInfoView: $isShowingModuleDetailInfoView)
                .zIndex(2)
                .transition(.move(edge: .bottom))
        }
        
        if isShowingSearchModuleView {
            SearchModuleView()
                .zIndex(2)
                .transition(.move(edge: .bottom))
        }
        
        if isShowingThemeView {
            SettingTimeTableInfoView()
                .zIndex(2)
                .transition(.move(edge: .bottom))
        }
    }
}

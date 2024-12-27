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
    public init() {}
    @State private var isShowingModuleDetailInfoView = false
    @State private var isShowingSearchModuleView = false
    @State private var isShowingSettingTimeTableView = false
    
    public var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                if isShowingSearchModuleView {
                    SearchModuleTopView(isShowingSearchModuleView: $isShowingSearchModuleView)
                } else {
                    TopView(isShowingSearchModuleView: $isShowingSearchModuleView)
                }
                
                Spacer()
                    .frame(height: 19)
                
                MainView(isShowingModuleDetailInfoView: $isShowingModuleDetailInfoView)
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
    }
}

#Preview {
    TimeTableView()
}

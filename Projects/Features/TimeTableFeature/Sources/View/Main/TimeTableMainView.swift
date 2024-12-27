//
//  TimeTableMainView.swift
//  TimeTableFeature
//
//  Created by 류희재 on 12/27/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

public struct MainView: View {
    @Binding var isShowingModuleDetailInfoView: Bool
    
    public var body: some View {
        ScrollView(.horizontal) {
            HStack {
                WeeklyListView()
                    .padding(.bottom, 16)
                    .padding(.leading, 30)
            }
            
            ScrollView() {
                HStack(alignment: .top) {
                    HourListView()
                        .padding(.top, 10)
                    
                    TimeTableGridView(isShowingModuleDetailInfoView: $isShowingModuleDetailInfoView)
                }
            }
            .scrollIndicators(.hidden)
            .border(Color.heyGray6, width: 1)
        }
        .scrollIndicators(.hidden)
    }
}
//#Preview {
//    TimeTableMainView()
//}

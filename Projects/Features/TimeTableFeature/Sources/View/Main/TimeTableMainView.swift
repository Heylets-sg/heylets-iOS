//
//  TimeTableMainView.swift
//  TimeTableFeature
//
//  Created by 류희재 on 12/27/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

public struct MainView: View {
    @Binding var viewType: TimeTableViewType
    @Binding var weekList: [Week]
    @Binding var timeTable: [[TimeTableCellInfo?]]
    
    init(
        viewType: Binding<TimeTableViewType>,
        weekList: Binding<[Week]>, timeTable: Binding<[[TimeTableCellInfo?]]>
    ) {
        self._viewType = viewType
        self._weekList = weekList
        self._timeTable = timeTable
    }
    
    public var body: some View {
        ScrollView(.horizontal) {
            HStack {
                WeeklyListView($weekList.wrappedValue)
                    .padding(.bottom, 16)
                    .padding(.leading, 30)
            }
            
            ScrollView() {
                HStack(alignment: .top) {
                    HourListView()
                        .padding(.top, 10)
                    
                    TimeTableGridView(
                        viewType: $viewType,
                        weekList: $weekList,
                        timeTable: $timeTable
                    )
                }
            }
            .scrollIndicators(.hidden)
            .border(Color.heyGray6, width: 1)
        }
        .scrollIndicators(.hidden)
    }
}


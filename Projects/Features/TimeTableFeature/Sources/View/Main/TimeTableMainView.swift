//
//  TimeTableMainView.swift
//  TimeTableFeature
//
//  Created by 류희재 on 12/27/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

public struct MainView: View {
    @State private var capturedImage: UIImage? = nil
    @Binding var viewType: TimeTableViewType
    @StateObject var viewModel: TimeTableMainViewModel
    
    init(
        viewType: Binding<TimeTableViewType>,
        viewModel: TimeTableMainViewModel
    ) {
        self._viewType = viewType
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        MainContentView(
            viewType: $viewType,
            weekList: $viewModel.weekList,
            timeTable: $viewModel.state.timeTable)
            .onAppear {
                viewModel.send(.onAppear)
            }
    }
}

struct MainContentView: View {
    var viewType: Binding<TimeTableViewType>
    var weekList: Binding<[Week]>
    var timeTable: Binding<[[TimeTableCellInfo?]]>
    
    init(viewType: Binding<TimeTableViewType>, weekList: Binding<[Week]>, timeTable: Binding<[[TimeTableCellInfo?]]>) {
        self.viewType = viewType
        self.weekList = weekList
        self.timeTable = timeTable
    }
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                WeeklyListView(weekList.wrappedValue)
                    .padding(.bottom, 16)
                    .padding(.leading, 30)
            }
            
            ScrollView() {
                HStack(alignment: .top) {
                    HourListView()
                        .padding(.top, 10)
                    
                    TimeTableGridView(
                        viewType: viewType,
                        weekList: weekList,
                        timeTable: timeTable
                    )
                }
            }
            .scrollIndicators(.hidden)
            .border(Color.heyGray6, width: 1)
        }
        .scrollIndicators(.hidden)
    }
}


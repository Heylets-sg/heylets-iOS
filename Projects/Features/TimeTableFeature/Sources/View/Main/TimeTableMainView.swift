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
    @StateObject var viewModel: TimeTableMainViewModel
    @StateObject var gridViewModel: TimeTableGridViewModel
    
    init(viewType: Binding<TimeTableViewType>, viewModel: TimeTableMainViewModel) {
        self._viewType = viewType
        self._viewModel = StateObject(wrappedValue: viewModel)
        self._gridViewModel = StateObject(
            wrappedValue: TimeTableGridViewModel(
                timeTableCellList: viewModel.timeTableCellList,
                weekList: viewModel.weekList
            )
        )
    }
    
    public var body: some View {
        ScrollView(.horizontal) {
            HStack {
                WeeklyListView(viewModel.weekList)
                    .padding(.bottom, 16)
                    .padding(.leading, 30)
            }
            
            ScrollView() {
                HStack(alignment: .top) {
                    HourListView()
                        .padding(.top, 10)
                    
                    TimeTableGridView(
                        viewType: $viewType, 
                        viewModel: gridViewModel
                    )
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

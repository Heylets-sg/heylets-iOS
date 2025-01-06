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
    
    init(viewType: Binding<TimeTableViewType>, viewModel: TimeTableMainViewModel) {
        self._viewType = viewType
        self._viewModel = StateObject(wrappedValue: viewModel)
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
                        weekList: $viewModel.weekList,
                        timeTable: $viewModel.state.timeTable
                    )
                }
            }
            .scrollIndicators(.hidden)
            .border(Color.heyGray6, width: 1)
        }
        .onAppear {
            viewModel.send(.onAppear)
        }
        .scrollIndicators(.hidden)
    }
}
//#Preview {
//    TimeTableMainView()
//}

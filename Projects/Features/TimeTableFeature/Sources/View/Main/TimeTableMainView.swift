//
//  TimeTableMainView.swift
//  TimeTableFeature
//
//  Created by 류희재 on 12/27/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

import Domain

public struct MainView: View {
    @Binding var viewType: TimeTableViewType
    @ObservedObject var viewModel: TimeTableViewModel
    
    init(
        viewModel: TimeTableViewModel,
        viewType: Binding<TimeTableViewType>
    ) {
        self.viewModel = viewModel
        self._viewType = viewType
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
                        viewModel: viewModel,
                        viewType: $viewType
                    )
                }
            }
            .scrollIndicators(.hidden)
            .border(Color.heyGray6, width: 1)
        }
        .scrollIndicators(.hidden)
    }
}


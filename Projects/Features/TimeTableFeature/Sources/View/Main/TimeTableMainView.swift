//
//  TimeTableMainView.swift
//  TimeTableFeature
//
//  Created by 류희재 on 12/27/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

import Domain
import DSKit

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
        BounceScrollView(axis: .horizontal) {
            HStack {
                WeeklyListView(viewModel.weekList)
                    .padding(.bottom, 16)
                    .padding(.leading, 49)
                    .padding(.trailing, 35)
            }
            
            BounceScrollView(axis: .vertical) {
                HStack(alignment: .top, spacing: 0) {
                    HourListView(viewModel.hourList)
                    
                    TimeTableGridView(
                        viewModel: viewModel,
                        displayType: $viewModel.displayTypeInfo,
                        viewType: $viewType
                    )
                }
            }
        }
        .scrollDisabled(viewModel.state.timeTable.isScrollDisabled)
        .scrollIndicators(.hidden)
    }
}

#Preview {
    @State var stub: TimeTableViewType = .main
    return MainView(
        viewModel: .init(StubHeyUseCase.stub.timeTableUseCase),
        viewType: $stub
    )
}

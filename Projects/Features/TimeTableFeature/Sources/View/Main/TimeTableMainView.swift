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
        GeometryReader { geometry in
            let cellWidth: CGFloat = (geometry.size.width - 25) / CGFloat(5)
            ScrollView(.horizontal) {
                WeeklyListView(viewModel.weekList, cellWidth: cellWidth)
                    .padding(.bottom, 16)
                    .padding(.leading, 25)
                
                ScrollView {
                    HStack(alignment: .top, spacing: 0) {
                        HourListView(viewModel.hourList)
                        
                        TimeTableGridView(
                            viewModel: viewModel,
                            displayType: $viewModel.displayTypeInfo,
                            viewType: $viewType,
                            cellWidth: cellWidth
                        )
                    }
                }
                .scrollIndicators(.hidden)
            }
            .scrollIndicators(.hidden)
            .scrollDisabled(!viewModel.state.timeTable.isScrollEnabled)
        }
        
    }
}

#Preview {
    @State var stub: TimeTableViewType = .main
    return MainView(
        viewModel: .init(StubHeyUseCase.stub.timeTableUseCase),
        viewType: $stub
    )
}

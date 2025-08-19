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
import BaseFeatureDependency
import Core

public struct MainView: View {
    @ObservedObject var viewModel: MainViewModel
    @ObservedObject var state: TimeTableState
    var coordinator: any PresentCoordinatorType
    
    init(
        state: TimeTableState,
        viewModel: MainViewModel,
        coordinator: any PresentCoordinatorType,
    ) {
        self.state = state
        self.viewModel = viewModel
        self.coordinator = coordinator
    }
    
    public var body: some View {
        GeometryReader { geometry in
            let cellWidth: CGFloat = (geometry.size.width - 25) / CGFloat(5)
            
            ScrollView(.horizontal) {
                WeeklyListView(viewModel.weekList, cellWidth: cellWidth)
                    .padding(.leading, 25)
                    .padding(.bottom, 16.adjusted)
                    .background(Color.timeTableMain.TimeTableInfo.topNavi)
                
                ScrollViewReader { proxy in
                    ScrollView {
                        HStack(alignment: .top, spacing: 0) {
                            HourListView(viewModel.hourList)
                            
                            GeometryReader { geometry in
                                VStack {
                                    let columnCount = viewModel.weekList.count
                                    let rowCount = viewModel.hourList.count
                                    
                                    ZStack {
                                        // 📌 빈 시간표 배치
                                        TimeTableBlankView(
                                            rowCount: rowCount,
                                            columnCount: columnCount,
                                            cellWidth: cellWidth
                                        )
                                        
                                        TimeTableExsitedView(
                                            viewModel: viewModel,
                                            displayType: $viewModel.displayTypeInfo,
                                            cellWidth: cellWidth,
                                            canTouch: coordinator.isMain()
                                        )
//                                        
//                                        TimeTableSelectedView(
//                                            selectLecture: $state.selectLecture,
//                                            weekList: viewModel.weekList,
//                                            hourList: viewModel.hourList,
//                                            cellWidth: cellWidth
//                                        )
                                    }
                                }
                            }
                        }
                    }
                    
                    .padding(.bottom, coordinator.isMain() ? 50 : 0)
                }
                
            }
            .loading(viewModel.state.isLoading)
            .scrollIndicators(.hidden)
            .scrollDisabled(!viewModel.state.isScrollEnabled)
        }
    }
}



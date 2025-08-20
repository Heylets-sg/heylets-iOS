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
                            
                            VStack {
                                let columnCount = viewModel.weekList.count
                                let rowCount = viewModel.hourList.count
                                
                                ZStack {
                                    // 📌 빈 시간표 배치
                                    TimeTableBlankView(
                                        rowCount: rowCount,
                                        columnCount: columnCount,
                                        cellWidth: cellWidth,
                                        timeTableState: state
                                    )
                                    
                                    TimeTableExsitedView(
                                        viewModel: viewModel,
                                        displayType: $viewModel.displayTypeInfo,
                                        cellWidth: cellWidth,
                                        canTouch: coordinator.isMain()
                                    )
                                    
                                    TimeTableSelectedView(
                                        selectLecture: $state.selectLecture,
                                        weekList: viewModel.weekList,
                                        hourList: viewModel.hourList,
                                        cellWidth: cellWidth
                                    )
                                }
                                
                                if isBottomSheetPresented() {
                                    Spacer()
                                        .frame(height: getBottomSheetHeight() + 100) // 여유 공간 추가
                                        .id("bottom-spacer")
                                }
                            }
                            
                        }
                    }
                    .padding(.bottom, coordinator.isMain() ? 50 : 0)
                    .onChange(of: state.selectLecture) { lecture in
                        guard let schedule = lecture.first?.schedule else { return }
                        
                        let targetRow = calculateRowFromTime(viewModel.hourList[0], schedule.startTime)
                        let targetColumn = schedule.day.index
                        let targetId = "grid-cell-\(targetRow)-\(targetColumn)"
                        
                        withAnimation(.easeInOut(duration: 0.6)) {
                            proxy.scrollTo(targetId, anchor: .center)
                        }
                    }
                }
            }
            .loading(viewModel.state.isLoading)
            .scrollIndicators(.hidden)
            .scrollDisabled(!viewModel.state.isScrollEnabled)
        }
    }
}



extension MainView {
    private func calculateRowFromTime(_ baseHour: Int, _ timeString: String) -> Int {
        // 시간 파싱 로직
        let components = timeString.split(separator: ":")
        guard let hour = Int(components[0]), let minute = Int(components[1]) else { return 0 }
        
        // 8시를 기준(0)으로 계산
        let baseHour = 8
        let rowIndex = (hour - baseHour) * 2 + (minute >= 30 ? 1 : 0)
        
        return max(0, min(rowIndex, viewModel.hourList.count - 1))
    }
    
    private func isBottomSheetPresented() -> Bool {
        let currentViewType = coordinator.viewType
        let isPresented = currentViewType != .main
        return isPresented
    }
    
    private func getBottomSheetHeight() -> CGFloat {
        if isBottomSheetPresented() {
            let height = coordinator.viewType.bottomSheetHeight.adjusted
            return height
        }
        return 0
    }
}

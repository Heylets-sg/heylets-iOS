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
                            }
                            
                        }
                    }
                    .padding(.bottom, coordinator.isMain() ? 50 : 0)
                    .onChange(of: state.selectLecture) { lecture in
                        guard let schedule = lecture.first?.schedule else { return }
                        
                        // 강의의 시간 정보로부터 row, column 계산
                        let targetRow = calculateRowFromTime(schedule.startHour)
                        let targetColumn = schedule.day.index
                        
                        let targetId = "grid-cell-\(targetRow)-\(targetColumn)"
                        
                        // 📌 바텀시트가 있을 때는 더 위쪽으로 스크롤
                        let anchor: UnitPoint = isBottomSheetPresented() ? .top : .center
                        
                        withAnimation(.easeInOut(duration: 0.8)) {
                            proxy.scrollTo(targetId, anchor: anchor)
                        }
                        
                        // 📌 추가 스크롤로 바텀시트 아래 부분까지 보이게 하기
                        if isBottomSheetPresented() {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                // 바텀시트 높이의 절반만큼 추가로 스크롤
                                let bottomSheetHeight = getBottomSheetHeight()
                                let additionalOffset = bottomSheetHeight * 0.6
                                
                                // 현재 스크롤 위치에서 추가로 아래로 스크롤
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    proxy.scrollTo(targetId, anchor: .top)
                                }
                            }
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
    private func calculateRowFromTime(_ hour: Int) -> Int {
        // 시간 파싱 로직
        //            let components = timeString.split(separator: ":")
        //            guard let hour = Int(components[0]), let minute = Int(components[1]) else { return 0 }
        
        // 8시를 기준(0)으로 계산
        let baseHour = 8
        let rowIndex = (hour - baseHour) * 2
        
        return max(0, min(rowIndex, viewModel.hourList.count - 1))
    }
    
    // 📌 바텀시트가 현재 표시되고 있는지 확인
    private func isBottomSheetPresented() -> Bool {
        // viewModel이나 coordinator에서 바텀시트 상태를 확인
        return coordinator.viewType != .main // 또는 적절한 조건
    }
    
    // 📌 현재 바텀시트의 높이 가져오기
    private func getBottomSheetHeight() -> CGFloat {
        if isBottomSheetPresented() {
            return coordinator.viewType.bottomSheetHeight.adjusted
        }
        return 0
    }
}

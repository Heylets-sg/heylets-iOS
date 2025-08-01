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

public struct MainView: View {
    @ObservedObject var viewModel: TimeTableViewModel
    var presentCoordinator: any PresentCoordinatorType
    var sheetCoordinator: any SheetCoordinatorType
    
    init(
        viewModel: TimeTableViewModel,
        presentCoordinator: any PresentCoordinatorType,
        sheetCoordinator: SheetCoordinatorType
    ) {
        self.viewModel = viewModel
        self.presentCoordinator = presentCoordinator
        self.sheetCoordinator = sheetCoordinator
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
                                    let columnCount = viewModel.state.timeTable.columnCount
                                    let rowCount = viewModel.state.timeTable.rowCount
                                    
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
                                            canTouch: presentCoordinator.isMain()
                                        )
                                        
                                        TimeTableSelectedView(
                                            selectLecture: $viewModel.selectLecture,
                                            weekList: viewModel.weekList,
                                            hourList: viewModel.hourList,
                                            cellWidth: cellWidth
                                        )
                                    }
                                }
                            }
                        }
                    }
                    .padding(.bottom, presentCoordinator.isMain() ? 50 : 0)
                }
            }
            .loading(viewModel.state.isLoading)
            .scrollIndicators(.hidden)
            .scrollDisabled(!viewModel.state.timeTable.isScrollEnabled)
        }
    }
    
}

extension MainView {
    private func configButtonLayout(
        _ firstTime: Int,
        for cell: TimeTableCellInfo,
        cellHeight: CGFloat
    ) -> CGFloat {
        let startHour = cell.schedule.startHour
        let startMinute = cell.schedule.startMinute
        
        // 강의가 맨 위보다 위에 있는 경우 처리
        if startHour < firstTime {
            return 0 // 맨 위로 스크롤
        }
        
        // 시작 시간과 분을 기준으로 정확한 시작 위치 계산
        let hourOffset = CGFloat(startHour - firstTime) * cellHeight
        let minuteOffset = CGFloat(startMinute) / 60.0 * cellHeight
        
        // 최종 위치 반환 (약간 위로 오프셋 적용하여 더 보기 좋게)
        return max(0, hourOffset + minuteOffset - 20)
    }
}

//#Preview {
//    let useCase = StubHeyUseCase.stub.timeTableUseCase
//    return TimeTableView(
//        viewModel: .init(
//            .init(useCase),
//            .init(useCase),
//            .init(useCase, Router.default.navigationRouter),
//            .init(useCase),
//            Router.default.navigationRouter,
//            Router.default.windowRouter,
//            useCase)
//    )
//    .environmentObject(Router.default)
//}

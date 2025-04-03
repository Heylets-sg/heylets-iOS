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
    @Binding var viewType: TimeTableViewType
    @ObservedObject var viewModel: TimeTableViewModel
    @State private var scrollViewProxy: ScrollViewProxy?
    
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
                    .padding(.leading, 25)
                
                ScrollViewReader { proxy in
                    ScrollView {
                        HStack(alignment: .top, spacing: 0) {
                            HourListView(viewModel.hourList)
                            
                            TimeTableGridView(
                                viewModel: viewModel,
                                displayType: $viewModel.displayTypeInfo,
                                viewType: $viewType,
                                cellWidth: cellWidth
                            )
                            .onAppear {
                                scrollViewProxy = proxy
                            }
                            .onChange(of: viewModel.selectLecture) { _ in
                                if let firstSelectLecture = viewModel.selectLecture.first {
                                    let offsetY: CGFloat = configButtonLayout(
                                        viewModel.hourList[0],
                                        for: firstSelectLecture,
                                        cellHeight: 52
                                    )
                                    scrollToPosition(proxy: scrollViewProxy, position: offsetY)
                                }
                                else {
                                    scrollToPosition(proxy: scrollViewProxy)
                                }
                            }
                        }
                    }
                    .padding(.bottom, viewType == .main ? 50 : 0)
                }
            }
            .loading(viewModel.state.isLoading)
            .scrollIndicators(.hidden)
            .scrollDisabled(!viewModel.state.timeTable.isScrollEnabled)
        }
    }
    
}

extension MainView {
    private func scrollToPosition(proxy: ScrollViewProxy?, position: CGFloat? = nil) {
        guard let proxy = proxy else { return }
        
        if let position = position {
            // 정확한 스크롤 위치 계산
            // 강의 시작 시간에 해당하는 행(row) ID를 찾습니다
            let hourIndex = Int(position / 52)
            
            // viewModel.hourList의 인덱스 범위를 확인하여 유효한 인덱스만 사용
            let safeHourIndex = max(0, min(hourIndex, viewModel.hourList.count - 1))
            
            // 해당 시간을 scrollTo의 ID로 사용하여 스크롤
            DispatchQueue.main.async {
                withAnimation(.easeInOut(duration: 0.5)) {
                    proxy.scrollTo(safeHourIndex, anchor: .top)
                }
            }
        } else {
            // position이 nil인 경우 맨 위로 스크롤
            DispatchQueue.main.async {
                withAnimation(.easeInOut(duration: 0.5)) {
                    proxy.scrollTo(0, anchor: .top)
                }
            }
        }
    }
    
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

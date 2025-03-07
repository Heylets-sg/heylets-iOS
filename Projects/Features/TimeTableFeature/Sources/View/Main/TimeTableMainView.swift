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
                }
            }
            .scrollIndicators(.hidden)
            .scrollDisabled(!viewModel.state.timeTable.isScrollEnabled)
        }
    }
    
}

extension MainView {
    private func scrollToPosition(proxy: ScrollViewProxy?, position: CGFloat? = nil) {
        guard let proxy = proxy else { return }
        
        let targetIndex = position != nil ? Int(position! / 52) : 0
        
        withAnimation {
            proxy.scrollTo(targetIndex, anchor: .top) // 스크롤 이동
        }
    }
    
    private func configButtonLayout(
        _ firstTime: Int,
        for cell: TimeTableCellInfo,
        cellHeight: CGFloat
    ) -> CGFloat {
        let startHour = cell.schedule.startHour
        let startMinute = cell.schedule.startMinute
        
        // 시작 시간과 분을 기준으로 시작 위치 계산
        let y = CGFloat(startHour - firstTime) * cellHeight + CGFloat(startMinute) / 60 * cellHeight
        
        return y 
    }
}

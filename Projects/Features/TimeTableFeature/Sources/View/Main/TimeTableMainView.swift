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
                                // ScrollViewProxy 저장
                                scrollViewProxy = proxy
                            }
                            .onChange(of: viewModel.selectLecture) { _ in
                                if let firstSelectLecture = viewModel.selectLecture.first {
                                    // 화면에 완전히 로드된 후에 scrollTo가 호출되도록 하기 위해 delay를 줄 수 있습니다.
                                    
                                    let offsetY: CGFloat = configButtonLayout(
                                        viewModel.hourList[0],
                                        for: firstSelectLecture,
                                        cellHeight: 52
                                    )
                                    scrollToPosition(proxy: scrollViewProxy, position: offsetY)
                                    
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
    private func scrollToPosition(proxy: ScrollViewProxy?, position: CGFloat) {
        guard let proxy = proxy else { return }
        
        // 목표 위치를 계산하여 scrollTo 호출
        let targetIndex = Int(position / 52) // 한 항목의 높이를 기준으로 인덱스 계산 (예시: 50포인트 높이)
        
        print("===🐘===\(position)==\(targetIndex)")
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
        let endHour = cell.schedule.endHour
        let endMinute = cell.schedule.endMinute
        
        // 시작 시간과 분을 기준으로 시작 위치 계산
        let y = CGFloat(startHour - firstTime) * cellHeight + CGFloat(startMinute) / 60 * cellHeight
        
        // 종료 시간과 분을 기준으로 높이 계산
        let height = CGFloat(endHour - startHour) * cellHeight +
        CGFloat(endMinute - startMinute) / 60 * cellHeight
        
        return y + 450
    }
}


//#Preview {
//    @State var stub: TimeTableViewType = .main
//    return MainView(
//        viewModel: .init(StubHeyUseCase.stub.timeTableUseCase),
//        viewType: $stub
//    )
//}

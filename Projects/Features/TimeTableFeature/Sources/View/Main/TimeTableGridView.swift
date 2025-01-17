//
//  TimeTableGridView.swift
//  TimeTableFeature
//
//  Created by 류희재 on 12/27/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

import Domain

public struct TimeTableGridView: View {
    @ObservedObject var viewModel: TimeTableViewModel
    @Binding var viewType: TimeTableViewType
    var hourList = Array(9...24)
    
    public var body: some View {
        Grid(horizontalSpacing: 0, verticalSpacing: 0) {
            createHeaderRow()
            
            ForEach(hourList, id: \.self) { hour in
                createGridRow(for: hour)
            }
        }
        .onAppear {
        }
    }
    
    @ViewBuilder
    private func createHeaderRow() -> some View {
        GridRow {
            ForEach(viewModel.weekList, id: \.self) { _ in
                Rectangle()
                    .fill(Color.clear)
                    .overlay(Rectangle().stroke(Color.heyGray6, lineWidth: 0.5))
                    .frame(width: 73, height: 21)
            }
        }
    }
    
    @ViewBuilder
    private func createGridRow(for hour: Int) -> some View {
        GridRow(alignment: .top) {
            ForEach(viewModel.weekList, id: \.self) { day in
                createGridCell(for: hour, day: day)
            }
        }
    }
    
    @ViewBuilder
    private func createGridCell(for hour: Int, day: Week) -> some View {
        ZStack {
            Rectangle()
                .fill(Color.clear)
                .overlay(Rectangle().stroke(Color.heyGray6, lineWidth: 0.5))
            
            if let cell = getSlot(
                timeTable: viewModel.timeTable,
                for: hour,
                day: day
            ) {
                Button {
                    withAnimation {
                        viewModel.send(.tableCellDidTap(cell.id))
                    }
                } label: {
                    ZStack {
                        VStack {
                            if hour == cell.schedule.startHour {
                                Spacer()
                                Color.heySubMain.opacity(0.5)
                                    .frame(height: getCellHeight(for: cell, hour: hour))
                                    .clipped()
                            } else if hour == cell.schedule.endHour {
                                // 종료 시간일 때 위로 배치
                                Color.heySubMain.opacity(0.5)
                                    .frame(height: getCellHeight(for: cell, hour: hour))
                                    .clipped()
                                Spacer()
                            } else {
                                Color.heySubMain.opacity(0.5)
                                    .frame(height: getCellHeight(for: cell, hour: hour))
                                    .clipped()
                            }
                        }

                        // 시간 시작에만 텍스트 보여주기
                        if hour == cell.schedule.startHour {
                            VStack(alignment: .leading) {
                                Spacer()
                                    .frame(height: getCellHeight(for: cell, hour: hour))
                                Text(cell.name)
                                    .font(.medium_12)
                                    .multilineTextAlignment(.center)
                                Text(cell.schedule.location)
                                    .font(.regular_10)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
                .disabled(!(viewType == .main))
            }
        }
        .frame(width: 73, height: 52)
    }
    
    private func getCellHeight(for cell: TimeTableCellInfo, hour: Int) -> CGFloat {
        var baseHeight: CGFloat = 52 // 기본 셀 높이
        if let colorRatio = cell.slot[hour-9] {
            baseHeight *= CGFloat(colorRatio)
        } else {
            print(hour)
        }
        return baseHeight
    }
    
    private func getSlot(timeTable: [[TimeTableCellInfo?]], for hour: Int, day: Week) -> TimeTableCellInfo? {
        guard day.index < timeTable.count,
              hour - 9 < timeTable[day.index].count else { return nil }
        return timeTable[day.index][hour - 9]
    }
    
}

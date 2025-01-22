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
    @Binding var displayType: DisplayTypeInfo
    @Binding var viewType: TimeTableViewType
    var hourList = Array(8...24)
    
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
                    .frame(width: 70, height: 21)
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
        VStack {
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
                                if cell.schedule.startMinute != 0 {
                                    Spacer()
                                }
                                cell.backgrounColor
                                    .frame(height: getCellHeight(for: cell, hour: hour))
                                    .clipped()
                            } else if hour == cell.schedule.endHour {
                                // 종료 시간일 때 위로 배치
                                cell.backgrounColor
                                    .frame(height: getCellHeight(for: cell, hour: hour))
                                    .clipped()
                                if cell.schedule.endMinute != 0 {
                                    Spacer()
                                }
                            } else {
                                cell.backgrounColor
                                    .frame(height: getCellHeight(for: cell, hour: hour))
                                    .clipped()
                            }
                        }

                        // 시간 시작에만 텍스트 보여주기
                        if hour == cell.schedule.startHour {
                            VStack(alignment: .leading) {
                                if cell.schedule.startMinute != 0 {
                                    Spacer()
                                        .frame(height: getCellHeight(for: cell, hour: hour))
                                }
                                Text(cell.code)
                                    .font(.medium_12)
                                    .foregroundColor(cell.textColor)
                                    .multilineTextAlignment(.center)
                                
                                if displayType.classRoomIsVisible {
                                    Text(cell.schedule.location)
                                        .font(.regular_10)
                                        .foregroundColor(cell.textColor)
                                }
                                
                                if displayType.creditIsVisible && cell.unit != nil{
                                    Text("unit: \(cell.unit!)")
                                        .font(.regular_10)
                                        .foregroundColor(cell.textColor)
                                }
                            }
                        }
                    }
                }
                .buttonStyle(PlainButtonStyle())
                .clipShape(RoundedRectangle(cornerRadius: 2))
                .disabled(!(viewType == .main))
            } else {
                Rectangle()
                    .fill(Color.clear)
                    .overlay(Rectangle().stroke(Color.heyGray6, lineWidth: 0.5))
            }
        }
        .frame(width: 70, height: 52)
    }
    
    private func getCellHeight(for cell: TimeTableCellInfo, hour: Int) -> CGFloat {
        var baseHeight: CGFloat = 52 // 기본 셀 높이
        if let colorRatio = cell.slot[hour-8] {
            baseHeight *= CGFloat(colorRatio)
        } else {
            print(hour)
        }
        return baseHeight
    }
    
    private func getSlot(timeTable: [[TimeTableCellInfo?]], for hour: Int, day: Week) -> TimeTableCellInfo? {
        guard day.index < timeTable.count,
              hour - 8 < timeTable[day.index].count else { return nil }
        return timeTable[day.index][hour - 8]
    }
    
}

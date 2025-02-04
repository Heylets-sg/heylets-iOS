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
    }
    
    @ViewBuilder
    private func createHeaderRow() -> some View {
        GridRow {
            ForEach(viewModel.weekList, id: \.self) { _ in
                Rectangle()
                    .fill(Color.clear)
                    .overlay(Rectangle().stroke(Color.heyGray6, lineWidth: 0.5))
                    .frame(height: 21)
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
            if let cell = getSlot(timeTable: viewModel.timeTable, for: hour, day: day) {
                Button {
                    withAnimation {
                        viewModel.send(.tableCellDidTap(cell.id))
                    }
                } label: {
                    ZStack {
                        createCellBackground(cell: cell, hour: hour)
                        
                        VStack {
                            if hour == cell.schedule.startHour {
                                createCellText(cell: cell)
//                                    .padding(.top, cell.schedule.startMinute != 0
//                                             ? getCellHeight(for: cell, hour: hour)
//                                             : 0
//                                    )
                            }
                        }
                    }
                }
                .buttonStyle(PlainButtonStyle())
                .clipShape(RoundedRectangle(cornerRadius: 2))
                .disabled(!(viewType == .main))
            } else {
                createEmptyCell()
            }
        }
        .frame(height: 52)
    }
    
    @ViewBuilder
    private func createCellBackground(cell: TimeTableCellInfo, hour: Int) -> some View {
        VStack {
            if hour == cell.schedule.startHour && cell.schedule.startMinute != 0 {
                    Spacer()
                        .allowsHitTesting(false)
            }
            
            cell.backgrounColor
                .frame(height: getCellHeight(for: cell, hour: hour))
                .clipped()
            
            if hour == cell.schedule.endHour && cell.schedule.endMinute != 0 {
                Spacer()
                    .allowsHitTesting(false)
            }
        }
    }
    
    @ViewBuilder
    private func createCellText(cell: TimeTableCellInfo) -> some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text(cell.code)
                        .font(.medium_12)
                        .foregroundColor(cell.textColor)
                    
                    if displayType.classRoomIsVisible {
                        Text(cell.schedule.location)
                            .font(.regular_10)
                            .foregroundColor(cell.textColor)
                    }
                    
                    //            if displayType.creditIsVisible, let unit = cell.unit {
                    //                Text("unit: \(unit)")
                    //                    .font(.regular_10)
                    //                    .foregroundColor(cell.textColor)
                    //            }
                    
                    Spacer()
                }
                .padding(.leading, 4)
                
                Spacer()
            }
            
            
        }
    }
    
    @ViewBuilder
    private func createEmptyCell() -> some View {
        Rectangle()
            .fill(Color.clear)
            .overlay(Rectangle().stroke(Color.heyGray6, lineWidth: 0.5))
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

#Preview {
    @State var stub_viewType: TimeTableViewType = .main
    @State var stub_displayType: DisplayTypeInfo = .MODULE_CODE_CLASSROOM_CREDIT
    return TimeTableGridView(
        viewModel: .init(StubHeyUseCase.stub.timeTableUseCase),
        displayType: $stub_displayType,
        viewType: $stub_viewType
    )
}


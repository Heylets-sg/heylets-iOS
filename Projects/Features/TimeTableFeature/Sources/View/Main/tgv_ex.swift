//TimeTableGridView.swift
//TimeTableFeature
//
//Created by 류희재 on 12/27/24.
//Copyright © 2024 Heylets-iOS. All rights reserved.

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
        GeometryReader { geometry in
            let gridWidth = geometry.size.width
            let gridHeight = geometry.size.height
            let columnCount = viewModel.weekList.count
            let rowCount = hourList.count
            let cellWidth = gridWidth / CGFloat(columnCount)
            let cellHeight: CGFloat = gridHeight / CGFloat(rowCount)
            
            Grid(horizontalSpacing: 0, verticalSpacing: 0) {
                createHeaderRow(cellWidth: cellWidth)
                
                ForEach(hourList, id: \.self) { hour in
                    createGridRow(
                        for: hour,
                        cellWidth: cellWidth,
                        cellHeight: cellHeight
                    )
                }
            }
        }
    }
    
        
    
    @ViewBuilder
    private func createHeaderRow(cellWidth: CGFloat) -> some View {
        GridRow {
            ForEach(viewModel.weekList, id: \.self) { _ in
                Rectangle()
                    .fill(Color.clear)
                    .overlay(Rectangle().stroke(Color.heyGray6, lineWidth: 0.5))
                    .frame(width: cellWidth, height: 21)
            }
        }
    }
    
    @ViewBuilder
    private func createGridRow(for hour: Int, cellWidth: CGFloat, cellHeight: CGFloat) -> some View {
        @State var tappedPosition: CGPoint? = nil
        GridRow(alignment: .top) {
            ForEach(viewModel.weekList, id: \.self) { day in
                createGridCell(
                    for: hour,
                    day: day,
                    cellWidth: cellWidth,
                    cellHeight: cellHeight
                )
            }
        }
    }
    
    @ViewBuilder
    private func createGridCell(
        for hour: Int,
        day: Week,
        cellWidth: CGFloat,
        cellHeight: CGFloat
    ) -> some View {
        @State var tappedPosition: CGPoint? = nil
        
        VStack {
            if let cell = getSlot(timeTable: viewModel.timeTable, for: hour, day: day) {
                let height = getCellHeight(for: cell, hour: hour)
                ZStack {
                    Button {
                        withAnimation {
                            viewModel.send(.tableCellDidTap(cell.id))
                        }
                    } label: {
                        switch hour {
                        case cell.schedule.startHour:
                            if cell.schedule.startMinute != 0 {
                                VStack {
                                    Spacer()
                                    Rectangle().fill(cell.backgroundColor)
                                        .frame(height: height)
                                    
                                }
                            } else {
                                Rectangle().fill(cell.backgroundColor)
                                    .frame(width: cellWidth, height: 52)
                            }
                        case cell.schedule.endHour:
                            
                            if cell.schedule.endMinute != 0 {
                                Rectangle().fill(cell.backgroundColor)
                                    .position(CGPoint(x: cellWidth / 2, y: 0))
                                    .onTapGesture { location in
                                        tappedPosition = location
                                        print("Tapped at position: \(location)") // 여기에 좌표를 찍어볼 수 있습니다.
                                    }
                                
                            } else {
                                Rectangle().fill(cell.backgroundColor)
                            }
                            
                        default:
                            Rectangle().fill(cell.backgroundColor)
                                .frame(width: cellWidth, height: height)
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    .clipShape(RoundedRectangle(cornerRadius: 2))
                    .disabled(!(viewType == .main))
                    
                    //                    if hour == cell.schedule.startHour {
                    //                        createCellText(cell: cell)
                    //                    }
                }
            } else {
                createEmptyCell()
                    
            }
        }
//        .frame(height: cellHeight)
    }
    
    @ViewBuilder
    private func createCellText(cell: TimeTableCellInfo) -> some View {
        VStack(alignment: .leading) {
            if cell.schedule.startMinute != 0 {
                Spacer().frame(height: getCellHeight(for: cell, hour: cell.schedule.startHour))
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
            
            if displayType.creditIsVisible, let unit = cell.unit {
                Text("unit: \(unit)")
                    .font(.regular_10)
                    .foregroundColor(cell.textColor)
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
    
    private func getSlot(timeTable: [TimeTableCellInfo?], for hour: Int, day: Week) -> TimeTableCellInfo? {
        let slotCount = 17
        guard let weekIndex = viewModel.weekList.firstIndex(of: day) else { return nil }
        let slotIndex = hour - 8
        guard slotIndex >= 0 && slotIndex < slotCount else { return nil }
        let index = weekIndex * slotCount + slotIndex
        return timeTable[index]
    }
}

//#Preview {
//    @State var stub: TimeTableViewType = .main
//    @State var stub_display: DisplayTypeInfo = .MODULE_CODE_CLASSROOM
//    return TimeTableGridView(
//        viewModel: .init(StubHeyUseCase.stub.timeTableUseCase),
//        displayType: $stub_display,
//        viewType: $stub
//    )
//}

#Preview {
    @State var stub: TimeTableViewType = .main
    
    return MainView(
        viewModel: .init(StubHeyUseCase.stub.timeTableUseCase),
        viewType: $stub
    )
}


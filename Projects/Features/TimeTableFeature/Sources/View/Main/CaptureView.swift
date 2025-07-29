//
//  CaptureView.swift
//  TimeTableFeature
//
//  Created by 류희재 on 1/8/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import SwiftUI

import Domain

struct MainCaptureContentView: View {
    var weekList: [Week]
    var hourList: [Int]
    var timeTable: [TimeTableCellInfo]
    var displayType: DisplayTypeInfo
    
    init(
        weekList: [Week],
        hourList: [Int],
        timeTable: [TimeTableCellInfo],
        displayType: DisplayTypeInfo
    ) {
        self.weekList = weekList
        self.hourList = hourList
        self.timeTable = timeTable
        self.displayType = displayType
    }
    
    var body: some View {
        GeometryReader { geometry in
            
            let cellWidth: CGFloat = (geometry.size.width - 25) / CGFloat(5)
            
            ScrollView(.horizontal) {
                WeeklyListView(weekList, cellWidth: cellWidth)
                    .padding(.leading, 25)
                
                ScrollViewReader { proxy in
                    ScrollView {
                        HStack(alignment: .top, spacing: 0) {
                            HourListView(hourList)
                            
                            TimeTableGridCaptureView(
                                weekList: weekList,
                                timeTable: timeTable,
                                displayType: displayType,
                                hourList: hourList,
                                cellWidth: cellWidth
                            )
                        }
                    }
                }
            }
        }
    }
}


public struct TimeTableGridCaptureView: View {
    var weekList: [Week]
    var timeTable: [TimeTableCellInfo]
    var displayType: DisplayTypeInfo
    var hourList: [Int]
    var cellWidth: CGFloat
    
    init(
        weekList: [Week],
        timeTable: [TimeTableCellInfo],
        displayType: DisplayTypeInfo,
        hourList: [Int],
        cellWidth: CGFloat
    ) {
        self.weekList = weekList
        self.timeTable = timeTable
        self.displayType = displayType
        self.hourList = hourList
        self.cellWidth = cellWidth
    }
    
    public var body: some View {
        GeometryReader { geometry in
            VStack {
                let columnCount = weekList.count
                let rowCount = hourList.count
                let cellHeight: CGFloat = 52
                
                ZStack {
                    // 📌 빈 시간표 배치
                    Canvas { context, size in
                        drawGrid(
                            &context, size,
                            columnCount, rowCount,
                            cellWidth, cellHeight
                        )
                    }
                    
                    // 📌 수업 버튼 배치
                    ForEach(timeTable, id: \.self) { cell in
                        if let dayIndex = weekList.firstIndex(of: cell.schedule.day) {
                            let rect: (
                                centerX: CGFloat,
                                centerY: CGFloat,
                                height: CGFloat
                            ) = configButtonLayout(
                                hourList[0],
                                for: cell,
                                at: dayIndex,
                                cellWidth: cellWidth,
                                cellHeight: cellHeight
                            )
                            
                            ZStack {
                                createClassButton(
                                    for: cell,
                                    centerX: rect.centerX,
                                    centerY: rect.centerY,
                                    cellWidth: cellWidth,
                                    cellHeight: rect.height
                                )
                                
                                createClassInfoText(
                                    for: cell,
                                    displayType: displayType,
                                    centerX: rect.centerX,
                                    centerY: rect.centerY,
                                    cellWidth: cellWidth,
                                    cellHeight: rect.height
                                )
                            }
                            
                        }
                    }
                }
            }
        }
    }
}

extension TimeTableGridCaptureView {
    private func drawGrid(
        _ context: inout GraphicsContext,
        _ size: CGSize,
        _ columnCount: Int,
        _ rowCount: Int,
        _ cellWidth: CGFloat,
        _ cellHeight: CGFloat
    ) {
        let gridColor = Color.TimeTableMain.Timeline.default
        // 첫번째 선 그리기
        
        let height = CGFloat(rowCount) * cellHeight
        context.stroke(
            Path { path in
                path.move(to: CGPoint(x: 0, y: 0))
                path.addLine(to: CGPoint(x: size.width, y: 0)) // 가로선 길이를 반으로 설정
            },
            with: .color(gridColor),
            lineWidth: 1
        )
        
        // 1/2 선 그리기
        let firstRowY = cellHeight / 2
        context.stroke(
            Path { path in
                path.move(to: CGPoint(x: 0, y: firstRowY))
                path.addLine(to: CGPoint(x: size.width, y: firstRowY)) // 가로선 길이를 반으로 설정
            },
            with: .color(gridColor),
            lineWidth: 1
        )
        
        // 가로선 그리기
        for row in 1...rowCount {
            let y = firstRowY + CGFloat(row) * cellHeight
            context.stroke(
                Path { path in
                    path.move(to: CGPoint(x: 0, y: y))
                    path.addLine(to: CGPoint(x: size.width, y: y))
                },
                with: .color(gridColor),
                lineWidth: 1
            )
        }
        
        // 세로선 그리기
        for col in 0...columnCount {
            let x = CGFloat(col) * cellWidth
            context.stroke(
                Path { path in
                    path.move(to: CGPoint(x: x, y: 0))
                    path.addLine(to: CGPoint(x: x, y: height))
                },
                with: .color(gridColor),
                lineWidth: 1
            )
        }
    }
    
    private func createClassButton(
        for cell: TimeTableCellInfo,
        centerX: CGFloat,
        centerY: CGFloat,
        cellWidth: CGFloat,
        cellHeight: CGFloat
    ) -> some View {
        return Rectangle()
            .fill(cell.backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 2))
            .frame(width: cellWidth-1, height: cellHeight-1)
            .position(x: centerX, y: centerY)
    }
}


private func createClassInfoText(
    for cell: TimeTableCellInfo,
    displayType: DisplayTypeInfo,
    centerX: CGFloat,
    centerY: CGFloat,
    cellWidth: CGFloat,
    cellHeight: CGFloat
) -> some View {
    return VStack(alignment: .leading, spacing: 0) {
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
    .frame(width: 56, height: cellHeight, alignment: .topLeading)
    .position(x: centerX-4, y: centerY)
}

extension TimeTableGridCaptureView {
    private func configButtonLayout(
        _ firstTime: Int,
        for cell: TimeTableCellInfo,
        at dayIndex: Int,
        cellWidth: CGFloat,
        cellHeight: CGFloat
    ) -> (centerX: CGFloat, centerY: CGFloat, height: CGFloat) {
        let startHour = cell.schedule.startHour
        let startMinute = cell.schedule.startMinute
        let endHour = cell.schedule.endHour
        let endMinute = cell.schedule.endMinute
        
        
        let x = CGFloat(dayIndex) * cellWidth
        // 시작 시간과 분을 기준으로 시작 위치 계산
        let y = CGFloat(startHour - firstTime) * cellHeight + CGFloat(startMinute) / 60 * cellHeight
        
        // 종료 시간과 분을 기준으로 높이 계산
        let height = CGFloat(endHour - startHour) * cellHeight +
        CGFloat(endMinute - startMinute) / 60 * cellHeight
        
        let centerX = x + cellWidth / 2
        let centerY =  y + height / 2 + cellHeight / 2
        return (centerX, centerY, height)
    }
}

#Preview {
    return MainCaptureContentView(
        weekList: Week.dayOfWeek,
        hourList: Array(6...21),
        timeTable: SectionInfo.timetable_stubList.createTimeTableCellList(),
        displayType: .MODULE_CODE_CLASSROOM_CREDIT
    )
}

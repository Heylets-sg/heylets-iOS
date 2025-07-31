//
//  TimeTableSelectedView.swift
//  TimeTableFeature
//
//  Created by 류희재 on 7/29/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import SwiftUI
import Domain
import DSKit

public struct TimeTableSelectedView: View {
    @Binding var selectLecture: [TimeTableCellInfo]
    var weekList: [Week]
    var hourList: [Int]
    var cellWidth: CGFloat
    
    init(
        selectLecture: Binding<[TimeTableCellInfo]>,
        weekList: [Week],
        hourList: [Int],
        cellWidth: CGFloat
    ) {
        self._selectLecture = selectLecture
        self.weekList = weekList
        self.hourList = hourList
        self.cellWidth = cellWidth
    }
    
    public var body: some View {
        
        ForEach($selectLecture, id: \.self) { $cell in
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
                    cellHeight: 52
                )
                
                selectLectureView(
                    for: cell,
                    centerX: rect.centerX,
                    centerY: rect.centerY,
                    cellWidth: cellWidth,
                    cellHeight: rect.height
                )
            }
        }
    }
}
extension TimeTableSelectedView {
    private func selectLectureView (
        for cell: TimeTableCellInfo,
        centerX: CGFloat,
        centerY: CGFloat,
        cellWidth: CGFloat,
        cellHeight: CGFloat
    ) -> some View {
        return Rectangle()
            .fill(Color.Module.preview)
            .clipShape(RoundedRectangle(cornerRadius: 2))
            .frame(width: cellWidth, height: cellHeight)
            .position(x: centerX, y: centerY)
    }
}

extension TimeTableSelectedView {
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


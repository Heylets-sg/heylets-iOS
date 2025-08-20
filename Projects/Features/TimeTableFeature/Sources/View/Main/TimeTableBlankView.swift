//
//  TimeTableBlackView.swift
//  TimeTableFeature
//
//  Created by 류희재 on 7/29/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import SwiftUI
import Domain
import DSKit

public struct TimeTableBlankView: View {
    let rowCount: Int
    let columnCount: Int
    var cellWidth: CGFloat
    let cellHeight: CGFloat = 52
    
    @ObservedObject var timeTableState: TimeTableState
    
    
    init(
        rowCount: Int,
        columnCount: Int,
        cellWidth: CGFloat,
        timeTableState: TimeTableState
    ) {
        self.rowCount = rowCount
        self.columnCount = columnCount
        self.cellWidth = cellWidth
        self.timeTableState = timeTableState
    }
    
    public var body: some View {
        let gridColor = Color.timeTableMain.Timeline.background
        
        
        VStack(spacing: 0) {
            Rectangle()
                .fill(gridColor)
                .frame(height: 0.5)
                .id("top-line")
            
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    ForEach(0..<columnCount, id: \.self) { col in
                        Rectangle()
                            .fill(Color.clear)
                            .frame(width: cellWidth, height: cellHeight / 2)
                            .id("first-cell-\(col)-top")
                        
                        if col < columnCount - 1 {
                            Rectangle()
                                .fill(gridColor)
                                .frame(width: 0.5, height: cellHeight / 2)
                                .id("first-vertical-line-\(col)")
                        }
                    }
                }
                
                LazyVGrid(
                    columns: Array(repeating: GridItem(.fixed(cellWidth), spacing: 0), count: columnCount),
                    spacing: 0
                ) {
                    ForEach(0..<(rowCount * columnCount), id: \.self) { index in
                        let row = index / columnCount
                        let col = index % columnCount
                        
                        Rectangle()
                            .fill(Color.clear)
                            .frame(height: cellHeight)
                            .overlay(
                                Rectangle()
                                    .stroke(gridColor, lineWidth: 0.5)
                            )
                            .id("grid-cell-\(row)-\(col)")
                    }
                }
            }
        }
    }
}

extension TimeTableBlankView {
    // 시간으로부터 row 계산 (예: "09:00" -> 2)
    private func calculateRowFromTime(_ hour: Int) -> Int {
        // 시간 파싱 로직
        //            let components = timeString.split(separator: ":")
        //            guard let hour = Int(components[0]), let minute = Int(components[1]) else { return 0 }
        
        // 8시를 기준(0)으로 계산
        let baseHour = 8
        let rowIndex = (hour - baseHour) * 2
        
        return max(0, min(rowIndex, rowCount - 1))
    }
    //
    //        // 요일로부터 column 계산 (예: "MON" -> 0)
    //        private func calculateColumnFromDay(_ day: String) -> Int {
    //            let days = Week.
    //            return days.firstIndex(of: day.uppercased()) ?? 0
    //        }
}


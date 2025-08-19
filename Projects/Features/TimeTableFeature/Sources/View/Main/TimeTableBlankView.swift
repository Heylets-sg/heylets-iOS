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

//public struct TimeTableBlankView: View {
//    let rowCount: Int
//    let columnCount: Int
//    var cellWidth: CGFloat
//
//    init(
//        rowCount: Int,
//        columnCount: Int,
//        cellWidth: CGFloat
//    ) {
//        self.rowCount = rowCount
//        self.columnCount = columnCount
//        self.cellWidth = cellWidth
//    }
//
//    public var body: some View {
//        Canvas { context, size in
//            drawGrid(
//                &context, size,
//                columnCount, rowCount,
//                cellWidth, 52
//            )
//        }
//    }
//}
//
//extension TimeTableBlankView {
//    private func drawGrid(
//        _ context: inout GraphicsContext,
//        _ size: CGSize,
//        _ columnCount: Int,
//        _ rowCount: Int,
//        _ cellWidth: CGFloat,
//        _ cellHeight: CGFloat
//    ) {
//        let gridColor = Color.timeTableMain.Timeline.background
//        //          첫번째 선 그리기
//
//        let height = CGFloat(rowCount) * cellHeight
//        context.stroke(
//            Path { path in
//                path.move(to: CGPoint(x: 0, y: 0))
//                path.addLine(to: CGPoint(x: size.width, y: 0)) // 가로선 길이를 반으로 설정
//            },
//            with: .color(gridColor),
//            lineWidth: 1
//        )
//
//        //          1/2 선 그리기
//        let firstRowY = cellHeight / 2
//        context.stroke(
//            Path { path in
//                path.move(to: CGPoint(x: 0, y: firstRowY))
//                path.addLine(to: CGPoint(x: size.width, y: firstRowY)) // 가로선 길이를 반으로 설정
//            },
//            with: .color(gridColor),
//            lineWidth: 1
//        )
//
//        //          가로선 그리기
//        for row in 1...rowCount {
//            let y = firstRowY + CGFloat(row) * cellHeight
//            context.stroke(
//                Path { path in
//                    path.move(to: CGPoint(x: 0, y: y))
//                    path.addLine(to: CGPoint(x: size.width, y: y))
//                },
//                with: .color(gridColor),
//                lineWidth: 1
//            )
//        }
//
//        //          세로선 그리기
//        for col in 0...columnCount {
//            let x = CGFloat(col) * cellWidth
//            context.stroke(
//                Path { path in
//                    path.move(to: CGPoint(x: x, y: 0))
//                    path.addLine(to: CGPoint(x: x, y: height))
//                },
//                with: .color(gridColor),
//                lineWidth: 1
//            )
//        }
//    }
//}

public struct TimeTableBlankView: View {
    let rowCount: Int // 시간 슬롯 수 (11개 시간 * 2 = 22행)
    let columnCount: Int // 요일 수 (5개)
    var cellWidth: CGFloat
    let cellHeight: CGFloat = 52 // 30분 단위 높이
    
    init(
        rowCount: Int,
        columnCount: Int,
        cellWidth: CGFloat
    ) {
        self.rowCount = rowCount
        self.columnCount = columnCount
        self.cellWidth = cellWidth
    }
    
    public var body: some View {
        let gridColor = Color.timeTableMain.Timeline.background
        
        VStack(spacing: 0) {
            Rectangle()
                .fill(gridColor)
                .frame(height: 0.5)
                .id("top-line")
            
            // 1/2 선까지의 영역
            VStack(spacing: 0) {
                // 첫 번째 행의 상반부
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

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
        Canvas { context, size in
            drawGrid(
                &context, size,
                columnCount, rowCount,
                cellWidth, 52
            )
        }
    }
}

extension TimeTableBlankView {
    private func drawGrid(
        _ context: inout GraphicsContext,
        _ size: CGSize,
        _ columnCount: Int,
        _ rowCount: Int,
        _ cellWidth: CGFloat,
        _ cellHeight: CGFloat
    ) {
        let gridColor = Color.timeTableMain.Timeline.background
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
}

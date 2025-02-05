import SwiftUI
import Domain
import DSKit

public struct TimeTableGridView2: View {
    @ObservedObject var viewModel: TimeTableViewModel
    @Binding var displayType: DisplayTypeInfo
    @Binding var viewType: TimeTableViewType
    var hourList = Array(8...21)
    
    
    public var body: some View {
        GeometryReader { geometry in
            let columnCount = viewModel.weekList.count
            let rowCount = hourList.count
            let cellWidth = geometry.size.width / CGFloat(columnCount)
            let cellHeight: CGFloat = 52
            
            ZStack {
                // 그리드 및 수업 그리기
                Canvas { context, size in
                    drawGrid(context: &context, size: size, columnCount: columnCount, rowCount: rowCount, cellWidth: cellWidth, cellHeight: cellHeight)
                    
                    drawClasses(
                        context: &context,
                        size: size,
                        cellWidth: cellWidth,
                        cellHeight: cellHeight
                    )
                }
                .frame(width: geometry.size.width, height: CGFloat(rowCount) * cellHeight)
            }
        }
        
    }
    
    private func drawClasses(context: inout GraphicsContext, size: CGSize, cellWidth: CGFloat, cellHeight: CGFloat) {
        
        //        모든 시간대와 요일에 대해 수업을 그린다.
        for (dayIndex, day) in viewModel.weekList.enumerated() {
            for hour in hourList {
                if let cell = getSlot(timeTable: viewModel.timeTable, for: hour, day: day) {
                    // 시작 시간과 분을 기준으로 시작 위치 계산
                    let startY = CGFloat(cell.schedule.startHour - 8) * cellHeight + CGFloat(cell.schedule.startMinute) / 60 * cellHeight
                    
                    // 종료 시간과 분을 기준으로 높이 계산
                    let height = CGFloat(cell.schedule.endHour - cell.schedule.startHour) * cellHeight +
                    CGFloat(cell.schedule.endMinute - cell.schedule.startMinute) / 60 * cellHeight
                    
                    let x = CGFloat(dayIndex) * cellWidth
                    
                    // 수업 표시
                    context.fill(
                        Path { path in
                            path.addRect(CGRect(x: x, y: startY, width: cellWidth, height: height))
                        },
                        with: .color(cell.backgroundColor)
                    )
                }
            }
        }
    }
}


#Preview {
    @State var stub: TimeTableViewType = .main
    @State var stub_display: DisplayTypeInfo = .MODULE_CODE_CLASSROOM
    return MainView(
        viewModel: .init(StubHeyUseCase.stub.timeTableUseCase),
        //        displayType: $stub_display,
        viewType: $stub
    )
}


extension TimeTableGridView2 {
    private func drawGrid(context: inout GraphicsContext, size: CGSize, columnCount: Int, rowCount: Int, cellWidth: CGFloat, cellHeight: CGFloat) {
        let gridColor = Color.heyGray6
        
        // 가로선 그리기
        for row in 0...rowCount {
            let y = CGFloat(row) * cellHeight
            context.stroke(
                Path { path in
                    path.move(to: CGPoint(x: 0, y: y))
                    path.addLine(to: CGPoint(x: size.width, y: y))
                },
                with: .color(gridColor),
                lineWidth: 0.5
            )
        }
        
        // 세로선 그리기
        for col in 0...columnCount {
            let x = CGFloat(col) * cellWidth
            context.stroke(
                Path { path in
                    path.move(to: CGPoint(x: x, y: 0))
                    path.addLine(to: CGPoint(x: x, y: size.height))
                },
                with: .color(gridColor),
                lineWidth: 0.5
            )
        }
    }
    
    private func getSlot(timeTable: [TimeTableCellInfo?], for hour: Int, day: Week) -> TimeTableCellInfo? {
        let slotCount = 17
        guard let weekIndex = viewModel.weekList.firstIndex(of: day) else { return nil }
        let slotIndex = hour - 8
        guard slotIndex >= 0 && slotIndex < slotCount else { return nil }
        let index = weekIndex * slotCount + slotIndex
        return timeTable[index]
    }
    
    private func getCellHeight(for cell: TimeTableCellInfo, hour: Int) -> CGFloat {
        var baseHeight: CGFloat = 52 // 기본 셀 높이
        if let colorRatio = cell.slot[hour-8] {
            baseHeight *= CGFloat(colorRatio)
        }
        return baseHeight
    }
}

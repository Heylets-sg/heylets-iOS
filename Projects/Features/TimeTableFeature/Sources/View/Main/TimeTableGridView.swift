import SwiftUI
import Domain
import DSKit

public struct TimeTableGridView: View {
    @ObservedObject var viewModel: TimeTableViewModel
    @Binding var displayType: DisplayTypeInfo
    @Binding var viewType: TimeTableViewType
    var cellWidth: CGFloat
    
    init(
        viewModel: TimeTableViewModel,
        displayType: Binding<DisplayTypeInfo>,
        viewType: Binding<TimeTableViewType>,
        cellWidth: CGFloat
    ) {
        self.viewModel = viewModel
        self._displayType = displayType
        self._viewType = viewType
        self.cellWidth = cellWidth
    }
    
    public var body: some View {
        GeometryReader { geometry in
            VStack {
                let columnCount = viewModel.state.timeTable.columnCount
                let rowCount = viewModel.state.timeTable.rowCount
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
                    ForEach($viewModel.timeTable, id: \.self) { $cell in
                        if let dayIndex = viewModel.weekList.firstIndex(of: cell.schedule.day) {
                            let rect: (
                                centerX: CGFloat,
                                centerY: CGFloat,
                                height: CGFloat
                            ) = configButtonLayout(
                                viewModel.hourList[0],
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
                                    centerX: rect.centerX,
                                    centerY: rect.centerY,
                                    cellWidth: cellWidth,
                                    cellHeight: rect.height
                                )
                            }
                            
                        }
                    }
                    
                    ForEach($viewModel.selectLecture, id: \.self) { $cell in
                        if let dayIndex = viewModel.weekList.firstIndex(of: cell.schedule.day) {
                            let rect: (
                                centerX: CGFloat,
                                centerY: CGFloat,
                                height: CGFloat
                            ) = configButtonLayout(
                                viewModel.hourList[0],
                                for: cell,
                                at: dayIndex,
                                cellWidth: cellWidth,
                                cellHeight: cellHeight
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
        }
    }
}


fileprivate struct WeeklyListCellView: View {
    public let day: String
    public init(_ day: String) {
        self.day = day
    }
    var body: some View {
        HStack {
            Text(day)
                .font(.semibold_12)
                .foregroundColor(.heyGray1)
        }
    }
}

extension TimeTableGridView {
    private func drawGrid(
        _ context: inout GraphicsContext,
        _ size: CGSize,
        _ columnCount: Int,
        _ rowCount: Int,
        _ cellWidth: CGFloat,
        _ cellHeight: CGFloat
    ) {
        let gridColor = Color.heyGrid
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
        return Button {
            viewModel.send(.tableCellDidTap(cell.id))
        } label: {
            Rectangle()
                .fill(cell.backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: 2))
                .overlay(
                    RoundedRectangle(cornerRadius: 2)
                        .stroke(Color.heyGrid, lineWidth: 1)
                )
                .frame(width: cellWidth, height: cellHeight)
                .position(x: centerX, y: centerY)
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    
    private func createClassInfoText(
        for cell: TimeTableCellInfo,
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
    
    private func selectLectureView (
        for cell: TimeTableCellInfo,
        centerX: CGFloat,
        centerY: CGFloat,
        cellWidth: CGFloat,
        cellHeight: CGFloat
    ) -> some View {
        return Rectangle()
            .fill(Color.heyGray2.opacity(0.5))
            .clipShape(RoundedRectangle(cornerRadius: 2))
            .overlay(
                RoundedRectangle(cornerRadius: 2)
                    .stroke(Color.heyGrid, lineWidth: 1)
            )
            .frame(width: cellWidth, height: cellHeight)
            .position(x: centerX, y: centerY)
    }
}

extension TimeTableGridView {
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
    @State var stub: TimeTableViewType = .main
    return MainView(
        viewModel: .init(StubHeyUseCase.stub.timeTableUseCase),
        viewType: $stub
    )
}

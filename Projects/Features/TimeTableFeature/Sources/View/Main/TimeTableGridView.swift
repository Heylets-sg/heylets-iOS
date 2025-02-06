import SwiftUI
import Domain
import DSKit

public struct TimeTableGridView: View {
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
                // 📌 빈 시간표 배치
                Canvas { context, size in
                    drawGrid(
                        &context,
                        size,
                        columnCount,
                        rowCount,
                        cellWidth,
                        cellHeight
                    )
                }
                
                // 📌 수업 버튼 배치
                ForEach(viewModel.weekList, id: \.self) {  day in
                    ForEach(hourList, id: \.self) { hour in
                        if let cell = getSlot(timeTable: viewModel.timeTable, for: hour, day: day) {
                            // 수업 버튼 뷰 생성
                            let dayIndex = viewModel.weekList.firstIndex(of: day)!
                            createClassButton(for: cell, at: dayIndex, cellWidth: cellWidth, cellHeight: cellHeight)
                        }
                    }
                }
                
                // 📌 글자 배치
                ForEach(viewModel.weekList, id: \.self) {  day in
                    ForEach(hourList, id: \.self) { hour in
                        if let cell = getSlot(timeTable: viewModel.timeTable, for: hour, day: day) {
                            // 수업 버튼 뷰 생성
                            let dayIndex = viewModel.weekList.firstIndex(of: day)!
                            createClassInfoText(for: cell, at: dayIndex, cellWidth: cellWidth, cellHeight: cellHeight)
                        }
                    }
                }
                
            }
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
        let gridColor = Color.heyGray6
        // 첫번째 선 그리기
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
            lineWidth: 0.5
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
                lineWidth: col == 0 || col == columnCount ? 1 : 0.5
            )
        }
    }
    
    private func createClassButton(
        for cell: TimeTableCellInfo,
        at dayIndex: Int,
        cellWidth: CGFloat,
        cellHeight: CGFloat
    ) -> some View {
        let startHour = cell.schedule.startHour
        let startMinute = cell.schedule.startMinute
        let endHour = cell.schedule.endHour
        let endMinute = cell.schedule.endMinute
        
        let rect: (centerX: CGFloat, centerY: CGFloat, height: CGFloat) = configButtonLayout(
            (h: startHour, m: startMinute),
            (h: endHour, m: endMinute),
            at: dayIndex,
            cellWidth: cellWidth,
            cellHeight: cellHeight
        )
        
        return Button {
            print("클릭된 수업: \(cell.code), \(startHour):\(startMinute) ~ \(endHour):\(endMinute)")
        } label: {
            Rectangle()
                .fill(cell.backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: 2))
                .overlay(
                    RoundedRectangle(cornerRadius: 2)
                        .stroke(Color.heyGray6, lineWidth: 1)
                )
                .frame(width: cellWidth, height: rect.height)
                .position(x: rect.centerX, y: rect.centerY)
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    
    private func createClassInfoText(
        for cell: TimeTableCellInfo,
        at dayIndex: Int,
        cellWidth: CGFloat,
        cellHeight: CGFloat
    ) -> some View {
        let startHour = cell.schedule.startHour
        let startMinute = cell.schedule.startMinute
        let endHour = cell.schedule.endHour
        let endMinute = cell.schedule.endMinute
        
        let rect: (centerX: CGFloat, centerY: CGFloat, height: CGFloat) = configButtonLayout(
            (h: startHour, m: startMinute),
            (h: endHour, m: endMinute),
            at: dayIndex,
            cellWidth: cellWidth,
            cellHeight: cellHeight
        )
        
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
        .frame(width: 56, height: rect.height, alignment: .topLeading)
        .position(x: rect.centerX-4, y: rect.centerY)
    }
}

extension TimeTableGridView {
    private func getSlot(timeTable: [TimeTableCellInfo?], for hour: Int, day: Week) -> TimeTableCellInfo? {
        let slotCount = 17
        guard let weekIndex = viewModel.weekList.firstIndex(of: day) else { return nil }
        let slotIndex = hour - 8
        guard slotIndex >= 0 && slotIndex < slotCount else { return nil }
        let index = weekIndex * slotCount + slotIndex
        return timeTable[index]
    }
    
    private func configButtonLayout(
        _ startTime: (h: Int, m: Int),
        _ endTime: (h: Int, m: Int),
        at dayIndex: Int,
        cellWidth: CGFloat,
        cellHeight: CGFloat
    ) -> (centerX: CGFloat, centerY: CGFloat, height: CGFloat) {
        
        let x = CGFloat(dayIndex) * cellWidth
        // 시작 시간과 분을 기준으로 시작 위치 계산
        let y = CGFloat(startTime.h - 8) * cellHeight + CGFloat(startTime.m) / 60 * cellHeight
        
        // 종료 시간과 분을 기준으로 높이 계산
        let height = CGFloat(endTime.h - startTime.h) * cellHeight +
        CGFloat(endTime.m - startTime.m) / 60 * cellHeight
        
        let centerX = x + cellWidth / 2
        let centerY =  y + height / 2 + cellHeight / 2
        return (centerX, centerY, height)
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

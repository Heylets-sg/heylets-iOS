import SwiftUI
import Domain
import DSKit

public struct TimeTableExsitedView: View {
    @ObservedObject var viewModel: TimeTableViewModel
    @Binding var displayType: DisplayTypeInfo
    var canTouch: Bool
    var cellWidth: CGFloat
    
    init(
        viewModel: TimeTableViewModel,
        displayType: Binding<DisplayTypeInfo>,
        cellWidth: CGFloat,
        canTouch: Bool
    ) {
        self.viewModel = viewModel
        self._displayType = displayType
        self.cellWidth = cellWidth
        self.canTouch = canTouch
    }
    
    public var body: some View {
        // 📌 수업 버튼 배치
        ForEach($viewModel.timeTable, id: \.self) { $cell in
            if let dayIndex = viewModel.weekList.firstIndex(of: cell.schedule.day) {
                let rect: (centerX: CGFloat, centerY: CGFloat, height: CGFloat) = configButtonLayout(
                    viewModel.hourList[0],
                    for: cell,
                    at: dayIndex,
                    cellWidth: cellWidth,
                    cellHeight: 52
                )
                
                let backgroundColor: Color = $viewModel.coreState.selectedThemeColor.isEmpty
                ? cell.backgroundColor
                : Color.init(hex: viewModel.coreState.selectedThemeColor.randomElement()!)
                
                ZStack {
                    createClassButton(
                        for: cell,
                        centerX: rect.centerX,
                        centerY: rect.centerY,
                        cellWidth: cellWidth,
                        cellHeight: rect.height,
                        backgroundColor: backgroundColor
                    )
                    
                    let textColor: Color = $viewModel.coreState.selectedThemeColor.isEmpty
                    ? cell.textColor
                    : Color.init(hex: viewModel.coreState.selectedThemeColor[0])
                    
                    createClassInfoText(
                        for: cell,
                        textColor: textColor,
                        centerX: rect.centerX,
                        centerY: rect.centerY,
                        cellWidth: cellWidth,
                        cellHeight: rect.height
                    )
                }
                .onTapGesture {
                    viewModel.send(.tableCellDidTap(cell.id))
                }
                //MARK: viewModel 리펙토링으로 인한 로직 처리 필요
                //.disabled(canTouch)
            }
        }
    }
}
extension TimeTableExsitedView {
    private func createClassButton(
        for cell: TimeTableCellInfo,
        centerX: CGFloat,
        centerY: CGFloat,
        cellWidth: CGFloat,
        cellHeight: CGFloat,
        backgroundColor: Color
    ) -> some View {
        return Button {
            withAnimation {
                viewModel.send(.tableCellDidTap(cell.id))
            }
        } label: {
            Rectangle()
                .fill(backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: 2))
                .frame(width: cellWidth-1, height: cellHeight-1)
                .position(x: centerX, y: centerY)
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    
    private func createClassInfoText(
        for cell: TimeTableCellInfo,
        textColor: Color,
        centerX: CGFloat,
        centerY: CGFloat,
        cellWidth: CGFloat,
        cellHeight: CGFloat
    ) -> some View {
        return VStack(alignment: .leading, spacing: 0) {
            Text(cell.code)
                .font(.medium_12)
                .foregroundColor(textColor)
                .multilineTextAlignment(.leading)
                .lineLimit(1)
            
            if displayType.classRoomIsVisible {
                Text(cell.schedule.location)
                    .font(.regular_10)
                    .foregroundColor(textColor)
                    .lineLimit(1)
            }
            
            if displayType.creditIsVisible, let unit = cell.unit {
                Text("unit: \(unit)")
                    .font(.regular_10)
                    .foregroundColor(textColor)
                    .lineLimit(1)
            }
        }
        .frame(width: 56, height: cellHeight ,alignment: .topLeading)
        .position(x: centerX-4, y: centerY)
    }
}

extension TimeTableExsitedView {
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


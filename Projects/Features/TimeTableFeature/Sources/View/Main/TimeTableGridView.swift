//import SwiftUI
//
//import Domain
//import DSKit
//
//public struct TimeTableGridView: View {
//    @ObservedObject var viewModel: TimeTableViewModel
//    @Binding var displayType: DisplayTypeInfo
//    @Binding var viewType: TimeTableViewType
//    var hourList = Array(8...21)
//    
//    @ViewBuilder
//        private func createHeaderRow() -> some View {
//            GridRow {
//                ForEach(viewModel.weekList, id: \.self) { _ in
//                    Rectangle()
//                        .fill(Color.clear)
//                        .overlay(Rectangle().stroke(Color.heyGray6, lineWidth: 0.5))
//                        .frame(height: 21)
//                }
//            }
//        }
//    
//    public var body: some View {
//        GeometryReader { geometry in
//            let columnCount = viewModel.weekList.count
//            let rowCount = hourList.count
//            let cellWidth = geometry.size.width / CGFloat(columnCount)
//            let cellHeight: CGFloat = 52
//            
//            createHeaderRow()
//            
//            Canvas { context, size in
//                
//                drawGrid(
//                    context: &context,
//                    size: size,
//                    columnCount: columnCount,
//                    rowCount: rowCount,
//                    cellWidth: cellWidth,
//                    cellHeight: cellHeight
//                )
//                
//                drawCells(
//                    context: &context,
//                    cellWidth: cellWidth,
//                    cellHeight: cellHeight
//                )
//            }
//            .frame(
//                width: geometry.size.width,
//                height: CGFloat(rowCount) * cellHeight
//            )
//        }
//    }
//    
//    private func drawGrid(
//        context: inout GraphicsContext,
//        size: CGSize,
//        columnCount: Int,
//        rowCount: Int,
//        cellWidth: CGFloat,
//        cellHeight: CGFloat
//    ) {
//        let gridColor = Color.heyGray6
//        
//        // 가로선 그리기
//        for row in 0...rowCount {
//            let y = CGFloat(row) * cellHeight
//            context.stroke(
//                Path { path in
//                    path.move(to: CGPoint(x: 0, y: y))
//                    path.addLine(to: CGPoint(x: size.width, y: y))
//                },
//                with: .color(gridColor),
//                lineWidth: 0.5
//            )
//        }
//        
//        // 세로선 그리기
//        for col in 0...columnCount {
//            let x = CGFloat(col) * cellWidth
//            context.stroke(
//                Path { path in
//                    path.move(to: CGPoint(x: x, y: 0))
//                    path.addLine(to: CGPoint(x: x, y: size.height))
//                },
//                with: .color(gridColor),
//                lineWidth: 0.5
//            )
//        }
//    }
//    
//    private func drawCells(
//        context: inout GraphicsContext,
//        cellWidth: CGFloat,
//        cellHeight: CGFloat
//    ) {
//        for hour in hourList {
//            for day in viewModel.weekList {
//                if let cell = getSlot(
//                    timeTable: viewModel.timeTable,
//                    for: hour,
//                    day: day
//                ) {
//                    let x = CGFloat(day.index) * cellWidth
//                    let y = CGFloat(hour - 8) * cellHeight
//                    
//                    if hour == cell.schedule.startHour && cell.schedule.startMinute != 0 {
//                        let startHeight = getCellHeight(for: cell, hour: hour)
//                        
//                        context.fill(
//                            Path(CGRect(x: x, y: y+startHeight, width: cellWidth, height: startHeight)),
//                            with: .color(cell.backgrounColor)
//                        )
//                    } else {
//                        let endHeight = getCellHeight(for: cell, hour: hour)
//                        context.fill(
//                            Path(CGRect(x: x, y: y, width: cellWidth, height: endHeight)),
//                            with: .color(cell.backgrounColor)
//                        )
//                    }
//                }
//            }
//        }
//    }
//    
//    private func getSlot(timeTable: [[TimeTableCellInfo?]], for hour: Int, day: Week) -> TimeTableCellInfo? {
//        guard day.index < timeTable.count,
//              hour - 8 < timeTable[day.index].count else { return nil }
//        return timeTable[day.index][hour - 8]
//    }
//    
//    private func getCellHeight(for cell: TimeTableCellInfo, hour: Int) -> CGFloat {
//        var baseHeight: CGFloat = 52 // 기본 셀 높이
//        if let colorRatio = cell.slot[hour-8] {
//            baseHeight *= CGFloat(colorRatio)
//        } else {
//            print(hour)
//        }
//        return baseHeight
//    }
//}
//
//
//#Preview {
//    @State var stub_viewType: TimeTableViewType = .main
//    @State var stub_displayType: DisplayTypeInfo = .MODULE_CODE_CLASSROOM_CREDIT
//    return TimeTableGridView(
//        viewModel: .init(StubHeyUseCase.stub.timeTableUseCase),
//        displayType: $stub_displayType,
//        viewType: $stub_viewType
//    )
//}
//
//


///////
///
///
///
///
///
/////TimeTableGridView.swift
//TimeTableFeature
//
//Created by 류희재 on 12/27/24.
//Copyright © 2024 Heylets-iOS. All rights reserved.
//
//import Foundation
//
//import SwiftUI
//
//import Domain
//import DSKit
//
//public struct TimeTableGridView: View {
//    @ObservedObject var viewModel: TimeTableViewModel
//    @Binding var displayType: DisplayTypeInfo
//    @Binding var viewType: TimeTableViewType
//    var hourList = Array(8...21)
//    
//    public var body: some View {
//        GeometryReader { geometry in
//            let columnCount = viewModel.weekList.count
//            let rowCount = hourList.count
//            let cellWidth = geometry.size.width / CGFloat(columnCount)
//            let cellHeight: CGFloat = 52
//            
//            createHeaderRow()
//            
//            Canvas { context, size in
//                
//                drawGrid(
//                    context: &context,
//                    size: size,
//                    columnCount: columnCount,
//                    rowCount: rowCount,
//                    cellWidth: cellWidth,
//                    cellHeight: cellHeight
//                )}
//            
//            @ViewBuilder
//            for hour in hourList {
//                for day in viewModel.weekList {
//                    if let cell = getSlot(
//                        timeTable: viewModel.timeTable,
//                        for: hour,
//                        day: day
//                    ) {
//                        
//                        Button {
//                            print("\(cell.schedule.startHour) \(cell.schedule.startMinute) click")
//                            withAnimation {
//                                viewModel.send(.tableCellDidTap(cell.id))
//                            }
//                        } label: {
//                            let x = CGFloat(day.index) * cellWidth
//                            let y = CGFloat(hour - 8) * cellHeight
//                            
//                            if hour == cell.schedule.startHour && cell.schedule.startMinute != 0 {
//                                let startHeight = getCellHeight(for: cell, hour: hour)
//                                
//                                Rectangle.fill(
//                                    Path(CGRect(x: x, y: y+startHeight, width: cellWidth, height: startHeight)),
//                                    with: .color(cell.backgrounColor)
//                                )
//                            } else {
//                                let endHeight = getCellHeight(for: cell, hour: hour)
//                                Rectangle.fill(
//                                    Path(CGRect(x: x, y: y, width: cellWidth, height: endHeight)),
//                                    with: .color(cell.backgrounColor)
//                                )
//                            }
//                        }
//                    }
//                    
//                }
//            }
//            
//        }
//    }
//    private func drawGrid(
//        context: inout GraphicsContext,
//        size: CGSize,
//        columnCount: Int,
//        rowCount: Int,
//        cellWidth: CGFloat,
//        cellHeight: CGFloat
//    ) {
//        let gridColor = Color.heyGray6
//        
//        // 가로선 그리기
//        for row in 0...rowCount {
//            let y = CGFloat(row) * cellHeight
//            context.stroke(
//                Path { path in
//                    path.move(to: CGPoint(x: 0, y: y))
//                    path.addLine(to: CGPoint(x: size.width, y: y))
//                },
//                with: .color(gridColor),
//                lineWidth: 0.5
//            )
//        }
//        
//        // 세로선 그리기
//        for col in 0...columnCount {
//            let x = CGFloat(col) * cellWidth
//            context.stroke(
//                Path { path in
//                    path.move(to: CGPoint(x: x, y: 0))
//                    path.addLine(to: CGPoint(x: x, y: size.height))
//                },
//                with: .color(gridColor),
//                lineWidth: 0.5
//            )
//        }
//    }
//    
//    @ViewBuilder
//    private func createHeaderRow() -> some View {
//        GridRow {
//            ForEach(viewModel.weekList, id: \.self) { _ in
//                Rectangle()
//                    .fill(Color.clear)
//                    .overlay(Rectangle().stroke(Color.heyGray6, lineWidth: 0.5))
//                    .frame(height: 21)
//            }
//        }
//    }
//    
//    //    public var body: some View {
//    //        Grid(horizontalSpacing: 0, verticalSpacing: 0) {
//    //            createHeaderRow()
//    //
//    //            ForEach(hourList, id: \.self) { hour in
//    //                createGridRow(for: hour)
//    //            }
//    //        }
//    //    }
//    
//    
//    
////    @ViewBuilder
////    private func createGridRow(for hour: Int) -> some View {
////        GridRow(alignment: .top) {
////            ForEach(viewModel.weekList, id: \.self) { day in
////                createGridCell(for: hour, day: day)
////            }
////        }
////    }
//    
//    @ViewBuilder
//    private func createGridCell(for hour: Int, day: Week) -> some View {
//        GeometryReader { geometry in
//            let columnCount = viewModel.weekList.count
//            let rowCount = hourList.count
//            let cellWidth = geometry.size.width / CGFloat(columnCount)
//            let cellHeight: CGFloat = 52
//            
//            if let cell = getSlot(timeTable: viewModel.timeTable, for: hour, day: day) {
//                Button {
//                    print("\(cell.schedule.startHour) \(cell.schedule.startMinute) click")
//                    withAnimation {
//                        viewModel.send(.tableCellDidTap(cell.id))
//                    }
//                } label: {
//                    let x = CGFloat(day.index) * cellWidth
//                    let y = CGFloat(hour - 8) * 52
//                    
//                    if hour == cell.schedule.startHour && cell.schedule.startMinute != 0 {
//                        let startHeight = getCellHeight(for: cell, hour: hour)
//                        
//                        Rectangle()
//                            .fill(cell.backgroundColor) // 셀의 배경색 적용
//                            .frame(width: cellWidth, height: startHeight)
//                            .position(x: 0, y: startHeight) // 위치 조정
//                    } else {
//                        let endHeight = getCellHeight(for: cell, hour: hour)
//                        Rectangle()
//                            .fill(cell.backgroundColor) // 셀의 배경색 적용
//                            .frame(width: cellWidth, height: endHeight)
//                            .position(x: x + cellWidth / 2, y: y)
//                    }
//                    //                    ZStack {
//                    //                        createCellBackground(cell: cell, hour: hour)
//                    //
//                    //                        VStack {
//                    //                            if hour == cell.schedule.startHour {
//                    //                                createCellText(cell: cell)
//                    //                            }
//                    //                        }
//                    //                    }
//                }
//                .buttonStyle(PlainButtonStyle())
//                .disabled(!(viewType == .main))
//            } else {
//                createEmptyCell()
//            }
//        }
//        .frame(height: 52)
//    }
//    
//    @ViewBuilder
//    private func createCellBackground(cell: TimeTableCellInfo, hour: Int) -> some View {
//        VStack {
//            if hour == cell.schedule.startHour && cell.schedule.startMinute != 0 {
//                Spacer()
//                    .frame(height: getCellHeight(for: cell, hour: hour))
//                    .allowsHitTesting(false)
//            }
//            
//            // 적용할 stroke 방향을 동적으로 결정
//            let edges: [Edge] = {
//                if hour == cell.schedule.startHour {
//                    return [.top, .leading, .trailing]
//                } else if hour == cell.schedule.endHour {
//                    return [.bottom, .leading, .trailing]
//                } else {
//                    return [.leading, .trailing]
//                }
//            }()
//            
//            cell.backgroundColor
//                .frame(height: getCellHeight(for: cell, hour: hour))
//                .clipShape(RoundedRectangle(cornerRadius: 2))
//                .overlay(CustomBorderShape(edges: edges)
//                    .stroke(Color.heyGray6, lineWidth: 1))
//            //                .overlay(
//            //                    Rectangle()
//            //                        .strokeBorder(Color.heyGray6, lineWidth: 0.5, edges: edges)
//            //                )
//            
//            if hour == cell.schedule.endHour && cell.schedule.endMinute != 0 {
//                Spacer()
//                    .frame(height: getCellHeight(for: cell, hour: hour))
//                    .allowsHitTesting(false)
//            }
//        }
//    }
//    
//    @ViewBuilder
//    private func createCellText(cell: TimeTableCellInfo) -> some View {
//        VStack(alignment: .leading) {
//            HStack {
//                VStack(alignment: .leading) {
//                    Text(cell.code)
//                        .font(.medium_12)
//                        .foregroundColor(cell.textColor)
//                    
//                    if displayType.classRoomIsVisible {
//                        Text(cell.schedule.location)
//                            .font(.regular_10)
//                            .foregroundColor(cell.textColor)
//                    }
//                    
//                    //            if displayType.creditIsVisible, let unit = cell.unit {
//                    //                Text("unit: \(unit)")
//                    //                    .font(.regular_10)
//                    //                    .foregroundColor(cell.textColor)
//                    //            }
//                    
//                    Spacer()
//                }
//                .padding(.leading, 4)
//                
//                Spacer()
//            }
//            
//            
//        }
//    }
//    
//    @ViewBuilder
//    private func createEmptyCell() -> some View {
//        Rectangle()
//            .fill(Color.clear)
//            .overlay(Rectangle().stroke(Color.heyGray6, lineWidth: 0.5))
//    }
//    
//    
//    private func getCellHeight(for cell: TimeTableCellInfo, hour: Int) -> CGFloat {
//        var baseHeight: CGFloat = 52 // 기본 셀 높이
//        if let colorRatio = cell.slot[hour-8] {
//            baseHeight *= CGFloat(colorRatio)
//        } else {
//            print(hour)
//        }
//        return baseHeight
//    }
//    
//    private func getSlot(timeTable: [[TimeTableCellInfo?]], for hour: Int, day: Week) -> TimeTableCellInfo? {
//        guard day.index < timeTable.count,
//              hour - 8 < timeTable[day.index].count else { return nil }
//        return timeTable[day.index][hour - 8]
//    }
//    
//}
//
//#Preview {
//    @State var stub: TimeTableViewType = .main
//    return MainView(
//        viewModel: .init(StubHeyUseCase.stub.timeTableUseCase),
//        viewType: $stub
//    )
//}
//

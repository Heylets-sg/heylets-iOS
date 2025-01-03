//
//  TimeTableGridView.swift
//  TimeTableFeature
//
//  Created by 류희재 on 12/27/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

public struct TimeTableGridView: View {
    @Binding var viewType: TimeTableViewType
    @ObservedObject var viewModel: TimeTableGridViewModel
    var hourList = Array(9...24)
    
    public var body: some View {
        Grid(horizontalSpacing: 1, verticalSpacing: 1) {
            createHeaderRow()
            
            ForEach(hourList, id: \.self) { hour in
                createGridRow(for: hour)
            }
        }
        .onAppear {
            viewModel.send(.onAppear)
        }
    }
    
    @ViewBuilder
    private func createHeaderRow() -> some View {
        GridRow {
            ForEach(viewModel.weekList, id: \.self) { _ in
                Rectangle()
                    .fill(Color.clear)
                    .overlay(Rectangle().stroke(Color.heyGray6, lineWidth: 0.5))
                    .frame(width: 73, height: 21)
            }
        }
    }
    
    @ViewBuilder
    private func createGridRow(for hour: Int) -> some View {
        GridRow(alignment: .top) {
            ForEach(viewModel.weekList, id: \.self) { day in
                createGridCell(for: hour, day: day)
            }
        }
    }
    
    @ViewBuilder
    private func createGridCell(for hour: Int, day: Week) -> some View {
        ZStack {
            Rectangle()
                .fill(Color.clear)
                .overlay(Rectangle().stroke(Color.heyGray6, lineWidth: 0.5))
            
            if let slot = getSlot(for: hour, day: day) {
                Button {
                    withAnimation {
                        viewType = .detail
                    }
                } label: {
                    ZStack {
                        Color.heySubMain.opacity(0.5)
                        if hour == slot.schedule.startHour {
                            VStack(alignment: .leading) {
                                Text(slot.name)
                                    .font(.medium_12)
                                    .multilineTextAlignment(.center)
                                Text(slot.schedule.location)
                                    .font(.regular_10)
                                    .foregroundColor(.gray)
                                Spacer()
                            }
                        }
                    }
                }
                .disabled(!(viewType == .main))
                .background(Color.blue.opacity(0.2))
            }
        }
        .frame(width: 73, height: 52)
    }
    
    private func getSlot(for hour: Int, day: Week) -> TimeTableCellInfo? {
        guard day.index < viewModel.state.timeTable.count,
              hour - 9 < viewModel.state.timeTable[day.index].count else { return nil }
        return viewModel.state.timeTable[day.index][hour - 9]
    }
}

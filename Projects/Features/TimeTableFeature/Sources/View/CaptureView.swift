//
//  CaptureView.swift
//  TimeTableFeature
//
//  Created by 류희재 on 1/8/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import SwiftUI

import Domain

struct MainCaptureContentView: View {
    var weekList: [Week]
    var hourList: [Int]
    var timeTable: [TimeTableCellInfo?]
    var displayType: DisplayTypeInfo
    
    init(
        weekList: [Week],
        hourList: [Int],
        timeTable: [TimeTableCellInfo?],
        displayType: DisplayTypeInfo
    ) {
        self.weekList = weekList
        self.hourList = hourList
        self.timeTable = timeTable
        self.displayType = displayType
    }
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                WeeklyListView(weekList)
                    .padding(.bottom, 16)
                    .padding(.leading, 30)
            }
            
            ScrollView() {
                HStack(alignment: .top) {
                    HourListView(hourList)
                        .padding(.top, 10)
                    
                    TimeTableGridCaptureView(
                        weekList: weekList,
                        timeTable: timeTable,
                        displayType: displayType
                    )
                }
            }
            .scrollIndicators(.hidden)
            .border(Color.heyGray6, width: 1)
        }
        .scrollIndicators(.hidden)
    }
}


import SwiftUI



public struct TimeTableGridCaptureView: View {
    var weekList: [Week]
    var timeTable: [TimeTableCellInfo?]
    var displayType: DisplayTypeInfo
    var hourList = Array(8...24)
    
    public var body: some View {
        Grid(horizontalSpacing: 1, verticalSpacing: 1) {
            createHeaderRow()
            
            ForEach(hourList, id: \.self) { hour in
                createGridRow(for: hour, displayType: displayType)
            }
        }
    }
    
    @ViewBuilder
    private func createHeaderRow() -> some View {
        GridRow {
            ForEach(weekList, id: \.self) { _ in
                Rectangle()
                    .fill(Color.clear)
                    .overlay(Rectangle().stroke(Color.heyGray6, lineWidth: 0.5))
                    .frame(width: 73, height: 21)
            }
        }
    }
    
    @ViewBuilder
    private func createGridRow(for hour: Int, displayType: DisplayTypeInfo) -> some View {
        GridRow(alignment: .top) {
            ForEach(weekList, id: \.self) { day in
                createGridCell(for: hour, day: day, displayType: displayType)
            }
        }
    }
    
    @ViewBuilder
    private func createGridCell(
        for hour: Int,
        day: Week,
        displayType: DisplayTypeInfo
    ) -> some View {
        VStack {
            if let cell = getSlot(
                timeTable: timeTable,
                for: hour,
                day: day
            ) {
                Button {
                } label: {
                    ZStack {
                        VStack {
                            if hour == cell.schedule.startHour {
                                if cell.schedule.startMinute != 0 {
                                    Spacer()
                                }
                                cell.backgroundColor
                                    .frame(height: 52)
                                    .clipped()
                            } else if hour == cell.schedule.endHour {
                                // 종료 시간일 때 위로 배치
                                cell.backgroundColor
                                    .frame(height: 52)
                                    .clipped()
                                if cell.schedule.endMinute != 0 {
                                    Spacer()
                                }
                            } else {
                                cell.backgroundColor
                                    .frame(height: 52)
                                    .clipped()
                            }
                        }
                        
                        // 시간 시작에만 텍스트 보여주기
                        if hour == cell.schedule.startHour {
                            VStack(alignment: .leading) {
                                if cell.schedule.startMinute != 0 {
                                    Spacer()
                                        .frame(height: 52)
                                }
                                Text(cell.code)
                                    .font(.medium_12)
                                    .foregroundColor(cell.textColor)
                                    .multilineTextAlignment(.center)
                                
                                if displayType.classRoomIsVisible {
                                    Text(cell.schedule.location)
                                        .font(.regular_10)
                                        .foregroundColor(cell.textColor)
                                }
                                
                                if displayType.creditIsVisible && cell.unit != nil{
                                    Text("unit: \(cell.unit!)")
                                        .font(.regular_10)
                                        .foregroundColor(cell.textColor)
                                }
                            }
                        }
                    }
                }
                .buttonStyle(PlainButtonStyle())
                .clipShape(RoundedRectangle(cornerRadius: 2))
            } else {
                Rectangle()
                    .fill(Color.clear)
                    .overlay(Rectangle().stroke(Color.heyGray6, lineWidth: 0.5))
            }
        }
        .frame(width: 70, height: 52)
    }

    
    private func getSlot(timeTable: [TimeTableCellInfo?], for hour: Int, day: Week) -> TimeTableCellInfo? {
        let slotCount = 17
        guard let weekIndex = weekList.firstIndex(of: day) else { return nil }
        let slotIndex = hour - 8 // 예를 들어, 8시가 0번 인덱스라고 가정
        guard slotIndex >= 0 && slotIndex < slotCount else { return nil }
        let index = weekIndex * slotCount + slotIndex
        return timeTable[index]
    }
    
}

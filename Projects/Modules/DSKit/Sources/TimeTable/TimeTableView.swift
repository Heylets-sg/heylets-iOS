//
//  TimeTableView.swift
//  DSKit
//
//  Created by 류희재 on 12/26/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

struct TimeTableView: View {
    var body: some View {
        VStack(alignment: .leading) {
            TopView()
            
            Spacer()
                .frame(height: 19)
            
            MainView()
        }
    }
}

fileprivate struct TopView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("NUS")
                        .font(.bold_8)
                        .foregroundColor(.heyGray6)
                        .padding(.horizontal, 5)
                        .padding(.vertical, 2)
                        .background(Color.heyDarkBlue)
                    
                    Text("AY2025/2026 sem1")
                        .font(.medium_12)
                        .foregroundColor(.heyGray2) //색상 확인
                }
                .padding(.bottom, 11)
                
                Text("A+++")
                    .font(.semibold_18)
                    .foregroundColor(.heyGray2) //색상 확인
            }
            
            Spacer()
            
            HStack {
                Image(uiImage: .icAdd.withRenderingMode(.alwaysTemplate))
                    .resizable()
                    .frame(width: 16, height: 16)
                    .tint(.heyGray6)
                    .padding(.trailing, 26)
                
                Image(uiImage: .icSetting.withRenderingMode(.alwaysTemplate))
                    .resizable()
                    .frame(width: 20, height: 20)
                    .tint(.heyGray6)
                    .padding(.trailing, 23)
                
                Circle()
                    .frame(width: 31, height: 31)
            }
        }
        .padding(.horizontal, 16)
    }
}

fileprivate struct MainView: View {
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                WeeklyListView()
                    .padding(.bottom, 16)
                    .padding(.leading, 30)
            }
            
            ScrollView() {
                HStack(alignment: .top) {
                    HourListView()
                        .padding(.top, 10)
                    
                    TimeTableGridView()
                }
            }
            .scrollIndicators(.hidden)
            .border(Color.heyGray6, width: 1)
        }
        .scrollIndicators(.hidden)
    }
}


fileprivate struct TimeTableGridView: View {
    let days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sta", "Sun"]
    let timeSlots = Array(9...24) // 9시부터 7시(19)까지
    let schedule = [
        (day: "Mon", startHour: 9, endHour: 10, title: "MA5031", location: "SOE CR BI-2"),
        (day: "Mon", startHour: 11, endHour: 17, title: "MA5031", location: "SOE CR BI-2"),
        (day: "Wed", startHour: 10, endHour: 12, title: "MA5031", location: "SOE CR BI-2")
    ]
    
    var body: some View {
        Grid(horizontalSpacing: 1, verticalSpacing: 1) {
            GridRow {
                ForEach(days, id: \.self) { _ in
                    Rectangle()
                        .fill(.clear)
                        .stroke(Color.heyGray6, lineWidth: 0.5)
                        .frame(width: 73, height: 21)
                }
            }
            
            ForEach(timeSlots, id: \.self) { hour in
                GridRow(alignment: .top) {
                    ForEach(days, id: \.self) { day in
                        
                        ZStack {
                            Rectangle()
                                .fill(.clear)
                                .stroke(Color.heyGray6, lineWidth: 0.5)
                            
                            
                            // 강의 슬롯 색칠
                            if let slot = schedule.first(where: {
                                $0.day == day && hour >= $0.startHour && hour < $0.endHour
                            }) {
                                ZStack {
                                    Color.heySubMain
                                    
                                    if hour == slot.startHour {
                                        
                                        VStack(alignment: .leading) {
                                            
                                            // 강의 시작 시간에만 텍스트 표시
                                            Text(slot.title)
                                                .font(.medium_12)
                                                .multilineTextAlignment(.center)
                                            Text(slot.location)
                                                .font(.regular_10)
                                                .foregroundColor(.gray)
                                            Spacer()
                                        }
                                        
                                        
                                    }
                                }
                                
                                .background(Color.blue.opacity(0.2))
                            }
                        }
                        .frame(width: 73, height: 52)
                    }
                    
                    
                }
            }
        }
    }
}
public struct WeeklyListView: View {
    var weekList = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sta", "Sun"]
    public var body: some View {
        HStack(spacing: 55) {
            ForEach(weekList, id: \.self) { day in
                WeeklyListCellView(day)
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
        
        //            .padding(.horizontal, 8)
        //            .padding(.vertical, 5)
        //            .background(Color.heyGray3) //색상 확인하기
        //            .clipShape(RoundedRectangle(cornerRadius: 4))
    }
}


#Preview {
    TimeTableView()
}

//
//  TimeTableGridView.swift
//  TimeTableFeature
//
//  Created by 류희재 on 12/27/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

public struct TimeTableGridView: View {
    @Binding var isShowingModuleDetailInfoView: Bool
    
    let days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sta", "Sun"]
    let timeSlots = Array(9...24) // 9시부터 7시(19)까지
    let schedule = [
        (day: "Mon", startHour: 9, endHour: 10, title: "MA5031", location: "SOE CR BI-2"),
        (day: "Mon", startHour: 11, endHour: 17, title: "MA5031", location: "SOE CR BI-2"),
        (day: "Wed", startHour: 10, endHour: 12, title: "MA5031", location: "SOE CR BI-2")
    ]
    
    public var body: some View {
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
                                Button {
                                    withAnimation {
                                        isShowingModuleDetailInfoView.toggle()
                                    }
                                    
                                } label: {
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

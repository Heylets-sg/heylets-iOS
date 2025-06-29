//
//  HourListView.swift
//  TimeTableFeature
//
//  Created by 류희재 on 12/27/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

import DSKit
import Domain

public struct HourListView: View {
    var hourList: [Int]
    
    init(_ hourList: [Int]) {
        self.hourList = hourList
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(Color.timeTableMain.Timeline.background)
                .frame(height: 0.5)
                .padding(.bottom, 17)
            
            ForEach(hourList, id: \.self) { hour in
                HStack {
                    Text("\(hour > 12 ? hour - 12 : hour)")
                        .font(.regular_12)
                        .foregroundColor(.timeTableMain.Timeline.default)
                        .multilineTextAlignment(.trailing)
                }
                .frame(height: 16)
                .padding(.leading, 2)
                .padding(.bottom, 36)
            }
        }
        .frame(width: 25)
    }
}




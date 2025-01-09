//
//  WeeklyListView.swift
//  TimeTableFeature
//
//  Created by 류희재 on 12/27/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

import Domain

public struct WeeklyListView: View {
    var weekList: [Week]
    
    init(_ weekList: [Week]) {
        self.weekList = weekList
    }
    public var body: some View {
        HStack(spacing: 55) {
            ForEach(weekList, id: \.self) { day in
                WeeklyListCellView(day.rawValue)
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

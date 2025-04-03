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
    let cellWidth: CGFloat
    
    init(_ weekList: [Week], cellWidth: CGFloat) {
        self.weekList = weekList
        self.cellWidth = cellWidth
    }
    
    public var body: some View {
        HStack(spacing: 0) {
            ForEach(weekList, id: \.self) { day in
                WeeklyListCellView(day.rawValue)
                    .frame(width: cellWidth)
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
            Spacer()
            Text(day)
                .font(.semibold_12)
                .foregroundColor(.heyGray1)
            Spacer()
        }
    }
}

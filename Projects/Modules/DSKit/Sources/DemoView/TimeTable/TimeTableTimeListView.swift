//
//  TimeTableTimeListView.swift
//  DSKit
//
//  Created by 류희재 on 12/26/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

public struct HourListView: View {
    var hourList = [9, 10, 11, 12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    public var body: some View {
        VStack(spacing: 40) {
            ForEach(hourList, id: \.self) { hour in
                HourListCellView(hour)
            }
        }
        .padding(.top, 10)
    }
}

fileprivate struct HourListCellView: View {
    public let hour: Int
    public init(_ hour: Int) {
        self.hour = hour
    }
    var body: some View {
        HStack {
            Text("\(hour)")
                .font(.regular_12)
                .foregroundColor(.heyGray1)
        }
        .padding(.leading, 10)
    }
}




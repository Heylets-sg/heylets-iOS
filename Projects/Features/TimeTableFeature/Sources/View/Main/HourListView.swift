//
//  HourListView.swift
//  TimeTableFeature
//
//  Created by 류희재 on 12/27/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

import DSKit

public struct HourListView: View {
    let hourList = [8, 9, 10, 11, 12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    
    public var body: some View {
        VStack(spacing: 40) {
            ForEach(hourList, id: \.self) { hour in
                HourListCellView(hour)
            }
        }
        .padding(.top, 10)
        .frame(width: 25)
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
                .padding(.leading, 10)
        }
    }
}





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
    let hourList = [8, 9, 10, 11, 12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    
    public var body: some View {
        VStack(spacing: 0) {
            Divider()
                .background(Color.heyGray6)
                .padding(.bottom, 17)
            
            ForEach(hourList, id: \.self) { hour in
                HStack {
                    Text("\(hour)")
                        .font(.regular_12)
                        .foregroundColor(.heyGray1)
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

#Preview {
    @State var stub: TimeTableViewType = .main
    return MainView(
        viewModel: .init(StubHeyUseCase.stub.timeTableUseCase),
        viewType: $stub
    )
}



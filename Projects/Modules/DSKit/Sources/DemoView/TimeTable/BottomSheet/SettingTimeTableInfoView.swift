//
//  SettingTimeTableInfoView.swift
//  DSKit
//
//  Created by 류희재 on 12/27/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

struct SettingTimeTableInfoView: View {
//    @State var isShowingSelectInfoView: Bool = false
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 30)
            
            HStack {
                Text("Information")
                    .font(.medium_14)
                    .foregroundColor(.heyGray1)
                
                Spacer()
                
                Button {
//                    isShowingSelectInfoView.toggle()
                } label: {
                    Text("Module code, Class room, Professor")
                        .font(.regular_12)
                        .foregroundColor(.heyGray2)
                }
                
                Spacer()
                
            }
            .padding(.leading, 24)
            
            Spacer()
        }
    }
}

#Preview {
    SettingTimeTableInfoView()
}

//
//  GuestAlertView.swift
//  TimeTableFeature
//
//  Created by 류희재 on 2/18/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import SwiftUI

struct GuestAlertView: View {
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text("To use more tools!")
                        .font(.semibold_18)
                        .foregroundColor(.heyGray1)
                        .padding(.bottom, 8)
                    
                    Text("Manage everything about\nyour school life with the Heylets")
                        .font(.regular_12)
                        .foregroundColor(Color.init(hex: "#646464"))
                }
                Spacer()
            }
            .padding(.bottom, 25)
            
            Image(uiImage: .guest)
                .padding(.leading, 76)
                .padding(.trailing, 50)
                .padding(.bottom, 29)
            
            Button {
                
            } label: {
                Text("Log In")
                    .font(.semibold_14)
                    .foregroundColor(.heyWhite)
                    .padding(.vertical, 15)
                    .padding(.horizontal, 20)
            }
            .background(Color.heyMain)
            
            
        }
        .frame(width: 286, height: 373)
        
    }
}

#Preview {
    GuestAlertView()
}

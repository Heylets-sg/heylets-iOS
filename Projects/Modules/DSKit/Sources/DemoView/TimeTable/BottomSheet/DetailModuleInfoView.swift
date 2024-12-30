//
//  ClassDetailInfoView.swift
//  DSKit
//
//  Created by 류희재 on 12/26/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

public struct DetailModuleInfoView: View {
    @Binding var viewType: TimeTableViewType
    @Binding var deleteModuleAlertIsPresented: Bool
    
    public var body: some View {
        
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text("ML0004")
                    .font(.semibold_14)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 3)
                    .background(Color.heySubMain)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                
                
                Text("Career and Entrepreneurial\nDevelopment")
                    .font(.semibold_18)
                    .foregroundColor(.heyGray1)
                    .padding(.bottom, 16)
            }
            .padding(.leading, 25)
            .padding(.trailing, 120)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Mon 12:00 - 13:00, Thu 9:00 - 10:00")
                    .font(.regular_14)
                    .foregroundColor(Color.heyGray3)
                
                Text("To Be Announced")
                    .font(.regular_14)
                    .foregroundColor(Color.heyGray3)
                
                Text("SOE CR B1-2 / 2 unit")
                    .font(.regular_14)
                    .foregroundColor(Color.heyGray3)
                
            }
            .padding(.leading, 25)
            .padding(.trailing, 120)
            .padding(.bottom, 47)
            
            HStack {
                Spacer()
                
                Button {
                    viewType = .main
                    deleteModuleAlertIsPresented.toggle()
                } label: {
                    VStack {
                        Text("Delete")
                            .font(.regular_14)
                            .foregroundColor(.heyGray3)
                        
                        Divider()
                            .frame(width: 43)
                    }
                }
                Spacer()
            }
            
            Spacer()
                .frame(height: 36)
        }
        .padding(.top, 25)
        .frame(height: 280)
        .cornerRadius(12, corners: [.topLeft, .topRight])
    }
}

//#Preview {
//    DetailModuleInfoView(isShowingModuleDetailInfoView: true)
//}

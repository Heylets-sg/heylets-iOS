//
//  ClassAddView.swift
//  DSKit
//
//  Created by 류희재 on 12/26/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

public struct AddModuleView: View {
    @State var text = ""
    public var body: some View {
        
        VStack(alignment: .leading) {
            Spacer()
                .frame(height: 48)
            
            HStack(spacing: 6) {
                Text("Mon")
                    .font(.regular_14)
                    .foregroundColor(.heyGray1)
                
                Button {
                    
                } label: {
                    Image(uiImage: .icDown)
                        .resizable()
                        .frame(width: 9, height: 4)
                }
                
                Text("09:00 - 10:00")
                    .font(.regular_14)
                    .foregroundColor(.heyGray1)
                
                Button {
                    
                } label: {
                    Image(uiImage: .icDown)
                        .resizable()
                        .frame(width: 9, height: 4)
                }
            }
            .padding(.bottom, 24)
            
            VStack(spacing: 20) {
                VStack {
                    TextField(
                        "",
                        text: $text,
                        prompt: Text("Schedule")
                            .font(.regular_14)
                            .foregroundColor(.heyGray2)
                    )
                    
                    Divider()
                        .foregroundColor(.heyGray2)
                }
                
                VStack {
                    TextField(
                        "",
                        text: $text,
                        prompt: Text("Location(option)")
                            .font(.regular_14)
                            .foregroundColor(.heyGray2)
                    )
                    
                    Divider()
                        .foregroundColor(.heyGray2)
                }
                
                VStack {
                    TextField(
                        "",
                        text: $text,
                        prompt: Text("Professor(option)")
                            .font(.regular_14)
                            .foregroundColor(.heyGray2)
                    )
                    
                    Divider()
                        .foregroundColor(.heyGray2)
                }
            }
            Spacer()
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    AddModuleView()
}

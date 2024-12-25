//
//  MyPageBaseView.swift
//  DSKit
//
//  Created by 류희재 on 12/24/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI
import DSKit

struct MyPageBaseView<Content:View>: View {
    
    @Environment(\.dismiss) var dismiss
    
    let content: Content
    let titleText: String
    let titleColor: Color
    let backgroundColor: Color
    
    init(
        @ViewBuilder content: () -> Content,
        titleText: String,
        titleColor: Color = .heyGray1,
        backgroundColor: Color = .heyWhite
    ) {
        self.content = content()
        self.titleText = titleText
        self.titleColor = titleColor
        self.backgroundColor = backgroundColor
    }
    
    var body: some View {
        
        ZStack {
            backgroundColor.ignoresSafeArea()
            
            VStack(alignment: .leading) {
                Spacer()
                    .frame(height: 58)
                
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(uiImage: .icBack.withRenderingMode(.alwaysTemplate))
                            .resizable()
                            .frame(width: 22, height: 18)
                            .tint(titleColor)
                    }
                    
                    Spacer()
                    
                    Text(titleText)
                        .font(.semibold_18)
                        .foregroundColor(titleColor)
                    
                    Spacer()
                }
                
                content
                
                Spacer()
                
            }
            .padding(.horizontal, 16)
        }
        .ignoresSafeArea(edges: .vertical)
        .ignoresSafeArea(.keyboard)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    MyPageBaseView(content: {}, titleText: "My account")
//        .environmentObject(StubOnboardingNavigationRouter())
}

//
//  MyPageBaseView.swift
//  MyPageFeature
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
        titleColor: Color = .common.MainText.default,
        backgroundColor: Color = .common.Background.default
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
                
                ZStack {
                    HStack {
                        Spacer()
                        
                        Text(titleText)
                            .font(.semibold_18)
                            .foregroundColor(titleColor)
                        
                        Spacer()
                    }
                    
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Image.icBack
                                .resizable()
                                .frame(width: 24, height: 18)
                                .tint(.common.ButtonBack.default)
                        }
                        Spacer()
                    }
                    
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

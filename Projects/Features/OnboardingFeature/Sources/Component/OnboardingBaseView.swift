//
//  OnboardingBaseView.swift
//  OnboardingFeature
//
//  Created by 류희재 on 12/20/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI
import DSKit

struct OnboardingBaseView<Content:View>: View {
    
    let content: Content
    let titleText: String
    let buttonTitle: String
    
    init(
        @ViewBuilder content: () -> Content,
        titleText: String,
        buttonTitle: String = "Continue"
    ) {
        self.content = content()
        self.titleText = titleText
        self.buttonTitle = buttonTitle
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Spacer()
                .frame(height: 92)
            
            Button {
                
            } label: {
                Image(uiImage: .icBack)
                    .resizable()
                    .frame(width: 22, height: 18)
            }
            VStack(alignment: .leading) {
                Text(titleText)
                    .font(.semibold_18)
                    .foregroundColor(.heyGray1)
                    .padding(.bottom, 18)
                
                content
                
                Spacer()
                
                Button(buttonTitle) {
                    // Action
                }
                .heyBottomButtonStyle()
                    
            }
            .padding(.top, 36)
            .padding(.bottom, 65)
        }
        .padding(.horizontal, 16)
        .background(Color.heyWhite)
        .ignoresSafeArea(edges: .vertical)
        .ignoresSafeArea(.keyboard)
        .navigationBarBackButtonHidden()
        .setOnboardingNavigation()
    }
}

//#Preview {
//    OnboardingBaseView(content: {})
////        .environmentObject(StubOnboardingNavigationRouter())
//}

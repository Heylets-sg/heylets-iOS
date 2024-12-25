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
    
    init(
        @ViewBuilder content: () -> Content,
        titleText: String
    ) {
        self.content = content()
        self.titleText = titleText
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
                .frame(height: 58)
            
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(uiImage: .icBack)
                        .resizable()
                        .frame(width: 22, height: 18)
                }
            }
        }
        .padding(.horizontal, 16)
        .background(Color.heyWhite)
        .ignoresSafeArea(edges: .vertical)
        .ignoresSafeArea(.keyboard)
        .navigationBarBackButtonHidden()
//        .setOnboardingNavigation()
    }
}

#Preview {
    MyPageBaseView(content: {}, titleText: "My account")
//        .environmentObject(StubOnboardingNavigationRouter())
}

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
    
    @Environment(\.dismiss) var dismiss
    
    let content: Content
    
    let titleText: String
    
    let hiddenCloseBtn: Bool
    
    let buttonTitle: String
    let nextButtonIsEnabled: Bool
    let nextButtonAction: () -> Void
    
    init(
        @ViewBuilder content: () -> Content,
        titleText: String,
        nextButtonIsEnabled: Bool = true,
        buttonTitle: String = "Continue",
        hiddenCloseBtn: Bool = true,
        nextButtonAction: @escaping () -> Void
    ) {
        self.content = content()
        self.titleText = titleText
        self.buttonTitle = buttonTitle
        self.hiddenCloseBtn = hiddenCloseBtn
        self.nextButtonIsEnabled = nextButtonIsEnabled
        self.nextButtonAction = nextButtonAction
    }
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                
                Spacer()
                    .frame(height: 92.adjusted)
                
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(uiImage: .icBack.withRenderingMode(.alwaysTemplate))
                            .resizable()
                            .frame(width: 22, height: 18)
                            .tint(.common.ButtonBack.default)
                    }
                    .hidden(!hiddenCloseBtn)
                    
                    Spacer()
                    
                    Button {
                        dismiss()
                    } label: {
                        Image(uiImage: .icClose.withRenderingMode(.alwaysTemplate))
                            .resizable()
                            .frame(width: 18, height: 18)
                            .tint(.common.ButtonClose.default)
                    }
                    .hidden(hiddenCloseBtn)
                    
                }
                
                VStack(alignment: .leading) {
                    Text(titleText)
                        .font(.semibold_18)
                        .foregroundColor(.common.MainText.default)
                        .padding(.bottom, 18.adjusted)
                    
                    content
                    
                    Spacer()
                    
                    Button(buttonTitle) {
                        nextButtonAction()
                    }
                    .disabled(!nextButtonIsEnabled)
                    .heyBottomButtonStyle()
                    
                }
                .padding(.top, 36.adjusted)
                .padding(.bottom, 65.adjusted)
            }
            .padding(.horizontal, 16)
            .background(Color.common.Background.default)
            .ignoresSafeArea(edges: .vertical)
            .ignoresSafeArea(.keyboard)
            .navigationBarBackButtonHidden()
        }
    }
}

//#Preview {
//    OnboardingBaseView(content: {})
////        .environmentObject(StubOnboardingNavigationRouter())
//}

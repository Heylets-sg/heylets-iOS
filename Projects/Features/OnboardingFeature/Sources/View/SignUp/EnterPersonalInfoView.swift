//
//  EnterPersonalInfoView.swift
//  OnboardingFeature
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI
import BaseFeatureDependency
import DSKit

public struct EnterPersonalInfoView: View {
    @EnvironmentObject var router: Router
    var viewModel: EnterPersonalInfoViewModel
    
    @State var text = ""
    
    public init(viewModel: EnterPersonalInfoViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        OnboardingBaseView(content: {
            Spacer()
                .frame(height: 8)
            
            HStack(spacing: 16) {
                Button("Men") {}
                .heyBottomButtonStyle(.primary, cornerRadius: 8)
                
                Button("Women") {}
                .heyBottomButtonStyle(.gray, cornerRadius: 8)
                
                
                Button("Others") {}
                .heyBottomButtonStyle(.gray, cornerRadius: 8)
            }
            .padding(.trailing, 62)
            .padding(.bottom, 20)
            
            HeyTextField(
                text: $text,
                placeHolder: "2002/03/08",
                textFieldState: .idle,
                colorSystem: .gray
            )
            .padding(.trailing, 30)
            
        }, titleText: "Please check your gender/birth",
                           nextButtonAction: { viewModel.send(.nextButtonDidTap) })
    }
}

//#Preview {
//    EnterPersonalInfoView()
//}

//
//  VerifyEmailView.swift
//  OnboardingFeature
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

import BaseFeatureDependency
import DSKit

public struct VerifyEmailView: View {
    @EnvironmentObject var router: Router
    var viewModel: VerifyEmailViewModel
    @State var text = ""
    
    public init(viewModel: VerifyEmailViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        OnboardingBaseView(content: {
            Spacer()
                .frame(height: 18)
            
            HStack {
                HeyTextField(
                    text: $text,
                    placeHolder: "Enter your school email",
                    textFieldState: .idle,
                    colorSystem: .gray
                )
                .padding(.trailing, 12)
                
                Text("@")
                    .font(.regular_16)
                    .foregroundColor(.heyGray1)
            }
            .padding(.trailing, 47)
            .padding(.bottom, 18)
            
            HeyTextField(
                text: $text,
                placeHolder: "Enter your school email",
                textFieldState: .idle,
                colorSystem: .gray
            )
            .padding(.trailing, 116)
            
        }, titleText: "Verify with your school email")
    }
}

//#Preview {
//    VerifyEmailView()
//}



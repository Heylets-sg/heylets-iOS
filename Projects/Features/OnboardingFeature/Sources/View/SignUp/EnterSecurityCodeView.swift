//
//  EnterSecurityCodeView.swift
//  OnboardingFeature
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

import BaseFeatureDependency
import DSKit

public struct EnterSecurityCodeView: View {
    @EnvironmentObject var router: Router
    var viewModel: EnterSecurityCodeViewModel
    
    @State var otpCode: String = ""
    
    public init(viewModel: EnterSecurityCodeViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        OnboardingBaseView(content: {
            Spacer()
                .frame(height: 8)
            
            Text(verbatim: "Enter the 6-digit code we sent to the email:\nj******m@o*****com")
                .font(.regular_16)
                .foregroundColor(.heyGray2)
                .lineLimit(2)
            
            SecurityCodeInputView(otpCode: $otpCode)
            .frame(height: 50)
            
        }, titleText: "Enter Your Security Code",
                           nextButtonAction: { viewModel.send(.nextButtonDidTap) })
    }
}

//#Preview {
//    EnterSecurityCodeView()
//}

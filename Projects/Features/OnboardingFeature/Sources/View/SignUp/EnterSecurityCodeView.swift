//
//  EnterSecurityCodeView.swift
//  OnboardingFeature
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI
import BaseFeatureDependency

public struct EnterSecurityCodeView: View {
    @EnvironmentObject var router: Router
    var viewModel: EnterSecurityCodeViewModel
    
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
            
            //MARK: 텍스트 필드 넣기
            
        }, titleText: "Enter Your Security Code")
    }
}

//#Preview {
//    EnterSecurityCodeView()
//}

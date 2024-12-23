//
//  LoginView.swift
//  DSKit
//
//  Created by 류희재 on 12/23/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    
    @State var otpCode: String = ""
    @State var showPassword: Bool = false
    
    public var body: some View {
        OnboardingBaseView(content: {
            Spacer()
                .frame(height: 8)
            
            Text(verbatim: "Enter the 6-digit code we sent to the email:\nj******m@o*****com")
                .font(.regular_16)
                .foregroundColor(.heyGray2)
                .lineLimit(2)
            
            Spacer()
                .frame(height: 88)
            
            VStack {
                SecurityCodeInputView(otpCode: $otpCode)
                .frame(height: 50)
                .padding(.bottom, 4)
                
                Text("Incorrect security code. Check your code and try again")
                    .font(.regular_12)
                    .foregroundColor(.heyError)
            }
        }, titleText: "Enter Your Security Code")
    }
}

#Preview {
    LoginView()
}

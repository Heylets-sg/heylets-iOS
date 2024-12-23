//
//  LoginView.swift
//  DSKit
//
//  Created by 류희재 on 12/23/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    
    var body: some View {
        OnboardingBaseView(content: {
            Spacer()
                .frame(height: 8)
            
            Text("How about a picture of a cute cat?")
                .font(.regular_16)
                .foregroundColor(.heyGray1)
                .padding(.bottom, 32)
            
            Button{
            } label: {
                ZStack {
                    Circle()
                        .fill(Color.heyGray4)
                        .frame(width: 136, height: 136)
                    
                    Image(systemName: "camera")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.black)
                }
            }
            .padding(.horizontal, 113)
            
        }, titleText: "Add profile picture")
    }
}

#Preview {
    LoginView()
}

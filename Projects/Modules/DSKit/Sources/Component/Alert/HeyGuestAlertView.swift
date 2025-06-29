//
//  HeyGuestAlertView.swift
//  DSKit
//
//  Created by 류희재 on 3/4/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import SwiftUI

struct GuestAlertView: View {
    var loginButtonAction: () -> Void
    var notRightNowAction: () -> Void
    
    init(
        _ loginButtonAction: @escaping () -> Void,
        _ notRightNowAction: @escaping () -> Void
    ) {
        self.loginButtonAction = loginButtonAction
        self.notRightNowAction = notRightNowAction
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text("To use more tools!")
                        .font(.semibold_18)
                        .foregroundColor(.common.MainText.else)
                        .padding(.bottom, 6)
                    
                    Text("Manage everything about\nyour school life with the Heylets")
                        .font(.regular_12)
                        .foregroundColor(.common.MainText.default)
                }
                Spacer()
            }
            .padding(.top, 28)
            .padding(.bottom, 25)
            .padding(.leading, 24)
            
            Image.guest
                .resizable()
                .frame(width: 160, height: 120)
                .padding(.leading, 76)
                .padding(.trailing, 50)
                .padding(.bottom, 29)
            
            Button {
                loginButtonAction()
            } label: {
                HStack {
                    Text("Log In")
                        .font(.semibold_14)
                        .foregroundColor(.common.CTAText.active)
                        .padding(.trailing, 8)
                    
                    Image.icArrow
                        .resizable()
                        .frame(width: 10, height: 9)
                        .tint(Color.common.CTAText.active)
                }
                .padding(.vertical, 15)
                .padding(.horizontal, 92)
                
            }
            .frame(height: 50)
            .background(Color.common.CTA.active)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.bottom, 14)
            
            Button {
                notRightNowAction()
            } label: {
                Text("Not right now")
                    .font(.regular_12)
                    .foregroundColor(.common.MainText.default)
            }
            .padding(.bottom, 22)
        }
        .background(Color.popup.default)
        .frame(height: 373)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

extension View {
    public func heyAlert(
        isPresented: Bool,
        loginButtonAction: @escaping () -> Void,
        notRightNowButton: @escaping () -> Void
    ) -> some View {
        self.overlay {
            if isPresented {
                ZStack {
//                    Color.popup.default
                    
                    GuestAlertView(
                        loginButtonAction,
                        notRightNowButton
                    )
                    .padding(.horizontal, 52)
                }
                .ignoresSafeArea()
                
            }
        }
    }
}

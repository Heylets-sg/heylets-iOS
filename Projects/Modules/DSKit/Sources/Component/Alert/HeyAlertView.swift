//
//  HeyAlert.swift
//  DSKit
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

struct HeyAlertView: View {
    
    var title: String
    var primaryAction: (title: String, colorSystem: HeyButtonColorStyle, action: () -> Void)
    var secondaryAction: (title: String, colorSystem: HeyButtonColorStyle, action: () -> Void)?
    
    
    var body: some View {
        VStack {
            Spacer()
            
            Text(title)
                .font(.medium_18)
                .foregroundColor(.heyBlack)
                .multilineTextAlignment(.center)
            
            Spacer()
            
            HStack {
                Button(primaryAction.title) {
                    primaryAction.action()
                }
                .heyAlertButtonStyle(primaryAction.colorSystem)
                
                if let secondaryAction = secondaryAction {
                    Spacer()
                        .frame(width: 24)
                    
                    Button(secondaryAction.title) {
                        secondaryAction.action()
                    }
                    .heyAlertButtonStyle(secondaryAction.colorSystem)
                }
            }
            
            Spacer()
                .frame(height: 24)
        }
        .padding(.horizontal, 24)
        .frame(height: 154)
        .frame(maxWidth: .infinity)
        .background(Color.heyWhite)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}



extension View {
    func heyAlert(
        isPresented: Bool,
        title: String,
        primaryButton: (String, HeyButtonColorStyle, () -> Void),
        secondaryButton: (String, HeyButtonColorStyle, () -> Void)? = nil
    ) -> some View {
        self.overlay {
            if isPresented {
                ZStack {
                    Color.black.opacity(0.5)
                    
                    HeyAlertView(
                        title: title,
                        primaryAction: primaryButton,
                        secondaryAction: secondaryButton
                    )
                    .padding(.horizontal, 16)
                    .shadow(radius: 10)
                }
                .ignoresSafeArea()
                
            }
        }
    }
    
}

//
//  HeyAlert.swift
//  DSKit
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

public struct HeyAlertView: View {
    public init(
        title: String,
        isEditedName: Bool = false,
        text: String = "",
        primaryAction: (title: String, colorSystem: HeyButtonColorStyle, action: () -> Void),
        secondaryAction: (title: String, colorSystem: HeyButtonColorStyle, action: () -> Void)? = nil) {
            self.title = title
            self.isEditedName = isEditedName
            self.text = text
            self.primaryAction = primaryAction
            self.secondaryAction = secondaryAction
        }
    
    var title: String
    var isEditedName: Bool
    @State var text = ""
    var primaryAction: (title: String, colorSystem: HeyButtonColorStyle, action: () -> Void)
    var secondaryAction: (title: String, colorSystem: HeyButtonColorStyle, action: () -> Void)?
    
    
    public var body: some View {
        VStack {
            Spacer()
            
            Text(title)
                .font(.medium_18)
                .foregroundColor(.heyBlack)
                .multilineTextAlignment(.center)
            
            Spacer()
            
            if isEditedName {
                TextField(text: $text, label: {
                    
                })
                .font(.medium_12)
                .foregroundColor(.heyGray1)
                .frame(height: 51)
                .background(Color.heyGray3)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(.bottom, 26)
                
            }
            
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
        .frame(height: isEditedName ? 213: 154)
        .frame(maxWidth: .infinity)
        .background(Color.heyWhite)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

public enum DemoTimeTableSettingAlertType {
    case editTimeTableName
    case shareURL
    case saveImage
    case removeTimeTable
}

extension View {
    public func heyAlert(
        isPresented: Bool,
        title: String,
        isEditedName: Bool = false,
        primaryButton: (String, HeyButtonColorStyle, () -> Void),
        secondaryButton: (String, HeyButtonColorStyle, () -> Void)? = nil
    ) -> some View {
        self.overlay {
            if isPresented {
                ZStack {
                    Color.black.opacity(0.5)
                    
                    HeyAlertView(
                        title: title,
                        isEditedName: isEditedName,
                        primaryAction: primaryButton,
                        secondaryAction: secondaryButton
                    )
                    .padding(.horizontal, 44)
                    .shadow(radius: 10)
                }
                .ignoresSafeArea()
                
            }
        }
    }
}





//
//  HeyAlertEnterNameView.swift
//  DSKit
//
//  Created by 류희재 on 1/7/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import SwiftUI

public struct HeyAlertTextFieldView: View {
    public init(
        title: String,
        content: Binding<String>,
        primaryAction: HeyAlertButtonType,
        secondaryAction: HeyAlertButtonType
    ) {
        self.title = title
        self._content = content
        self.primaryAction = primaryAction
        self.secondaryAction = secondaryAction
    }
    
    var title: String
    @Binding var content: String
    var primaryAction: HeyAlertButtonType
    var secondaryAction: HeyAlertButtonType
    
    
    public var body: some View {
        ZStack {
            Color.common.Background.opacity60
            
            VStack {
                Text(title)
                    .font(.medium_18)
                    .foregroundColor(.common.MainText.default)
                    .padding(.vertical, 24.adjusted)
                
                TextField(text: $content, label: {
                    
                })
                .font(.medium_12)
                .foregroundColor(.common.MainText.default)
                .frame(height: 51.adjusted)
                .background(Color.common.InputField.default)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(.horizontal, 24.adjusted)
                
                .padding(.bottom, 26.adjusted)
                
                HStack {
                    Button(primaryAction.title) {
                        primaryAction.action()
                    }
                    .heyAlertButtonStyle(primaryAction.color)
                    
                    Spacer()
                        .frame(width: 24.adjusted)
                    
                    Button(secondaryAction.title) {
                        secondaryAction.action()
                    }
                    .heyAlertButtonStyle(secondaryAction.color)
                }
                .padding(.horizontal, 24.adjusted)
                .padding(.bottom, 24.adjusted)
            }
            .background(Color.popup.default)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding(.horizontal, 44.adjusted)
        }
        .ignoresSafeArea()
    }
}


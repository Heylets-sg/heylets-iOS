//
//  TodoAddItemView.swift
//  TodoFeature
//
//  Created by 류희재 on 3/2/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import SwiftUI

import DSKit
import Domain
import BaseFeatureDependency

public struct TodoChangeGroupNameAlertView: View {
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
            Color.black.opacity(0.5)
            
            VStack {
                Text(title)
                    .font(.medium_18)
                    .foregroundColor(.heyGray1)
                    .padding(.vertical, 24)
                
                TextField(text: $content, label: {
                    
                })
                .font(.medium_12)
                .foregroundColor(.heyGray1)
                .frame(height: 51)
                .background(Color.init(hex: "#F4F4F4"))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(.horizontal, 24)
                
                .padding(.bottom, 26)
                
                HStack {
                    Button(primaryAction.title) {
                        primaryAction.action()
                    }
                    .heyAlertButtonStyle(primaryAction.colorSystem)
                    
                    Spacer()
                        .frame(width: 24)
                    
                    Button(secondaryAction.title) {
                        secondaryAction.action()
                    }
                    .heyAlertButtonStyle(secondaryAction.colorSystem)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 24)
            }
            .background(Color.heyWhite)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding(.horizontal, 24)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    let useCase = StubHeyUseCase.stub.todoUseCase
    return TodoView(
        viewModel: .init(
            windowRouter: Router.default.windowRouter,
            useCase: useCase
        )
    )
    .environmentObject(Router.default)
}

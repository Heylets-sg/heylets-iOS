//
//  NotificationSettingView.swift
//  MyPageFeature
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI
import BaseFeatureDependency

public struct NotificationSettingView: View {
    
    @ObservedObject var viewModel: NotificationSettingViewModel
    
    public init(viewModel: NotificationSettingViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        MyPageBaseView(content: {
            Spacer()
                .frame(height: 27)
            
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Daily briefing")
                            .font(.semibold_16)
                            .foregroundColor(.heyGray1)
                            .lineSpacing(8)
                            .padding(.bottom, 4)
                        
                        Text("ex. There’s two modules today")
                            .font(.regular_12)
                            .foregroundColor(.heyGray1)
                            .lineSpacing(12)
                            .padding(.bottom, 4)
                    }
                    
                    Spacer()
                    
                    Toggle("", isOn: $viewModel.state.dailyBriefingToggleOn)
                        .toggleStyle(SwitchToggleStyle(tint: Color.heyMain))
                        .labelsHidden()
                        .padding(.trailing, 15)
                    
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 24)
                .background(Color.heyGray4)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
                Spacer()
                    .frame(height: 20)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Class")
                            .font(.semibold_16)
                            .foregroundColor(.heyGray1)
                            .lineSpacing(8)
                            .padding(.bottom, 4)
                        
                        Text("ex. There’s two modules today")
                            .font(.regular_12)
                            .foregroundColor(.heyGray1)
                            .lineSpacing(12)
                            .padding(.bottom, 4)
                    }
                    
                    Spacer()
                    
                    Toggle("", isOn: $viewModel.state.classToggleOn)
                        .toggleStyle(SwitchToggleStyle(tint: Color.heyMain))
                        .labelsHidden()
                        .padding(.trailing, 15)
                    
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 24)
                .background(Color.heyGray4)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            
            
        }, titleText: "Notification setting")
    }
}

#Preview {
    NotificationSettingView(
        viewModel: .init(
            navigationRouter: Router.default.navigationRouter)
    )
    .environmentObject(Router.default)
}


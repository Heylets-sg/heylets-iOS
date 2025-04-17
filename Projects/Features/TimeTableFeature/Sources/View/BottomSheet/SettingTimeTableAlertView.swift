//
//  SettingTimeTableAlertView.swift
//  TimeTableFeature
//
//  Created by 류희재 on 1/8/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import SwiftUI

import DSKit
import Core

public struct SettingTimeTableAlertView: View {
    @ObservedObject var viewModel: TimeTableSettingViewModel
    
    public init(
        viewModel: TimeTableSettingViewModel
    ) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        ZStack {
            if let type = viewModel.settingAlertType {
                Color.common.Background.opacity60
                    .ignoresSafeArea()
                
                Group {
                    switch type {
                    case .editTimeTableName:
                        HeyAlertTextFieldView(
                            title: "Enter name",
                            content: $viewModel.state.timeTableName,
                            primaryAction: ("Close", .gray, { viewModel.send(.settingAlertDismiss) }),
                            secondaryAction: ("Ok", .primary, { viewModel.send(.editTimeTableName) })
                        )
                        
                    case .saveImage:
                        HeyAlertView(
                            title: "The timetable has been\nsaved as an image.",
                            primaryAction: ("Ok", .gray, {
                                viewModel.send(.saveImage)
                            })
                        )
                        .padding(.horizontal, 44)
                        
                    case .removeTimeTable:
                        HeyAlertView(
                            title: "Delete this timetable?",
                            primaryAction: ("Delete", .primary, { viewModel.send(.deleteTimeTable) }),
                            secondaryAction: ("Close", .gray, { viewModel.send(.settingAlertDismiss) })
                        )
                        .padding(.horizontal, 44)
                    }
                }
                
                .shadow(radius: 10)
                .onAppear {
                    Analytics.shared.track(.screenView(type.rawValue, .modal))
                }
            }
        }
    }
}

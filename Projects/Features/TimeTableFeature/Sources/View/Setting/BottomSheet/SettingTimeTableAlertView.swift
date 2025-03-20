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
    
    public init(viewModel: TimeTableSettingViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        VStack {
            Group {
                switch viewModel.settingAlertType {
                case .editTimeTableName:
                    HeyAlertEnterNameView(
                        title: "Enter name",
                        text: $viewModel.state.timeTableName,
                        primaryAction: ("Close", .gray, { viewModel.send(.settingAlertDismiss) }),
                        secondaryAction: ("Ok", .primary, { viewModel.send(.editTimeTableName) })
                    )
                    
                case .shareURL:
                    Text("URL copied to clipboard")
                        .font(.medium_18)
                        .foregroundColor(.heyGray1)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 24)
                        .background(Color.heyWhite)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                withAnimation {
                                    viewModel.send(.shareURL)
                                }
                            }
                        }
                    
                case .saveImage:
                    HeyAlertView(
                        title: "The timetable has been\nsaved as an image.",
                        primaryAction: ("Ok", .gray, {
                            viewModel.send(.saveImage)
                        })
                    )
                    
                case .removeTimeTable:
                    HeyAlertView(
                        title: "Delete this timetable?",
                        primaryAction: ("Delete", .primary, { viewModel.send(.deleteTimeTable) }),
                        secondaryAction: ("Close", .gray, { viewModel.send(.settingAlertDismiss) })
                    )
                    
                case .none:
                    EmptyView()
                }
            }
            .padding(.horizontal, 44)
            .shadow(radius: 10)
            .onAppear {
                if viewModel.settingAlertType != .shareURL {
                    Analytics.shared.track(.screenView(viewModel.settingAlertType.rawValue, .modal))
                }
            }
        }
    }
}


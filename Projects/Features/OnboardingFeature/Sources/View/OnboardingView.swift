//
//  OnboardingView.swift
//  OnboardingFeature
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI
import UIKit

import BaseFeatureDependency
import Core
import DSKit

enum OnboardingType {
    case timeTable
    case theme
    case alarm
    
    var title: String {
        switch self {
        case .timeTable:
            return "Add a personal schedule to\nyour school timetable"
        case .theme:
            return "Customize Your Timetable\nwith Your Favorite Color"
        case .alarm:
            return "Get reminders about\ntoday's lessons"
        }
    }
    
    var description: String {
        switch self {
        case.timeTable:
            return "Manage your school-related schedules\nall at once!"
        case .theme:
            return "Customize your timetable with your\nfavorite colors!"
        case .alarm:
            return "Don’t be late with push alarm"
        }
    }
    
    var image: UIImage {
        switch self {
        case .timeTable:
            return .timeTable
        case .theme:
            return .color
        case .alarm:
            return .alarm
        }
    }
    
    var horizontalPadding: Int {
        switch self {
        case .timeTable:
            return 49
        case .theme:
            return 0
        case .alarm:
            return 29
        }
    }
    
    var topPadding: Int {
        switch self {
        case .timeTable:
            return 78
        case .theme:
            return 125
        case .alarm:
            return 99
        }
    }
    
    var bottomPadding: Int {
        switch self {
        case .timeTable:
            return 34
        case .theme:
            return 134
        case .alarm:
            return 118
        }
    }
    
    var height: Int {
        switch self {
        case .timeTable:
            return 293
        case .theme:
            return 145
        case .alarm:
            return 207
        }
    }
}

public struct OnboardingView: View {
    @EnvironmentObject var container: Router
    var viewModel: OnboardingViewModel
    @State var currentIndex = 0 {
        didSet {
            switch currentIndex {
            case 0:
                Analytics.shared.track(.screenView("onboarding_time", .screen))
            case 1:
                Analytics.shared.track(.screenView("onboarding_theme", .screen))
            case 2:
                Analytics.shared.track(.screenView("onboarding_alarm", .screen))
            default:
                break
            }
        }
    }
    
    let onboardingContent: [OnboardingType] = [.timeTable, .theme, .alarm]
    
    public init(viewModel: OnboardingViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        NavigationStack(path: $container.navigationRouter.destinations) {
            GeometryReader { geometry in
                ZStack {
                    Color.heyMain.ignoresSafeArea()
                    
                    VStack {
                        Spacer()
                            .frame(height: UIScreen.main.bounds.height  <= 700 ? 40.adjusted : 90.adjusted)
                        
                        VStack(alignment: .leading, spacing: 0) {
                            VStack(alignment: .leading, spacing: 12) {
                                Text(onboardingContent[currentIndex].title)
                                    .font(.bold_20)
                                    .foregroundColor(.common.MainText.else)
                                    .multilineTextAlignment(.leading)
                                
                                Text(onboardingContent[currentIndex].description)
                                    .font(.medium_14)
                                    .foregroundColor(.common.MainText.else)
                                    .multilineTextAlignment(.leading)
                            }
                            .padding(.leading, 22)
                            .frame(minHeight: 120)
                            
                            VStack {
                                Spacer()
                                    .frame(height: onboardingContent[currentIndex].topPadding.adjusted)
                                
                                Image(uiImage: onboardingContent[currentIndex].image)
                                    .resizable()
                                    .padding(
                                        .horizontal,
                                        onboardingContent[currentIndex].horizontalPadding.adjusted
                                    )
                                
                                Spacer()
                                    .frame(height: onboardingContent[currentIndex].bottomPadding.adjusted)
                            }
                            .frame(height: 424.adjusted)
                        }
                        .gesture(
                            DragGesture()
                                .onEnded { value in
                                    let offsetX = value.translation.width // 드래그가 끝난 후 이동한 거리를 계산한 값
                                    let screenWidth = UIScreen.main.bounds.width
                                    
                                    let progress = -offsetX / screenWidth // 페이지의 이동 비율 (370은 페이지의 너비로 가정)
                                    let threshold: CGFloat = 0.15
                                    let minDragDistance: CGFloat = 50 // 최소 드래그 거리 추가
                                    
                                    if progress > threshold || -offsetX > minDragDistance {
                                        // 오른쪽에서 왼쪽으로 이동 (다음 페이지로)
                                        currentIndex = min(currentIndex + 1, onboardingContent.count - 1) // 3-1 -> content.count로 수정
                                    } else if progress < -threshold {
                                        // 왼쪽에서 오른쪽으로 이동 (이전 페이지로)
                                        currentIndex = max(currentIndex - 1, 0)
                                    }
                                }
                        )
                        
                        
                        VStack {
                            HStack(spacing: 6) {
                                Spacer()
                                ForEach(0..<3, id: \.self) { index in
                                    Circle()
                                        .fill(
                                            index == (currentIndex) % 3
                                            ? Color.init(hex: "EFF2FF")
                                            : Color.init(hex: "#CBD6FF")
                                        )
                                        .frame(width: 6, height: 6)
                                }
                                Spacer()
                            }
                            .padding(.bottom, 50.adjusted)
                            
                            Button("Start") {
                                viewModel.send(.startButtonDidTap)
                            }
                            .heyCTAButtonStyle(.white)
                            .padding(.bottom, 16.adjusted)
                            
                            Button {
                                viewModel.send(.alreadyRegisteredButtonDidTap)
                            } label: {
                                HStack {
                                    Spacer()
                                    Text("Already registered")
                                        .font(.medium_12)
                                        .foregroundColor(.common.MainText.else)
                                    
                                    Image(uiImage: .icNext)
                                        .resizable()
                                        .tint(.common.MainText.else)
                                        .frame(width: 3.5, height: 7)
                                    Spacer()
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                        
                        Spacer()
                            .frame(height: 72.adjusted)
                    }
                }
                .ignoresSafeArea(edges: .vertical)
                .ignoresSafeArea(.keyboard)
                .setOnboardingHeyNavigation()
            }
        }
        .navigationBarBackButtonHidden()
    }
}
#Preview {
    OnboardingView(
        viewModel: OnboardingViewModel(
            navigationRouter: Router.default.navigationRouter
        )
    )
    .environmentObject(Router.default)
}

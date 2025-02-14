//
//  OnboardingView.swift
//  OnboardingFeature
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI
import BaseFeatureDependency
import Core
import DSKit

enum OnboardingType {
    case timeTable
    case theme
    
    var title: String {
        switch self {
        case .timeTable:
            return "Add a personal schedule to\nyour school timetable"
        case .theme:
            return "Customize Your Timetable\nwith Your Favorite Color"
        }
    }
    
    var description: String {
        switch self {
        case.timeTable:
            return "Manage your school-related schedules\nall at once!"
        case .theme:
            return "Customize your timetable with your\nfavorite colors!"
        }
    }
    
    var image: UIImage {
        switch self {
        case .timeTable:
            return .timeTable
        case .theme:
            return .color
        }
    }
}

public struct OnboardingView: View {
    @EnvironmentObject var container: Router
    var viewModel: OnboardingViewModel
    
    let onboardingContent: [OnboardingType] = [.timeTable, .theme]
    
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
                            .frame(height: geometry.size.height * 0.15) // 상대적인 높이 설정
                        
                        CarouselView(pageCount: 2, visibleEdgeSpace: 0, spacing: 0) { index in
                            VStack(alignment: .leading, spacing: 0) {
                                HStack {
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text(onboardingContent[index].title)
                                            .font(.bold_20)
                                            .foregroundColor(.heyWhite)
                                            .multilineTextAlignment(.leading)
                                        
                                        Text(onboardingContent[index].description)
                                            .font(.regular_14)
                                            .foregroundColor(.heyWhite)
                                            .multilineTextAlignment(.leading)
                                    }
                                }
                                .padding(.horizontal, 16)
                                
                                
                                VStack {
                                    Spacer()
                                        .frame(height: index == 0 ? geometry.size.height * 0.06 : geometry.size.height * 0.15)
                                    
                                    HStack {
                                        Spacer()
                                        
                                        Image(uiImage: onboardingContent[index].image)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: geometry.size.width)
                                        
                                        Spacer()
                                    }
                                    
                                    
                                    Spacer()
                                }
                            }
                        }
                        
                        Spacer()
                        
                        VStack {
                            Button("Sign up") {
                                viewModel.send(.signUpButtonDidTap)
                            }
                            .heyBottomButtonStyle(.white)
                            .padding(.bottom, 16)
                            
                            Button("Log in") {
                                viewModel.send(.signInButtonDidTap)
                            }.heyBottomButtonStyle(.black)
                        }
                        .padding(.horizontal, 16)
                        
                        Spacer()
                            .frame(height: geometry.size.height * 0.08) // 하단 여백도 상대적으로 조정
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

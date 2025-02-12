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
            ZStack {
                Color.heyMain.ignoresSafeArea()
                
                VStack(alignment: .leading) {
                    Spacer()
                        .frame(height: 120)
                    
                    CarouselView(pageCount: 2, visibleEdgeSpace: 0, spacing: 0) { index in
                        VStack(alignment: .leading, spacing: 0) {
                            HStack {
                                VStack(alignment: .leading, spacing: 0) {
                                    Text(onboardingContent[index].title)
                                        .font(.bold_20)
                                        .foregroundColor(.heyWhite)
                                        .padding(.bottom, 12)
                                        .multilineTextAlignment(.leading)
                                    
                                    Text(onboardingContent[index].description)
                                        .font(.regular_14)
                                        .foregroundColor(.heyWhite)
                                        .multilineTextAlignment(.leading)
                                }
                                Spacer()
                            }
                            .padding(.leading, 16)
                            
                            VStack {
                                if index == 0 {
                                        Spacer()
                                            .frame(height: 52)
                                        
                                        Image(uiImage: onboardingContent[index].image)
                                            .resizable()
                                            .frame(width: 293, height: 293)
                                            .padding(.horizontal, 50)
                                    
                                    
                                } else {
                                        Spacer()
                                            .frame(height: 125)
                                        
                                        Image(uiImage: onboardingContent[index].image)
                                            .resizable()
                                            .frame(height: 150)
                                        
                                        Spacer()
                                    
                                }
                                Spacer()
                            }
                        }
                    }
                    
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
                        .frame(height: 65)
                }
            }
            .ignoresSafeArea(edges: .vertical)
            .ignoresSafeArea(.keyboard)
            .setOnboardingHeyNavigation()
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

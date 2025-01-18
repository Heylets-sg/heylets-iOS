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

public struct OnboardingView: View {
    @EnvironmentObject var container: Router
    var viewModel: OnboardingViewModel
    
    let images: [UIImage] = [.timeTable, .color]
    
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
                    
                    Text("Add a personal schedule to\nyour school timetable")
                        .font(.bold_20)
                        .foregroundColor(.heyWhite)
                        .lineSpacing(3.5)
                        .padding(.bottom, 12)
                        .padding(.leading, 16)
                        .lineLimit(2)
                    
                    Text("Manage your school-related schedules\nall at once!")
                        .font(.medium_14)
                        .foregroundColor(.heyWhite)
                        .padding(.leading, 16)
                        .lineLimit(2)
                    
                    Spacer()
                        .frame(height: 52)
                    
                    CarouselView(pageCount: images.count, visibleEdgeSpace: 0, spacing: 0) { index in
                        Image(uiImage: images[index])
                            .resizable()
                            .scaledToFit()
                    }
                    .frame(height: 353)
                    .padding(.horizontal, 0)
                    
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
                        .frame(height: 65)
                }
            }
            .setOnboardingHeyNavigation()
        }
        .navigationBarBackButtonHidden()
    }
}



//#Preview {
//    OnboardingView(
//        viewModel: OnboardingViewModel(
//            navigationRouter: NavigationRoutableType()
//        )
//    )
//}

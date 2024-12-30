//
//  AddProfileVIew.swift
//  OnboardingFeature
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI
import BaseFeatureDependency

public struct AddProfileView: View {
    @EnvironmentObject var router: Router
    var viewModel: AddProfileViewModel
    
    public init(viewModel: AddProfileViewModel) {
        self.viewModel = viewModel
    }
    public var body: some View {
        OnboardingBaseView(content: {
            Spacer()
                .frame(height: 8)
            
            Text("How about a picture of a cute cat?")
                .font(.regular_16)
                .foregroundColor(.heyGray1)
                .padding(.bottom, 32)
            
            Button{
            } label: {
                ZStack {
                    Circle()
                        .fill(Color.heyGray4)
                        .frame(width: 136, height: 136)
                    
                    Image(systemName: "camera")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.black)
                }
            }
            .padding(.horizontal, 113)
            
        }, titleText: "Add profile picture", nextButtonAction: { viewModel.send(.nextButtonDidTap) })
    }
}

//#Preview {
//    AddProfileView()
//}

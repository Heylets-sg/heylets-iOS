//
//  AddProfileVIew.swift
//  OnboardingFeature
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI
import PhotosUI

import BaseFeatureDependency

public struct AddProfileView: View {
    @EnvironmentObject var container: DIContainer
    @ObservedObject var viewModel: AddProfileViewModel
    
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
            
            HStack {
                Spacer()
                HeyPhotoPicker(viewModel: viewModel) {
                    Image(uiImage: viewModel.profileImage ?? .icCamera)
                        .resizable()
                        .frame(width: 136, height: 136)
                        .background(Color.heyGray4)
                        .clipShape(Circle())
                }
                Spacer()
            }
            .frame(maxWidth: .infinity)
            
            
        }, titleText: "Add profile picture", nextButtonAction: { viewModel.send(.nextButtonDidTap) })
    }
}

public struct HeyPhotoPicker<Content: View>: View {
    @State private var selectedPhoto: PhotosPickerItem?
    private var viewModel: AddProfileViewModel
    private let matching: PHPickerFilter = .images
    private let content: () -> Content
    
    public init(
        viewModel: AddProfileViewModel,
        content: @escaping () -> Content
    ) {
        self.viewModel = viewModel
        self.content = content
    }
    
    public var body: some View {
        PhotosPicker(
            selection: $selectedPhoto,
            matching: matching
        ) {
            content()
        }
        .onChange(of: selectedPhoto) { newValue in
            viewModel.send(.profileImageDidChange(newValue))
            selectedPhoto = nil
        }
    }
}

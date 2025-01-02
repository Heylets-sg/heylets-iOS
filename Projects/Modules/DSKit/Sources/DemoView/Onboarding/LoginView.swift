//
//  AddProfileVIew.swift
//  OnboardingFeature
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI
//import BaseFeatureDependency

public struct AddProfileView: View {
    //    @EnvironmentObject var router: Router
    @State private var selectedImage: UIImage? // 선택된 이미지를 저장
    @State private var isPresentedError: Bool = false // 에러 발생 여부
    //    var viewModel: AddProfileViewModel
    //
    //    public init(viewModel: AddProfileViewModel) {
    //        self.viewModel = viewModel
    //    }
    public var body: some View {
        OnboardingBaseView(content: {
            Spacer()
                .frame(height: 8)
            
            Text("How about a picture of a cute cat?")
                .font(.regular_16)
                .foregroundColor(.heyGray1)
                .padding(.bottom, 32)
            
            GreenPhotoPicker(
                selectedImage: $selectedImage
            ) {
                Image(uiImage: selectedImage ?? .icPencil)
                    .resizable()
                    .frame(width: 136, height: 136)
                    .background(Color.heyGray4)
                    .clipShape(Circle())
                
            }
            .padding(.horizontal, 113)
            
        }, titleText: "Add profile picture")
    }
}

#Preview {
    AddProfileView()
}

import PhotosUI
import SwiftUI

public struct GreenPhotoPicker<Content: View>: View {
    @State private var selectedPhoto: PhotosPickerItem? // 단일 선택을 위해 변경
    @Binding private var selectedImage: UIImage? // UIImage도 단일로 변경
    @Binding private var isPresentedError: Bool
    private let matching: PHPickerFilter
    private let content: () -> Content
    
    public init(
        selectedImage: Binding<UIImage?>,
        isPresentedError: Binding<Bool> = .constant(false),
        matching: PHPickerFilter = .images,
        content: @escaping () -> Content
    ) {
        self._selectedImage = selectedImage
        self._isPresentedError = isPresentedError
        self.matching = matching
        self.content = content
    }
    
    public var body: some View {
        PhotosPicker(
            selection: $selectedPhoto, // 단일 선택을 위한 변경
            matching: matching
        ) {
            content()
        }
        .onChange(of: selectedPhoto) { newValue in
            print(newValue)
            handleSelectedPhoto(newValue)
        }
    }
    
    
    private func handleSelectedPhoto(_ newPhoto: PhotosPickerItem?) {
        guard let newPhoto = newPhoto else { return }
        
        newPhoto.loadTransferable(type: Data.self) { result in
            switch result {
            case .success(let data):
                if let data = data, let newImage = UIImage(data: data) {
                    DispatchQueue.main.async {
                        selectedImage = newImage // 선택된 이미지만 업데이트
                    }
                }
            case .failure:
                DispatchQueue.main.async {
                    isPresentedError = true
                }
            }
        }
        
        selectedPhoto = nil // 선택 완료 후 상태 초기화
    }
}



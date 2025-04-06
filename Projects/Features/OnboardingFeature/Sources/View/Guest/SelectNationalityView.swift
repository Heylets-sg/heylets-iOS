//
//  SelectNationalityView.swift
//  OnboardingFeature
//
//  Created by 류희재 on 3/19/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import SwiftUI

import BaseFeatureDependency
import Domain

struct SelectNationalityView: View {
    @EnvironmentObject var container: Router
    @ObservedObject var viewModel: SelectNationalityViewModel
    
    public init(viewModel: SelectNationalityViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Spacer()
                    Button {
                        viewModel.send(.closeButtonDidTap)
                    } label: {
                        Image(uiImage: .icClose)
                            .resizable()
                            .frame(width: 18, height: 18)
                    }
                }
                .padding(.bottom, 10.adjusted)
                
                HStack {
                    Text("Where did you live in?")
                        .font(.bold_20)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                .padding(.bottom, 36.adjusted)
                
                ForEach(viewModel.allNationalityItems, id: \.self) { nationality in
                    let isSelected = nationality == viewModel.nationality
                    HStack(spacing: 0) {
                        VStack {
                            if isSelected {
                                Image(uiImage: .icSelected)
                                    .resizable()
                                    .frame(width: 24.adjusted, height: 24.adjusted)
                            } else {
                                Circle()
                                    .fill(.clear)
                                    .frame(width: 24.adjusted, height: 24.adjusted)
                                    .overlay(Circle().stroke(Color.init(hex: "B8B8B8"), lineWidth: 2))
                                    
                            }
                        }
                        .padding(.leading, 20)
                        .padding(.vertical, 20.adjusted)
                        .padding(.trailing, 16)
                        
                        
                        Text("\(nationality.flag) \(nationality.rawValue)")
                            .font(.medium_16)
                            .foregroundColor(isSelected ? .heyGray1 : .heyGray2)
                        Spacer()
                    }
                    .frame(height: 64.adjusted)
                    .padding(.horizontal, 8)
                    .background(isSelected ? Color.init(hex: "EFF1FA") : Color.heyGray4)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(isSelected ? Color.heyMain : .clear , lineWidth: 2)
                    )
                    .onTapGesture {
                        viewModel.send(.selectNationality(nationality))
                    }
                    .padding(.bottom, 16.adjusted)
                }
                
                Spacer()
                
                Button("Continue") {
                    viewModel.send(.nextButtonDidTap)
                }
                .disabled(!viewModel.state.continueButtonIsEnabled)
                .heyBottomButtonStyle()
            }
            .padding(.top, 92.adjusted)
            .padding(.bottom, 65.adjusted)
        }
        .padding(.horizontal, 16)
        .background(Color.heyWhite)
        .ignoresSafeArea(edges: .vertical)
        .ignoresSafeArea(.keyboard)
        .navigationBarBackButtonHidden()
        .onAppear {
            viewModel.send(.onAppear)
        }
    }
}

#Preview {
    SelectNationalityView(
        viewModel: .init(
            navigationRouter: Router.default.navigationRouter,
            windowRouter: Router.default.windowRouter,
            useCase: StubHeyUseCase.stub.signUpUseCase
        )
    )
    .environmentObject(Router.default)
}


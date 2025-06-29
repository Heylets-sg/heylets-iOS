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
                        Image.icClose
                            .resizable()
                            .frame(width: 18, height: 18)
                            .tint(.Common.ButtonClose.default)
                    }
                }
                .padding(.bottom, 10.adjusted)
                
                HStack {
                    Text("Where did you live in?")
                        .font(.bold_20)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.common.MainText.default)
                    Spacer()
                }
                .padding(.bottom, 36.adjusted)
                
                ForEach(viewModel.allNationalityItems, id: \.self) { nationality in
                    let isSelected = nationality == viewModel.nationality
                    HStack(spacing: 0) {
                        VStack {
                            if isSelected {
                                Image.icCheck
                                    .resizable()
                                    .frame(width: 24.adjusted, height: 24.adjusted)
                                    .foregroundColor(.heyMain)
                            } else {
                                Image.icUnCheck
                                    .resizable()
                                    .frame(width: 24.adjusted, height: 24.adjusted)
                                    .foregroundColor(Color.init(hex: "#747474"))
                            }
                        }
                        .padding(.leading, 20)
                        .padding(.vertical, 20.adjusted)
                        .padding(.trailing, 16)
                        
                        
                        Text("\(nationality.flag) \(nationality.rawValue)")
                            .font(.medium_16)
                            .foregroundColor(
                                isSelected
                                ? .common.MainText.default
                                : .common.Placeholder.default
                            )
                        Spacer()
                    }
                    .frame(height: 64.adjusted)
                    .padding(.horizontal, 8)
                    .background(
                        isSelected 
                        ? Color.common.Button.active2
                        : Color.common.Button.unactive
                    )
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
                .heyCTAButtonStyle()
            }
            .padding(.top, 92.adjusted)
            .padding(.bottom, 65.adjusted)
        }
        .padding(.horizontal, 16)
        .background(Color.common.Background.default)
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


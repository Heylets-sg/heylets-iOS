//
//  MYSEnterPersonalInfoView.swift
//  OnboardingFeature
//
//  Created by 류희재 on 3/19/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import SwiftUI

import BaseFeatureDependency
import Domain
import DSKit

public struct MYSEnterPersonalInfoView: View {
    @EnvironmentObject var container: Router
    @ObservedObject var viewModel: MYSEnterPersonalInfoViewModel
    
    @State var showPassword = false
    @FocusState private var focusedField: Field?
    
    enum Field {
        case password
        case confirmPassword
        case birthDate
    }
    
    public init(viewModel: MYSEnterPersonalInfoViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        OnboardingBaseView(content: {
            Spacer()
                .frame(height: 16.adjusted)
            
            VStack(spacing: 16.adjusted) {
                PasswordField(
                    password: $viewModel.password,
                    showPassword: $showPassword,
                    textFieldState: $viewModel.state.passwordIsValid
                )
                .focused($focusedField, equals: .password)
                .submitLabel(.next)
                .onSubmit {
                    focusedField = .confirmPassword
                }
                
                SecurityPasswordField(
                    password: $viewModel.checkPassword,
                    placeHolder: "Confirm Password",
                    textFieldState: $viewModel.state.checkPasswordIsValid
                )
                .focused($focusedField, equals: .confirmPassword)
                .submitLabel(.next)
                .onSubmit {
                    focusedField = .birthDate
                }
            }
            
            Spacer()
                .frame(height: 40.adjusted)
            
            HStack(spacing: 16.adjusted) {
                ForEach(Gender.allCases, id: \.self) { gender in
                    GenderButton(
                        title: gender.title,
                        isSelected: gender == viewModel.gender,
                        action: {
                            viewModel.send(.genderButtonDidTap(gender))
                            // 성별 선택 시 키보드 숨기기
                            hideKeyboard()
                        }
                    )
                }
            }
            .padding(.trailing, 62)
            .padding(.bottom, 20.adjusted)
            
            HeyTextField(
                text: $viewModel.birthDate,
                placeHolder: "YYYY / MM / DD",
                textFieldState: $viewModel.state.birthDateIsValid
            )
            .keyboardType(.numberPad)
            .submitLabel(.done)
            .focused($focusedField, equals: .birthDate)
            .onSubmit {
                // 마지막 필드에서 완료 버튼을 누르면 키보드 숨기기
                hideKeyboard()
            }
        }, titleText: "Please enter your account\ninformation!",
           nextButtonIsEnabled: viewModel.state.continueButtonIsEnabled,
           nextButtonAction: {
               viewModel.send(.nextButtonDidTap)
               hideKeyboard()
           }
        )
        .onTapGesture {
            // 화면 터치 시 키보드 숨기기
            hideKeyboard()
        }
        // onAppear에서 첫 번째 필드에 포커스 설정
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                focusedField = .password
            }
        }
    }
    
    // 키보드 숨기는 함수
    private func hideKeyboard() {
        focusedField = nil
        endTextEditing()
    }
}

fileprivate struct GenderButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .frame(height: 56.adjusted)
                .frame(maxWidth: .infinity)
                .font(.semibold_14)
                .background(isSelected ? Color.common.CTA.active : Color.common.CTA.unactive)
                .foregroundColor(isSelected ? .common.CTAText.active : .common.CTAText.unactive)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}

#Preview {
    MYSEnterPersonalInfoView(
        viewModel: .init(
            navigationRouter: Router.default.navigationRouter,
            useCase: StubHeyUseCase.stub.signUpUseCase
        )
    )
    .environmentObject(Router.default)
}

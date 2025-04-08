//
//  VerifyEmailView.swift
//  OnboardingFeature
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

import BaseFeatureDependency
import Domain
import DSKit

public struct VerifyEmailView: View {
    @EnvironmentObject var container: Router
    @ObservedObject var viewModel: VerifyEmailViewModel

    @FocusState private var isFocused: Bool
    
    public init(viewModel: VerifyEmailViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        
        OnboardingBaseView(content: {
            Spacer()
                .frame(height: 18.adjusted)
            
            HStack {
                HeyTextField(
                    text: $viewModel.localPart,
                    placeHolder: "Enter your school email",
                    colorSystem: .gray
                )
                .focused($isFocused)
                .padding(.trailing, 12)
                
                Text("@")
                    .font(.regular_16)
                    .foregroundColor(.common.MainText.default)
            }
            .padding(.trailing, 47)
            .padding(.bottom, 18.adjusted)
            
            Button {
                viewModel.send(.domainListButtonDidTap)
            } label: {
                HStack {
                    Text(viewModel.domain.isEmpty
                         ? "Click DownList Button"
                         : viewModel.domain
                    )
                    .font(.medium_14)
                    .foregroundColor(
                        viewModel.domain.isEmpty
                        ? .common.Placeholder.default
                        : .common.MainText.default
                    )
                    
                    Spacer()
                    
                    Image(uiImage: .icDown)
                        .resizable()
                        .frame(width: 12, height: 6)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 17.adjusted)
                .background(Color.common.InputField.default)
            }
            
            .background(Color.heyGray4)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding(.trailing, 116)
            .padding(.bottom, 20.adjusted)
            
            Text(viewModel.state.errMessage)
                .font(.regular_14)
                .foregroundColor(.heyError)
            
            EmailDomainListView(viewModel: viewModel)
                .frame(maxHeight: 250.adjusted)
                .padding(.trailing, 116)
                .hidden(!viewModel.state.domainListViewIsVisible)
        },
       titleText: "Verify with your school email",
       nextButtonIsEnabled: viewModel.state.continueButtonIsEnabled,
       nextButtonAction: { viewModel.send(.nextButtonDidTap) } 
        )
        .onTapGesture {
            viewModel.send(.dismissFocus)
            isFocused = false
        }
        .ignoresSafeArea(edges: .vertical)
        .ignoresSafeArea(.keyboard)
    }
}

fileprivate struct EmailDomainListView: View {
    private var viewModel: VerifyEmailViewModel
    
    init(viewModel: VerifyEmailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(viewModel.nationality.domainList, id: \.self) { domain in
                    EmailDomainListCellView(domain)
                        .onTapGesture {
                            viewModel.send(.selectDomain(domain))
                        }
                }
            }
        }
        .background(Color.heyGray4)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

fileprivate struct EmailDomainListCellView: View {
    private let domain: String
    
    init(_ domain: String) {
        self.domain = domain
    }
    var body: some View {
        HStack {
            Text(domain)
                .font(.medium_14)
                .foregroundColor(.heyBlack)
            
            Spacer()
        }
        .padding(.vertical, 10.adjusted)
        .padding(.leading, 16)
    }
}

#Preview {
    VerifyEmailView(
        viewModel: .init(
            navigationRouter: Router.default.navigationRouter,
            useCase: StubHeyUseCase.stub.signUpUseCase,
            nationality: .Malaysia
        )
    )
    .environmentObject(Router.default)
    .preferredColorScheme(.dark)
}



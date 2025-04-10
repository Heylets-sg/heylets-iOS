//
//  TermsOfServiceView.swift
//  OnboardingFeature
//
//  Created by 류희재 on 2/18/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import SwiftUI

import BaseFeatureDependency
import Domain

struct TermsOfServiceView: View {
    @EnvironmentObject var container: Router
    @ObservedObject var viewModel: TermsOfServiceViewModel
    
    public init(viewModel: TermsOfServiceViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    VStack(alignment:. leading) {
                        Image(uiImage: .logo)
                            .resizable()
                            .frame(width: 95.adjusted, height: 49.adjusted)
                        
                        Text("Terms of Service")
                            .font(.bold_20)
                            .foregroundColor(.common.MainText.default)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 22)
                .padding(.bottom, 41.adjusted)
                
                HStack(alignment: .center, spacing: 12) { // spacing 추가
                    Image(uiImage: viewModel.state.allAgree ? .icSelected : .icCheck)
                        .resizable()
                        .frame(width: 24.adjusted, height: 24.adjusted)
                    
                    Text("Agree to all")
                        .font(.semibold_16)
                        .foregroundColor(.common.MainText.default)
                    
                    Spacer()
                }
                .onTapGesture {
                    viewModel.send(.allAgreeButtonDidTap)
                }
                .padding(.bottom, 18.adjusted)
                .padding(.horizontal, 22)
                
                Rectangle()
                    .fill(Color.common.Divider.default)
                    .frame(height: 1)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 30.adjusted)
                
                
                HStack {
                    Image(uiImage: .icSuccess)
                        .resizable()
                        .frame(width: 16.adjusted, height: 10.adjusted)
                        .foregroundColor(
                            viewModel.state.termsOfServiceIsAgree
                            ? .common.Check.active
                            : .common.Check.unactive
                        )
                        .padding(.trailing, 12)
                        .onTapGesture {
                            viewModel.send(.termsOfServiceDidTap)
                        }
                    
                    Text("Agree to the Terms of Service.(required)")
                        .font(.regular_14)
                        .foregroundColor(.common.SubText.default)
                    
                    Spacer()
                    
                    Link(destination: URL(string: Website.TermsOfService)!) {
                        HStack {
                            Text("View")
                                .font(.regular_12)
                                .foregroundColor(.common.Placeholder.default)
                        }
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 20.adjusted)
                
                
                HStack {
                    Image(uiImage: .icSuccess)
                        .resizable()
                        .frame(width: 16.adjusted, height: 10.adjusted)
                        .foregroundColor(
                            viewModel.state.termsOfServiceIsAgree
                            ? .common.Check.active
                            : .common.Check.unactive
                        )
                        .padding(.trailing, 12)
                        .onTapGesture {
                            viewModel.send(.personalInformationDidTap)
                        }
                    
                    Text("Agree to the collection and use of\npersonal information.(required)")
                        .multilineTextAlignment(.leading)
                        .font(.regular_14)
                        .foregroundColor(.common.SubText.default)
                    
                    Spacer()
                    
                    
                    Link(destination: URL(string: Website.PrivacyPolicy)!) {
                        HStack {
                            Text("View")
                                .font(.regular_12)
                                .foregroundColor(.common.Placeholder.default)
                        }
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 20.adjusted)
                
                
                HStack {
                    Image(uiImage: .icSuccess)
                        .resizable()
                        .frame(width: 16.adjusted, height: 10.adjusted)
                        .foregroundColor(
                            viewModel.state.termsOfServiceIsAgree
                            ? .common.Check.active
                            : .common.Check.unactive
                        )
                        .padding(.trailing, 12)
                        .onTapGesture {
                            viewModel.send(.marketingDidTap)
                        }
                    
                    Text("Agree to receive ads and marketing communications.")
                        .multilineTextAlignment(.leading)
                        .font(.regular_14)
                        .foregroundColor(.common.SubText.default)
                    
                    Spacer()
                    
                    
                    Link(destination: URL(string: "https://melon-pawpaw-a40.notion.site/Marketing-Consent-for-Email-Communication-1b4bef466352819dab2df02918a53e50")!) {
                        HStack {
                            Text("View")
                                .font(.regular_12)
                                .foregroundColor(.common.Placeholder.default)
                        }
                    }
                }
                .padding(.horizontal, 24)
                
                Text(viewModel.state.errMessage)
                    .font(.title)
                    .foregroundColor(.common.Error.default)
                
                Spacer()
                
                Button("Agree") {
                    viewModel.send(.agreeButtonDidTap)
                }
                .disabled(!viewModel.state.continueButtonIsEnabled)
                .heyCTAButtonStyle()
                .padding(.horizontal, 16)
            }
            
            .padding(.top, 126.adjusted)
            .padding(.bottom, 65.adjusted)
        }
        .background(Color.common.Background.default)
        .ignoresSafeArea(edges: .vertical)
        .ignoresSafeArea(.keyboard)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    TermsOfServiceView(viewModel: .init(
        navigationRouter: Router.default.navigationRouter,
        windowRouter: Router.default.windowRouter, 
        useCase: StubHeyUseCase.stub.signUpUseCase,
        university: UniversityInfo.empty
    ))
    .environmentObject(Router.default)
    .preferredColorScheme(.dark)
}

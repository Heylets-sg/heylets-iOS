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
                            .frame(width: 95, height: 49)
                        
                        Text("Terms of Service")
                            .font(.bold_20)
                    }

                    Spacer()
                }
                .padding(.horizontal, 22)
                .padding(.bottom, 41)
                
                HStack(alignment: .center, spacing: 12) { // spacing 추가
                    Image(uiImage: viewModel.state.allAgree ? .icSelected : .icCheck)
                        .resizable()
                        .frame(width: 24, height: 24)

                    Text("Agree to all")
                        .font(.semibold_16)
                        .foregroundColor(.heyGray1)
                    
                    Spacer()
                }
                .onTapGesture {
                    viewModel.send(.allAgreeButtonDidTap)
                }
                .padding(.bottom, 18)
                .padding(.horizontal, 22)
                
                Rectangle()
                    .fill(Color.heyGray4)
                    .frame(height: 1)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 30)
                    
                
                HStack {
                    Image(uiImage: .icSuccess.withRenderingMode(.alwaysTemplate))
                        .resizable()
                        .frame(width: 16, height: 10)
                        .foregroundStyle(viewModel.state.termsOfServiceIsAgree ? Color.heyMain : Color.init(hex: "#B8B8B8"))
                        .padding(.trailing, 12)
                        .onTapGesture {
                            viewModel.send(.termsOfServiceDidTap)
                        }

                    Text("Agree to the Terms of Service.(required)")
                        .font(.regular_14)
                        .foregroundColor(.heyGray2)
                    
                    Spacer()
                    
                    Link(destination: URL(string: "https://melon-pawpaw-a40.notion.site/Terms-of-Use-182bef4663528047952ed03e0dd22100")!) {
                                HStack {
                                    Text("View")
                                        .font(.regular_12)
                                        .foregroundColor(Color.init(hex: "#B8B8B8"))
                                } .foregroundColor(.black)
                            }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 20)
                
                
                HStack {
                    Image(uiImage: .icSuccess.withRenderingMode(.alwaysTemplate))
                        .resizable()
                        .frame(width: 16, height: 10)
                        .foregroundStyle(viewModel.state.personalInformationIsAgree ? Color.heyMain : Color.init(hex: "#B8B8B8"))
                        .padding(.trailing, 12)
                        .onTapGesture {
                            viewModel.send(.personalInformationDidTap)
                        }

                    Text("Agree to the collection and use of\npersonal information.(required)")
                        .multilineTextAlignment(.leading)
                        .font(.regular_14)
                        .foregroundColor(.heyGray2)
                    
                    Spacer()
                
                    
                    Link(destination: URL(string: "https://melon-pawpaw-a40.notion.site/Privacy-Policy-21-01-2025-182bef46635280e69384d760997c940e")!) {
                                HStack {
                                    Text("View")
                                        .font(.regular_12)
                                        .foregroundColor(Color.init(hex: "#B8B8B8"))
                                } .foregroundColor(.black)
                            }
                }
                .padding(.horizontal, 24)
                
                Text(viewModel.state.errMessage)
                    .font(.title)
                    .foregroundColor(.red)
                
                Spacer()
                
                Button("Agree") {
                    viewModel.send(.agreeButtonDidTap)
                }
                .disabled(!viewModel.state.allAgree)
                .heyBottomButtonStyle()
                .padding(.horizontal, 16)
            }
            
            .padding(.top, 126)
            .padding(.bottom, 65)
        }
        .background(Color.heyWhite)
        .ignoresSafeArea(edges: .vertical)
        .ignoresSafeArea(.keyboard)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    TermsOfServiceView(viewModel: .init(
        navigationRouter: Router.default.navigationRouter,
        windowRouter: Router.default.windowRouter, 
        useCase: StubHeyUseCase.stub.onboardingUseCase,
        university: ""
    ))
    .environmentObject(Router.default)
}

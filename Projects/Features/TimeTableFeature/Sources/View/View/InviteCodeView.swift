//
//  InviteCodeView.swift
//  TimeTableFeature
//
//  Created by 류희재 on 3/20/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

import SwiftUI

import BaseFeatureDependency
import Domain
import DSKit
import Core


public struct InviteCodeView: View {
    @EnvironmentObject var container: Router
    @ObservedObject var viewModel: InviteCodeViewModel
    
    public init(
        viewModel: InviteCodeViewModel
    ) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        
        ZStack {
            VStack(alignment: .leading) {
                
                Spacer()
                    .frame(height: 92.adjusted)
                
                Button {
                    viewModel.send(.backButtonDidTap)
                } label: {
                    Image.icBack
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 22, height: 18)
                        .tint(.common.ButtonBack.default)
                }
                
                VStack(alignment: .leading) {
                    Text("Invite a friend and get\ntimetable themes together🎉")
                        .font(.semibold_18)
                        .foregroundColor(.common.MainText.default)
                        .padding(.bottom, 8.adjusted)
                    
                    Text("When a friend signs up using your code, ")
                        .font(.regular_16)
                        .foregroundColor(.common.SubText.default)
                    
                    Text("they get 3 random themes, and you get 2")
                        .font(.regular_16)
                        .foregroundColor(.heyMain)
                    
                    Spacer()
                        .frame(height: 126.adjusted)
                    
                    HStack {
                        Spacer()
                        VStack {
                            Text("My invite code")
                                .foregroundColor(.common.SubText.default)
                                .padding(.vertical, 12.adjusted)
                                .padding(.horizontal, 80.adjusted)
                                .background(Color.heyMain)
                            
                            HStack {
                                Text(viewModel.referralCode)
                                    .font(.medium_30)
                                    .foregroundColor(.common.MainText.default)
                                    .kerning(10)
                                
                                Button {
                                    viewModel.send(.copyButtonDidTap)
                                } label: {
                                    Image.icCopy
                                        .resizable()
                                        .frame(width: 11, height: 11)
                                        .tint(Color.setting.copyIcon)
                                        .padding(.all, 7)
                                        .background(Color.setting.copyButton)
                                        .clipShape(RoundedRectangle(cornerRadius: 3))
                                }
                                
                            }
                            .padding(.vertical, 30.adjusted)
                        }
                        .background(Color.popup.default)
                        .clipShape(RoundedRectangle(cornerRadius: 7))
                        .overlay(
                            RoundedRectangle(cornerRadius: 7)
                                .stroke(Color.setting.inviteBox, lineWidth: 1)
                        )
                        Spacer()
                    }
                    
                    .padding(.horizontal, 20)
                    
                    
                    Spacer()
                    
                    ShareLink(
                        item: viewModel.shareText
                    ) {
                        HStack {
                            Text("Share my code")
                                .font(.semibold_14)
                                .foregroundStyle(Color.common.CTAText.active)
                        }
                        .frame(height: 56)
                        .frame(maxWidth: .infinity)
                        .background(Color.common.CTA.active)
                        .clipShape(RoundedRectangle(cornerRadius: 28))
                    }
                    .onTapGesture {
                        Analytics.shared.track(.clickShareReferralCode)
                    }
                }
                .padding(.top, 36.adjusted)
                .padding(.bottom, 65.adjusted)
            }
            .setTimeTableHeyNavigation()
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
}

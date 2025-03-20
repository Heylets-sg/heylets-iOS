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

extension Notification.Name {
    static let timeTableViewTypeChanged = Notification.Name("TimeTableViewTypeChanged")
}

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
                    .frame(height: 92)
                
                Button {
                    viewModel.send(.backButtonDidTap)
                } label: {
                    Image(uiImage: .icBack)
                        .resizable()
                        .frame(width: 22, height: 18)
                }
                
                VStack(alignment: .leading) {
                    Text("Invite a friend and get\ntimetable themes together🎉")
                        .font(.semibold_18)
                        .foregroundColor(.heyGray1)
                        .padding(.bottom, 8)
                    
                    Text("When a friend signs up using your code, ")
                        .font(.regular_16)
                    
                    Text("they get 3 random themes, and you get 2")
                        .font(.regular_16)
                    
                    Spacer()
                        .frame(height: 126)
                    
                    HStack {
                        Spacer()
                        VStack {
                            Text("My invite code")
                                .padding(.vertical, 12)
                                .padding(.horizontal, 90)
                                .background(Color.heyMain)
                            
                            HStack {
                                Text("468J2K")
                                    .font(.medium_30)
                                    .foregroundColor(.heyBlack)
                                    .kerning(10)
                                
                                Button {
                                    viewModel.send(.copyButtonDidTap)
                                } label: {
                                    Image(uiImage: .icCopy)
                                        .resizable()
                                        .frame(width: 11, height: 11)
                                        .padding(.all, 7)
                                        .background(Color.heyGray3)
                                        .clipShape(RoundedRectangle(cornerRadius: 3))
                                }
                                
                            }
                            .padding(.vertical, 30)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 7))
                        .overlay(
                            RoundedRectangle(cornerRadius: 7)
                                .stroke(Color.heyMain, lineWidth: 1)
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
                                .foregroundStyle(Color.heyWhite)
                        }
                        .frame(height: 56)
                        .frame(maxWidth: .infinity)
                        .background(Color.heyMain)
                        .clipShape(RoundedRectangle(cornerRadius: 28))
                    }
                }
                .padding(.top, 36)
                .padding(.bottom, 65)
            }
            .setTimeTableHeyNavigation()
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
}


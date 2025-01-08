//
//  MyPage.swift
//  MyPageFeature
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

import DSKit
import BaseFeatureDependency

public struct MyPageView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var myPageRouter: MyPageNavigationRouter
    @ObservedObject var viewModel: MyPageViewModel
    
    public init(viewModel: MyPageViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        NavigationStack(path: $myPageRouter.destinations) {
            ZStack {
                Color.heyMain
                
                VStack {
                    Spacer()
                        .frame(height: 60)
                    
                    MyPageTopView()
                        .environmentObject(router)
                    
                    VStack {
                        Spacer()
                            .frame(height:90)
                        
                        VStack {
                            Text("Heidi109 / NUS")
                                .font(.medium_16)
                                .foregroundColor(Color.heyBlack)
                                .padding(.top, 44)
                                .padding(.bottom, 32)
                            
                            ScrollView {
                                VStack(spacing: 24) {
                                    AccountView(viewModel: viewModel)
                                    
                                    SupportView(viewModel: viewModel)
                                    
                                    AppSettingView(viewModel: viewModel)
                                    
                                    EtcView(viewModel: viewModel)
                                }
                                
                                
                                Spacer()
                            }
                            .scrollIndicators(.hidden)
                        }
                        .padding(.horizontal, 16)
                        .background(Color.heyWhite)
                        .cornerRadius(24, corners: [.topLeft, .topRight])
                    }
                    
                    Spacer()
                }
                
                VStack {
                    Image(uiImage: .icSchool)
                        .resizable()
                        .frame(width: 80, height: 80)
                        .background(Color.heyWhite)
                        .clipShape(Circle())
                        .padding(.top, 125)
                    
                    Spacer()
                }
            }
            .ignoresSafeArea(edges: .vertical)
            .ignoresSafeArea(.keyboard)
            .setMyPageNavigation()
        }
        .navigationBarBackButtonHidden()
        .heyAlert(
            isPresented: viewModel.state.logoutAlertViewIsPresented,
            title: "Are you sure you want\nto logout?",
            primaryButton: ("Close", .gray, {
                viewModel.send(.dismissLogoutAlertView)
            }),
            secondaryButton: ("Ok", .primary, {
                viewModel.send(.logout)
            })
        )
    }
}

public struct MyPageTopView: View {
    @EnvironmentObject var router: Router
    public var body: some View {
        HStack {
            Button {
                router.windowRouter.switch(to: .timetable)
            } label: {
                Image(uiImage: .icBack.withRenderingMode(.alwaysTemplate))
                    .resizable()
                    .frame(width: 22, height: 18)
                    .tint(.white)
            }
            .padding(.leading, 16)
            
            Spacer()
            
            Text("My account")
                .font(.semibold_18)
                .foregroundColor(.white)
            
            Spacer()
        }
    }
}

public struct AccountView: View {
    @ObservedObject private var viewModel: MyPageViewModel
    
    fileprivate init(viewModel: MyPageViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Account")
                        .font(.semibold_16)
                        .foregroundColor(.heyGray1)
                    
                    Button {
                        viewModel.send(.changePasswordButtonDidTap)
                    } label: {
                        Text("Change password")
                            .font(.regular_14)
                            .foregroundColor(.heyGray1)
                    }
                    
                    Text("Change User ID")
                        .font(.regular_14)
                        .foregroundColor(.heyGray1)
                    
                }
                .padding(.leading, 20)
                .padding(.vertical, 20)
                
                Spacer()
            }
            
        }
        .background(Color.heyGray5)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

public struct SupportView: View {
    @ObservedObject private var viewModel: MyPageViewModel
    
    fileprivate init(viewModel: MyPageViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Support")
                        .font(.semibold_16)
                        .foregroundColor(.heyGray1)
                    
                    Button {
                        viewModel.send(.privacyPolicyButtonDidTap)
                    } label: {
                        Text("Privacy policy")
                            .font(.regular_14)
                            .foregroundColor(.heyGray1)
                    }
                    
                    Button {
                        viewModel.send(.termsOfServiceButtonDidTap)
                    } label: {
                        Text("Terms of service")
                            .font(.regular_14)
                            .foregroundColor(.heyGray1)
                    }
                    
                    Button {
                        viewModel.send(.contactUsButtonDidTap)
                    } label: {
                        Text("Contact us")
                            .font(.regular_14)
                            .foregroundColor(.heyGray1)
                    }
                }
                .padding(.leading, 20)
                .padding(.vertical, 20)
                
                Spacer()
            }
            
        }
        .background(Color.heyGray5)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

public struct AppSettingView: View {
    @ObservedObject private var viewModel: MyPageViewModel
    
    fileprivate init(viewModel: MyPageViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Account")
                        .font(.semibold_16)
                        .foregroundColor(.heyGray1)
                    
                    Button {
                        viewModel.send(.notificationSettingButtonDidTap)
                    } label: {
                        Text("Notification setting")
                            .font(.regular_14)
                            .foregroundColor(.heyGray1)
                    }
                }
                .padding(.leading, 20)
                .padding(.vertical, 20)
                
                Spacer()
            }
            
        }
        .background(Color.heyGray5)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

public struct EtcView: View {
    @ObservedObject private var viewModel: MyPageViewModel
    
    fileprivate init(viewModel: MyPageViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Etc")
                        .font(.semibold_16)
                        .foregroundColor(.heyGray1)
                    
                    Button {
                        viewModel.send(.deleteAccountButtonDidTap)
                    } label: {
                        Text("Delete account")
                            .font(.regular_14)
                            .foregroundColor(.heyGray1)
                    }
                    
                    Button {
                        viewModel.send(.logoutButtonDidTap)
                    } label: {
                        Text("Log out")
                            .font(.regular_14)
                            .foregroundColor(.heyGray1)
                    }
                }
                .padding(.leading, 20)
                .padding(.vertical, 20)
                
                Spacer()
            }
            
        }
        .background(Color.heyGray5)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

//#Preview {
//    MyPageView()
//}

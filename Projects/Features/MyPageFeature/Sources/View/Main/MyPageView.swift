//
//  MyPage.swift
//  MyPageFeature
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

import DSKit
import Domain
import BaseFeatureDependency
import Core

public struct MyPageView: View {
    @EnvironmentObject var container: Router
    @ObservedObject var viewModel: MyPageViewModel
    
    public init(viewModel: MyPageViewModel) {
        self.viewModel = viewModel
        
        viewModel.send(.onAppear)
    }
    
    public var body: some View {
        NavigationStack(path: $container.navigationRouter.destinations) {
            ZStack {
                Color.heyMain
                
                VStack {
                    Spacer()
                        .frame(height: 60.adjusted)
                    
                    MyPageTopView()
                        .environmentObject(container)
                    
                    VStack {
                        Spacer()
                            .frame(height:90.adjusted)
                        
                        VStack {
                            Text("\(viewModel.profileInfo.nickName) / \(viewModel.profileInfo.university.rawValue)")
                                .font(.medium_16)
                                .foregroundColor(Color.heyBlack)
                                .padding(.top, 44.adjusted)
                                .padding(.bottom, 12.adjusted)
                                .hidden(viewModel.state.isLoading)
                                .loading(viewModel.state.isLoading)
                            
                            if !viewModel.state.referralCodeViewHidden {
                                MyReferalCodeView(viewModel.referralCode)
                                    .onTapGesture {
                                        viewModel.send(.copyReferralCodeButtonDidTap)
                                    }
                            }
                            
                            
                            if viewModel.isGuestMode {
                                MyPageGuestView(viewModel: viewModel)
                            } else {
                                MyPageContentView(viewModel: viewModel)
                            }
                        }
                        .padding(.horizontal, 16)
                        .background(Color.heyWhite)
                        .cornerRadius(24, corners: [.topLeft, .topRight])
                    }
                }
                
                VStack {
                    if let imageURL = viewModel.profileInfo.imageURL {
                        AsyncImage(url: URL(string: imageURL)) { image in
                            image
                                .resizable()
                                .frame(width: 80, height: 80)
                                .background(Color.heyWhite)
                                .clipShape(Circle())
                                .padding(.top, 125.adjusted)
                        } placeholder: {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                        }
                    } else {
                        Circle()
                            .fill(Color.heyBlack)
                            .frame(width: 80, height: 80)
                            .padding(.top, 125.adjusted)
                    }
                    
                    Spacer()
                }
            }
            .onAppear {
                viewModel.send(.onAppear)
            }
            .ignoresSafeArea(edges: .vertical)
            .ignoresSafeArea(.keyboard)
            .setMypageNavigation()
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
        .onAppear {
            Analytics.shared.track(.screenView("log_out", .modal))
        }
    }
}

public struct MyPageTopView: View {
    @EnvironmentObject var router: Router
    public var body: some View {
        ZStack {
            HStack {
                Spacer()
                
                Text("My account")
                    .font(.semibold_18)
                    .foregroundColor(.white)
                
                Spacer()
            }
            
            HStack {
                Button {
                    router.windowRouter.goBack()
                } label: {
                    Image(uiImage: .icBack.withRenderingMode(.alwaysTemplate))
                        .resizable()
                        .frame(width: 24, height: 20)
                        .tint(.white)
                }
                .padding(.leading, 16)
                Spacer()
            }
            
        }
        
    }
}

public struct MyReferalCodeView: View {
    private var code: String?
    
    public init(_ code: String?) {
        self.code = code
    }
    public var body: some View {
        if let code {
            HStack {
                Text("Referal code   \(code)")
                    .font(.regular_12)
                    .padding(.trailing, 12)
                
                Image(uiImage: .icCopy)
                    .resizable()
                    .frame(width: 12, height: 12)
            }
            .padding(.vertical, 8.adjusted)
            .padding(.horizontal, 34)
            .clipShape(Capsule())
            .padding(.bottom, 30.adjusted)
        } else {
            Spacer()
                .frame(height: 60.adjusted)
        }
    }
}



#Preview {
    MyPageView(
        viewModel: .init(
            navigationRouter: Router.default.navigationRouter,
            windowRouter: Router.default.windowRouter,
            useCase: StubHeyUseCase.stub.myPageUseCase
            //            profileInfo: .init()
        )
    )
    .environmentObject(Router.default)
}

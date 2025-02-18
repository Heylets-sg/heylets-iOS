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

public struct MyPageView: View {
    @EnvironmentObject var container: Router
    @ObservedObject var viewModel: MyPageViewModel
    
    public init(viewModel: MyPageViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        NavigationStack(path: $container.navigationRouter.destinations) {
            ZStack {
                Color.heyMain
                
                VStack {
                    Spacer()
                        .frame(height: 60)
                    
                    MyPageTopView()
                        .environmentObject(container)
                    
                    VStack {
                        Spacer()
                            .frame(height:90)
                        
                        VStack {
                            Text("\(viewModel.profileInfo.nickName) / \(viewModel.profileInfo.university)")
                                .font(.medium_16)
                                .foregroundColor(Color.heyBlack)
                                .padding(.top, 44)
                                .padding(.bottom, 32)
                            
                            MyPageContentView(viewModel: viewModel)
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
                                .padding(.top, 125)
                        } placeholder: {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                        }
                    } else {
                        Circle()
                            .fill(Color.heyBlack)
                            .frame(width: 80, height: 80)
                            .padding(.top, 125)
                    }
                    
                    Spacer()
                }
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
                    router.windowRouter.switch(to: .timetable)
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



#Preview {
    MyPageView(
        viewModel: .init(
            navigationRouter: Router.default.navigationRouter,
            windowRouter: Router.default.windowRouter,
            useCase: StubHeyUseCase.stub.myPageUseCase,
            profileInfo: .init()
        )
    )
    .environmentObject(Router.default)
}

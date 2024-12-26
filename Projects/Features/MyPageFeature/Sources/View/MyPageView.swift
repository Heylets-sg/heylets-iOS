//
//  MyPage.swift
//  MyPageFeature
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

import DSKit
public struct MyPageView: View {
    public init() {}
    
    public var body: some View {
        ZStack {
            Color.heyMain.ignoresSafeArea()
            
            VStack(alignment: .leading) {
                Spacer()
                    .frame(height: 58)
                
                MyPageTopView()
                
                VStack {
                    Spacer()
                        .frame(height:90)
                    
                    VStack {
                        Text("Heidi109 / NUS")
                            .font(.medium_16)
                            .foregroundColor(Color.heyBlack)
                            .padding(.top, 44)
                            .padding(.bottom, 32)
                        
                        VStack(spacing: 24) {
                            AccountView()
                            
                            SupportView()
                            
                            AppSettingView()
                            
                            Spacer()
                            
                        }
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
        .navigationBarBackButtonHidden()
    }
}

public struct MyPageTopView: View {
    public var body: some View {
        HStack {
            Button {
                //                        dismiss()
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
    public var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Account")
                        .font(.semibold_16)
                        .foregroundColor(.heyGray1)
                    
                    Text("Change password")
                        .font(.regular_14)
                        .foregroundColor(.heyGray1)
                    
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
    public var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Support")
                        .font(.semibold_16)
                        .foregroundColor(.heyGray1)
                    
                    Text("Privacy policy")
                        .font(.regular_14)
                        .foregroundColor(.heyGray1)
                    
                    Text("Terms of service")
                        .font(.regular_14)
                        .foregroundColor(.heyGray1)
                    
                    Text("Contact us")
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

public struct AppSettingView: View {
    public var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Account")
                        .font(.semibold_16)
                        .foregroundColor(.heyGray1)
                    
                    Text("Notification setting")
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

#Preview {
    MyPageView()
}

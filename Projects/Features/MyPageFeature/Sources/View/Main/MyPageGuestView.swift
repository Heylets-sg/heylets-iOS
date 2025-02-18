//
//  MyPageGuestView.swift
//  MyPageFeature
//
//  Created by 류희재 on 2/18/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import SwiftUI

struct MyPageGuestView: View {
    @ObservedObject var viewModel: MyPageViewModel
    
    public init(viewModel: MyPageViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 24) {
            GuestAccountView(viewModel: viewModel)
            
            SupportView(viewModel: viewModel)
            
            Spacer()
        }
    }
}

public struct GuestAccountView: View {
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
                        viewModel.send(.signUpLogInButtonDidTap)
                    } label: {
                        Text("Sign up / Log in")
                            .font(.regular_14)
                            .foregroundColor(.heyGray1)
                    }
                    
                    Button {
                        viewModel.send(.editSchoolButtonDidTap)
                    } label: {
                        Text("Edit School")
                            .font(.regular_14)
                            .foregroundColor(.heyGray1)
                    }
                    
                }
                .padding(.leading, 20)
                .padding(.vertical, 20)
                
                Spacer()
            }
            
        }
        .background(Color.heyGray4)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

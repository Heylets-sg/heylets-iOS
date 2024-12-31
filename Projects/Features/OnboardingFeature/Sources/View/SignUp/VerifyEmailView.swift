//
//  VerifyEmailView.swift
//  OnboardingFeature
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

import BaseFeatureDependency
import DSKit

public struct VerifyEmailView: View {
    @EnvironmentObject var router: Router
    @ObservedObject var viewModel: VerifyEmailViewModel
    
    public init(viewModel: VerifyEmailViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        OnboardingBaseView(content: {
            Spacer()
                .frame(height: 18)
            
            HStack {
                HeyTextField(
                    text: $viewModel.localPart,
                    placeHolder: "Enter your school email",
//                    textFieldState: .idle,
                    colorSystem: .gray
                )
                .padding(.trailing, 12)
                
                Text("@")
                    .font(.regular_16)
                    .foregroundColor(.heyGray1)
            }
            .padding(.trailing, 47)
            .padding(.bottom, 18)
            
            HStack {
                HeyTextField(
                    text: $viewModel.domain,
                    placeHolder: "Click DownList Button",
//                    textFieldState: .idle,
                    colorSystem: .gray
                )
                .padding(.trailing, 16)
                
                Button {
                    viewModel.send(.domainListButtonDidTap)
                } label: {
                    Image(uiImage: .icDown)
                        .resizable()
                        .frame(width: 12, height: 6)
                }
                .padding(.trailing, 16)
            }
            .background(Color.heyGray4)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding(.trailing, 116)
            
            EmailDomainListView(viewModel: viewModel)
                .frame(height: 250)
                .padding(.trailing, 116)
                .hidden(!viewModel.state.domainListViewIsVisible)
            
            
        },titleText: "Verify with your school email", nextButtonAction: { viewModel.send(.nextButtonDidTap)
        })
    }
}

fileprivate struct EmailDomainListView: View {
    private var viewModel: VerifyEmailViewModel
    
    init(viewModel: VerifyEmailViewModel) {
        self.viewModel = viewModel
    }
    var domainList: [String] = [
        "u.nus.edu",
        "e.ntu.edu.sg",
        "smu.edu.sg",
        "accountancy.smu.edu.sg",
        "computing.smu.edu.sg",
        "economics.smu.edu.sg",
        "scis.smu.edu.sg",
        "law.smu.edu.sg",
        "business.edu.sg",
        "socsc.smu.edu.sg",
        "business.smu.edu.sg"
    ]
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(domainList, id: \.self) { domain in
                    EmailDomainListCellView(domain)
                        .onTapGesture {
                            viewModel.send(.selectDomain(domain))
                        }
                }
            }
            .cornerRadius(8)
        }
        .background(Color.heyGray4)
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
        .padding(.vertical, 10)
        .padding(.leading, 16)
    }
}
//#Preview {
//    VerifyEmailView()
//}



//
//  DeleteAccountView.swift
//  MyPageFeature
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

import DSKit
import Domain
import BaseFeatureDependency

public struct DeleteAccountView: View {
    @EnvironmentObject var container: Router
    @ObservedObject var viewModel: DeleteAccountViewModel
    
    public init(viewModel: DeleteAccountViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        MyPageBaseView(content: {
            VStack(alignment: .leading) {
                Text("Account password")
                    .font(.medium_16)
                    .foregroundColor(.common.MainText.default)
                    .padding(.top, 36)
                
                HeyTextField(
                    text: $viewModel.password,
                    placeHolder: "Account password",
                    colorSystem: .gray
                )
                .padding(.top, 8)
                
                Spacer()
                
                Button("Delete account"){
                    viewModel.send(.deleteAccountButtonDidTap)
                }.heyCTAButtonStyle()
                
                Spacer()
                    .frame(height: 65)
            }
        }, titleText: "Delete account")
        .heyAlert(
            isPresented: viewModel.state.deleteAccountAlertViewIsPresented,
            title: "Are you sure you want\nto delete account?",
            primaryButton: (
                "Close",
                .primary,
                { viewModel.send(.dismissDeleteAccountAlertView) }
            ),
            secondaryButton: (
                "Ok",
                .gray,
                { viewModel.send(.deleteAccount) }
            )
        )
        .heyAlert(
            isPresented: viewModel.state.inValidPasswordAlertViewIsPresented,
            title: "The password is not correct.\nplease try again.",
            primaryButton: (
                "Ok",
                .gray,
                { viewModel.send(.dismissInValidPasswordAlertView) }
            )
        )
    }
}

#Preview {
    DeleteAccountView(
        viewModel: .init(
            useCase: StubHeyUseCase.stub.myPageUseCase, navigationRouter: Router.default.navigationRouter,
            windowRouter: Router.default.windowRouter
        )
    )
    .environmentObject(Router.default)
}

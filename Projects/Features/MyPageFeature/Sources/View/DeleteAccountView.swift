//
//  DeleteAccountView.swift
//  MyPageFeature
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

import DSKit

public struct DeleteAccountView: View {
    @State var text = ""
    @State var deleteAccountAlertViewIsPresented: Bool = false
    @State var inValidPasswordAlertViewIsPresented: Bool = false
    public var body: some View {
        MyPageBaseView(content: {
            VStack(alignment: .leading) {
                Text("Account password")
                    .font(.medium_14)
                    .foregroundColor(.heyGray1)
                    .padding(.top, 36)
                
                HeyTextField(text: $text, placeHolder: "Account password")
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.heyGray3, lineWidth: 1)
                    )
                    .padding(.top, 8)
                
                Spacer()
                
                Button("Delete account"){
                    deleteAccountAlertViewIsPresented = true
                }.heyBottomButtonStyle(.primary)
                
                Spacer()
                    .frame(height: 65)
            }
            .heyAlert(
                isPresented: deleteAccountAlertViewIsPresented,
                title: "Are you sure you want\nto delete account?",
                primaryButton: ("Close", .gray, {
                    deleteAccountAlertViewIsPresented = false
                }),
                secondaryButton: ("Ok", .primary, {
                    //회원탈퇴 로직 구현
                })
            )
            .heyAlert(
                isPresented: inValidPasswordAlertViewIsPresented,
                title: "The password is not correct.\nplease try again.",
                primaryButton: ("Ok", .gray, {
                    inValidPasswordAlertViewIsPresented = false
                })
            )
        }, titleText: "Delete account")
    }
}

#Preview {
    DeleteAccountView()
}

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
                    
                }.heyBottomButtonStyle(.primary)
                
                Spacer()
                    .frame(height: 65)
            }
            
        }, titleText: "Delete account")
    }
}

#Preview {
    DeleteAccountView()
}

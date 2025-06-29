//
//  ContactUsView.swift
//  MyPageFeature
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

import DSKit

public struct ContactUsView: View {
    public init() {}
    public var body: some View {
        MyPageBaseView(content: {
            Spacer()
                .frame(height: 36)
            
            VStack(alignment: .leading) {
                Text("Our email")
                    .font(.medium_16)
                    .foregroundColor(.common.MainText.default)
                    .lineSpacing(10)
                    .padding(.bottom, 8)
                
                HStack {
                    Text(verbatim: "jacobkwak1122@gmail.com")
                        .font(.regular_14)
                        .foregroundColor(.common.Placeholder.default)
                    
                    Spacer()
                    
                    Button {
                        UIPasteboard.general.string = "jacobkwak1122@gmail.com"
                    } label: {
                        Image.icCopy
                            .foregroundColor(.setting.copyIcon)
                    }
                }
                .padding(.all, 16)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.heyMain, lineWidth: 2)
                )
                .background(Color.mypage.menubox)
            }
            
            
        }, titleText: "Contact us")
    }
}

#Preview {
    ContactUsView()
}

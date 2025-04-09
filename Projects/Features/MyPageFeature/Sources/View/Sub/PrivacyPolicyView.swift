//
//  PrivacyPolicyView.swift
//  MyPageFeature
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

import BaseFeatureDependency

public struct PrivacyPolicyView: View {
    public init() {}
    public var body: some View {
        MyPageBaseView(content: {
            VStack {
                Link(destination: URL(string: Website.PrivacyPolicy)!) {
                    HStack {
                        Text("Show Privacy policy")
                            .font(.semibold_16)
                            .foregroundColor(.common.Placeholder.default)
                        
                        Spacer()
                        
                        Image(uiImage: .icLink.withRenderingMode(.alwaysTemplate))
                            .resizable()
                            .frame(width: 16, height: 16)
                            .tint(.common.Placeholder.default)
                        
                    }
                    .padding(.vertical, 16)
                    .padding(.horizontal, 20)
                    .background(Color.common.InputField.default)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .padding(.top, 28)
            }
        }, titleText: "Privacy policy")
    }
}

#Preview {
    PrivacyPolicyView()
}

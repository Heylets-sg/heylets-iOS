//
//  PrivacyPolicyView.swift
//  MyPageFeature
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

public struct PrivacyPolicyView: View {
    public init() {}
    public var body: some View {
        MyPageBaseView(content: {
            VStack {
                Spacer()
                    .frame(height: 42)
                
                
            }
            
        }, titleText: "Privacy policy")
    }
}

#Preview {
    PrivacyPolicyView()
}

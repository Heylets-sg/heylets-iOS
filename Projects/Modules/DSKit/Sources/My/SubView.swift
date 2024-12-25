//
//  SubView.swift
//  DSKit
//
//  Created by 류희재 on 12/24/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI
import BaseFeatureDependency

public struct MyPageView: View {
    public var body: some View {
        MyPageBaseView(content: {
            VStack {
                Spacer()
                    .frame(height: 42)
                
                
            }
            
        }, titleText: "My account",
                       titleColor: .white,
                       backgroundColor: .heyMain)
    }
}

#Preview {
    MyPageView()
}

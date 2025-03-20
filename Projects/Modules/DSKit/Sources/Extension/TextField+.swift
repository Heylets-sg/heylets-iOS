//
//  TextField+.swift
//  DSKit
//
//  Created by 류희재 on 3/20/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import SwiftUI

struct MaxLengthModifier: ViewModifier {
    @Binding var text: String
    let maxLength: Int

    func body(content: Content) -> some View {
        content
            .onChange(of: text) { newValue in
                if newValue.count > maxLength {
                    text = String(newValue.prefix(maxLength))
                }
            }
    }
}

public extension HeyTextField {
    /// TextField에서 최대 글자수를 정하기 위한 Modifier
    func maxLength(text: Binding<String>, _ maxLength: Int) -> some View {
        self.modifier(MaxLengthModifier(text: text, maxLength: maxLength))
    }
}


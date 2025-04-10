//
//  CustomFontSubstringText.swift
//  DSKit
//
//  Created by 류희재 on 2/10/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import SwiftUI

public struct CustomSubstringText: View {
    var originalText: String
    var targetSubstring: String
    var targetFont: Font?
    var targetColor: Color?

    public init(
        originalText: String,
        targetSubstring: String,
        targetFont: Font? = nil,
        targetColor: Color? = nil
    ) {
        self.originalText = originalText
        self.targetSubstring = targetSubstring
        self.targetFont = targetFont
        self.targetColor = targetColor
    }

    public var body: some View {
        Group {
            if let range = originalText.range(of: targetSubstring) {
                let beforeText = String(originalText[..<range.lowerBound])
                let highlightedText = String(originalText[range])
                let afterText = String(originalText[range.upperBound...])

                (
                    Text(beforeText) +
                    Text(highlightedText)
                        .font(targetFont)
                        .foregroundColor(targetColor) +
                    Text(afterText)
                )
            } else {
                Text(originalText)
            }
        }
    }
}

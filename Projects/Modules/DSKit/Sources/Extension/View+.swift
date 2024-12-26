//
//  View+.swift
//  DSKit
//
//  Created by 류희재 on 12/23/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

extension View {
    /// Bool 값에 따라 뷰를 숨기거나 표시
    @ViewBuilder
    public func hidden(_ isHidden: Bool) -> some View {
        if isHidden {
            self.hidden() // 완전히 숨김 처리
        } else {
            self
        }
    }
}

extension View {
    public func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

public struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    public func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        return Path(path.cgPath)
    }
}

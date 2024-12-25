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


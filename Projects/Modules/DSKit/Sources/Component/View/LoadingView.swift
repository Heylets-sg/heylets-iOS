//
//  LoadingView.swift
//  DSKit
//
//  Created by 류희재 on 1/2/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView()
    }
}

extension View {
    func loading(_ isLoading: Bool) -> some View {
        self.overlay {
            if isLoading {
                LoadingView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.black.opacity(0.2))
            }
        }
    }
}

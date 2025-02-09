//
//  BounceScrollView.swift
//  DSKit
//
//  Created by 류희재 on 2/4/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import SwiftUI

public struct BounceScrollView<Content: View>: UIViewRepresentable {
    var axis: Axis
    var isScrollEnabled: Bool
    var content: () -> Content
    
    public init(
        axis: Axis,
        isScrollEnabled: Bool = true,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.axis = axis
        self.isScrollEnabled = isScrollEnabled
        self.content = content
    }

    public func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.bounces = false // 바운스 제거
        scrollView.alwaysBounceVertical = false
        scrollView.alwaysBounceHorizontal = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isScrollEnabled = isScrollEnabled

        let hostingController = UIHostingController(rootView: content())
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false

        scrollView.addSubview(hostingController.view)

        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: scrollView.topAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            // 스크롤 방향에 따라 크기 설정
            axis == .horizontal
                ? hostingController.view.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
                : hostingController.view.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])

        return scrollView
    }

    public func updateUIView(_ uiView: UIScrollView, context: Context) {
        uiView.setNeedsDisplay()
        uiView.setNeedsLayout()
    }
}


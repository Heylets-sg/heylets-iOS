//
//  CornerBorderView.swift
//  DSKit
//
//  Created by 류희재 on 2/4/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import SwiftUI

public struct CornerBorderView: View {
    public var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.blue.opacity(0.2))
            .frame(width: 200, height: 100)
            .overlay(CustomBorderShape(edges: [.top, .leading, .trailing])
                        .stroke(Color.red, lineWidth: 2))
    }
}

public struct CustomBorderShape: Shape {
    public let edges: [Edge]

    public init(edges: [Edge]) {
        self.edges = edges
    }
    
    public func path(in rect: CGRect) -> Path {
        var path = Path()

        for edge in edges {
            switch edge {
            case .top:
                path.move(to: CGPoint(x: rect.minX, y: rect.minY))
                path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            case .bottom:
                path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
                path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            case .leading:
                path.move(to: CGPoint(x: rect.minX, y: rect.minY))
                path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            case .trailing:
                path.move(to: CGPoint(x: rect.maxX, y: rect.minY))
                path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            }
        }
        
        return path
    }
}


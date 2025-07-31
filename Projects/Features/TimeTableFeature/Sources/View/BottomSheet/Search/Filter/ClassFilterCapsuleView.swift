//
//  ClassFilterCapsuleView.swift
//  TimeTableFeature
//
//  Created by 류희재 on 7/31/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import SwiftUI

struct ClassFilterCapsuleView: View {
    let title: String
    let isSelected: Bool
    let screenWidth: CGFloat
    let action: () -> Void
    
    // 기기 크기에 따른 적응형 패딩 계산
    private var horizontalPadding: CGFloat {
        if screenWidth <= 390 { return 12 }      // 매우 작은 화면
        else { return 19 }                     // 큰 화면
    }
    
    // 기기 크기에 따른 최소 너비 계산
    private var minWidth: CGFloat {
        let baseWidth: CGFloat = CGFloat(title.count * 8 + 20) // 글자당 대략 8포인트, 아이콘과 여유 공간 20포인트
        
        if screenWidth < 320 {
            return min(baseWidth, 70)     // 작은 화면에서는 최대 70포인트
        } else if screenWidth < 375 {
            return min(baseWidth, 80)     // 중간 화면에서는 최대 80포인트
        } else if screenWidth < 428 {
            return min(baseWidth, 90)     // 큰 화면에서는 최대 90포인트
        } else {
            return min(baseWidth, 100)    // 아주 큰 화면에서는 최대 100포인트
        }
    }
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 4) {
                Text(title)
                    .font(.semibold_12)
                    .foregroundColor(
                        isSelected
                        ? .Filter.Text.active
                        : .Filter.Text.unActive
                    )
                
                Image.icDown
                    .resizable()
                    .frame(width: 9, height: 4)
                    .foregroundColor(
                        isSelected
                        ? .Filter.Text.active
                        : .Filter.Text.unActive
                    )
            }
            .padding(.horizontal, horizontalPadding)
            .padding(.vertical, 11)
            .background(
                Capsule()
                    .fill(
                        isSelected
                        ? Color.heyMain.opacity(0.1)
                        : Color.clear
                    )
                    .overlay(
                        Capsule()
                            .stroke(
                                isSelected
                                ? Color.Filter.Stroke.active
                                : Color.Filter.Stroke.unActive,
                                lineWidth: 1.8
                            )
                    )
            )
        }
    }
}

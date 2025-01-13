//
//  Date+.swift
//  Core
//
//  Created by 류희재 on 1/14/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

extension Date {
    public func toInt() -> Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd" // 원하는 형식
        let dateString = formatter.string(from: self)
        return Int(dateString) ?? 0 // String을 Int로 변환
    }
}

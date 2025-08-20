//
//  CacheConfiguration.swift
//  Data
//
//  Created by 류희재 on 8/8/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public struct CacheConfiguration: Sendable{
    let timeout: TimeInterval
    let maxSize: Int
    let queueLabel: String
    
    static let timeTable = CacheConfiguration(
        timeout: 300,
        maxSize: 10,
        queueLabel: "timeTable.cache.queue"
    )
    
    static let lecture = CacheConfiguration(
        timeout: 1800,
        maxSize: 20,
        queueLabel: "lecture.cache.queue"
    )
}

//
//  AnalyticsTaxonomy.swift
//  Core
//
//  Created by 류희재 on 3/14/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public struct AnalyticsTaxonomy {
    
    public enum EventCategory: String {
        case Onboarding
        case Guest
        case SignUp
        case LogIn
        case ModuleManagement
        case LectureReview
        case TimetableSetting
        case Todo
        case MyAccount
        case PushAlarm
        case Common
        case AppStart
    }
    
    public let category: EventCategory
    public let eventName: String
    public let tags: String
    public let channel: String
    public var properties: [String: Any?]
    
    public init(
        category: EventCategory,
        eventName: String,
        tags: String,
        channel: String = "APP",
        properties: [String: Any?] = [:]
    ) {
        self.tags = tags
        self.eventName = eventName
        self.category = category
        self.channel = channel
        self.properties = properties
    }

    @discardableResult
    mutating func add(_ value: Any?, forKey key: String) -> Self {
        self.properties[key] = value
        return self
    }
}



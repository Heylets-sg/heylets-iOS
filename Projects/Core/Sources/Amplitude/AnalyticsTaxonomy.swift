//
//  AnalyticsTaxonomy.swift
//  Core
//
//  Created by 류희재 on 3/14/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public struct AnalyticsTaxonomy: Sendable {
    public let eventName: String
    public let channel: String
    public var properties: [String: (any Sendable)?]
    
    public init(
        eventName: String,
        channel: String = "APP",
        properties: [String: (any Sendable)?] = [:]
    ) {
        self.eventName = eventName
        self.channel = channel
        self.properties = properties
    }

    @discardableResult
    mutating func add(_ value: (any Sendable)?, forKey key: String) -> Self {
        self.properties[key] = value
        return self
    }
}



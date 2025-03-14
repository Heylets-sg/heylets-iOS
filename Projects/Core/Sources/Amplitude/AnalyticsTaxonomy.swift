//
//  AnalyticsTaxonomy.swift
//  Core
//
//  Created by 류희재 on 3/14/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

struct AnalyticsTaxonomy {
    
    enum EventType: String {
        case page
        case button
        case modal
    }
    
    let tag: String
    let tagEng: String
    let type: EventType
    let channel: String
    var properties: [String: Any?]
    
    init(
        tag: String,
        tagEng: String,
        type: EventType,
        channel: String = "APP",
        properties: [String: Any?] = [:]
    ) {
        self.tag = tag
        self.tagEng = tagEng
        self.type = type
        self.channel = channel
        self.properties = properties
    }

    @discardableResult
    mutating func add(_ value: Any?, forKey key: String) -> Self {
        self.properties[key] = value
        return self
    }
}



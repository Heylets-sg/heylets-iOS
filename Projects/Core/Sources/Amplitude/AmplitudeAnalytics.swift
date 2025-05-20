//
//  AmplitudeAnalytics.swift
//  Core
//
//  Created by 류희재 on 3/14/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import AmplitudeSwift

public final class AmplitudeAnalytics: @unchecked Sendable {
    static let shared = AmplitudeAnalytics()
    private let amplitude = Amplitude(configuration: Configuration(apiKey: Config.amplitudeAPIKey))
    
    private init() {}
}

extension AmplitudeAnalytics: Analyzable {
    func track(_ taxonomy: AnalyticsTaxonomy) {
        let event = taxonomy.toAmplitudeEvent()
        amplitude.track(
            event: event,
            options: nil,
            callback: nil
        )
    }
    
    func reset() {
        amplitude.reset()
    }
}

extension AnalyticsTaxonomy {
    public func toAmplitudeEvent() -> BaseEvent {
        let eventType = self.eventName
        var eventProperties: [String: Any?] = [
            "eventName" : self.eventName,
            "channel": self.channel,
        ]
        properties.forEach {
            eventProperties.updateValue($0.value, forKey: $0.key)
        }
        
        return BaseEvent(
            eventType: eventType,
            eventProperties: eventProperties
        )
    }
}



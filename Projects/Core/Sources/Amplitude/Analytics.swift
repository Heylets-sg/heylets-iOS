//
//  Analytics.swift
//  Core
//
//  Created by 류희재 on 3/14/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

protocol Analyzable {
    func track(_ taxonomy: AnalyticsTaxonomy)
    func reset()
}

public final class Analytics: @unchecked Sendable {
    public static let shared = Analytics()
    private init() { }
}

extension Analytics: Analyzable {
    public func track(_ taxonomy: AnalyticsTaxonomy) {
        Task { @MainActor in
            AmplitudeAnalytics.shared.track(taxonomy)
        }
    }
    
    func reset() {
        Task { @MainActor in
            AmplitudeAnalytics.shared.reset()
        }
    }
}

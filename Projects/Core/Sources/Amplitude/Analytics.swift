//
//  Analytics.swift
//  Core
//
//  Created by 류희재 on 3/14/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

protocol Analyzable: Sendable {
    func track(_ taxonomy: AnalyticsTaxonomy)
    func reset() async
}

public actor Analytics {
    public static let shared = Analytics()
    private init() { }
}

extension Analytics: Analyzable {
    public nonisolated func track(_ taxonomy: AnalyticsTaxonomy) {
        Task {
            await AmplitudeAnalytics.shared.track(taxonomy)
        }
    }
    
    func reset() async {
        await AmplitudeAnalytics.shared.reset()
    }
}

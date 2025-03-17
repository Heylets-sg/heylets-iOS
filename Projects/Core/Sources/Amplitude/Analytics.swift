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

public final class Analytics {
    public static let shared = Analytics()
    private init() { }
}

extension Analytics: Analyzable {
    public func track(_ taxonomy: AnalyticsTaxonomy) {
        AmplitudeAnalytics.shared.track(taxonomy)
    }
    
    func reset() {
        AmplitudeAnalytics.shared.reset()
    }
}


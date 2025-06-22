//
//  Analytics.swift
//  Core
//
//  Created by 류희재 on 3/14/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

protocol Analyzable: Sendable {
    func track(_ taxonomy: AnalyticsTaxonomy) async
    func reset()
}

public actor Analytics {
    public static let shared = Analytics()
    private init() { }
}

extension Analytics: Analyzable {
    public func track(_ taxonomy: AnalyticsTaxonomy) async {
        Task {
            await AmplitudeAnalytics.shared.track(taxonomy)
        }
        
    }
    
    func reset() {
        Task {
            await AmplitudeAnalytics.shared.reset()
        }
    }
}

//
//  PushAlarmTaxonomy.swift
//  BaseFeatureDependency
//
//  Created by 류희재 on 3/14/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Core

public extension AnalyticsTaxonomy {
    static let clickPushAlarm = AnalyticsTaxonomy(
        eventName: "click_push_alarm"
    )

    static let pushAlarmReceived = AnalyticsTaxonomy(
        eventName: "push_alarm_received"
    )
}


//
//  ModuleManagementTaxonomy.swift
//  BaseFeatureDependency
//
//  Created by 류희재 on 3/14/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Core

extension AnalyticsTaxonomy {
    static let clickDeleteModule = AnalyticsTaxonomy(
        eventName: "click_delete_module"
    )

    static let moduleDeleted = AnalyticsTaxonomy(
        eventName: "module_deleted"
    )

    static let clickSearchModule = AnalyticsTaxonomy(
        eventName: "click_search_module"
    )

    static let moduleSearched = AnalyticsTaxonomy(
        eventName: "moudle_searched"
    )

    static let clickAddModule = AnalyticsTaxonomy(
        eventName: "click_add_module"
    )

    static let moduleAdded = AnalyticsTaxonomy(
        eventName: "module_added"
    )

    static let clickAddCustomModule = AnalyticsTaxonomy(
        eventName: "click_add_custom_module"
    )

    static let customModuleAdded = AnalyticsTaxonomy(
        eventName: "custom_module_added"
    )

    static let clickReportModule = AnalyticsTaxonomy(
        eventName: "click_report_module"
    )

    static let moduleReported = AnalyticsTaxonomy(
        eventName: "module_reported"
    )
}


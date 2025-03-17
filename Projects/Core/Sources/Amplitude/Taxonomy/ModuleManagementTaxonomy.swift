//
//  ModuleManagementTaxonomy.swift
//  BaseFeatureDependency
//
//  Created by 류희재 on 3/14/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public extension AnalyticsTaxonomy {
    static let clickDeleteModule = AnalyticsTaxonomy(
        eventName: "click_delete_module"
    )
    
    static let moduleDeleted = AnalyticsTaxonomy(
        eventName: "module_deleted"
    )
    
    static func clickSearchModule(
        keyword: String,
        semester: String
    ) ->  AnalyticsTaxonomy {
        return AnalyticsTaxonomy(
            eventName: "click_search_module",
            properties: [
                "keyword": keyword,
                "semeter": semester
            ]
        )
    }
    
    static let moduleSearched = AnalyticsTaxonomy(
        eventName: "moudle_searched"
    )
    
    static func clickAddModule(
        courseCode: String,
        courseName: String,
        sectionId: Int,
        professor: String
    )  -> AnalyticsTaxonomy {
        return AnalyticsTaxonomy(
            eventName: "click_add_module",
            properties: [
                "courseCode": courseCode,
                "courseName": courseName,
                "sectionId": sectionId,
                "professor": professor,
            ]
        )
    }
    
    static let moduleAdded = AnalyticsTaxonomy(
        eventName: "module_added"
    )
    
    static func clickAddCustomModule(
        customModuleName: String,
        professor: String,
        location: String,
        day: String,
        schedule: String
    )  -> AnalyticsTaxonomy {
        return AnalyticsTaxonomy(
            eventName: "click_add_custom_module",
            properties: [
                "custom_module_name": customModuleName,
                "professor": professor,
                "location": location,
                "day": day,
                "schedule": schedule
            ]
        )
    }
    
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


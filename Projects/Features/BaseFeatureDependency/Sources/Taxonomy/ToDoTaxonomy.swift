//
//  ToDoTaxonomy.swift
//  BaseFeatureDependency
//
//  Created by 류희재 on 3/14/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Core

public extension AnalyticsTaxonomy {
    static let clickAddTask = AnalyticsTaxonomy(
        eventName: "click_add_task"
    )

    static let taskAdded = AnalyticsTaxonomy(
        eventName: "task_added"
    )

    static let clickAddTodoGroup = AnalyticsTaxonomy(
        eventName: "click_add_todo_group"
    )

    static let todoGroupAdded = AnalyticsTaxonomy(
        eventName: "todo_group_added"
    )
}


//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 류희재 on 12/18/24.
//

import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: "BaseFeatureDependency",
    targets: [.dynamicFramework],
    internalDependencies: [
        .domain,
        .Modules.dsKit
    ]
)


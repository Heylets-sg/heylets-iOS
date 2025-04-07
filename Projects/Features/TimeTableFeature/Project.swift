//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 류희재 on 12/17/24.
//

import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: "TimeTableFeature",
    targets: [.dynamicFramework, .interface], //, .demo
    interfaceDependencies: [
        .Features.BaseFeatureDependency
    ]
)

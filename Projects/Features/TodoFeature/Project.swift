//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 류희재 on 2/27/25.
//

import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: "TodoFeature",
    targets: [.staticFramework, .interface], //, .demo
    interfaceDependencies: [
        .Features.BaseFeatureDependency
    ]
)

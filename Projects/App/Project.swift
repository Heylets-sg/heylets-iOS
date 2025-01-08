//
//  Project.swift
//  Heylets-iOSManifests
//
//  Created by 류희재 on 12/17/24.
//

import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin
import EnvPlugin

let project = Project.makeModule(
    name: env.workspaceName,
    targets: [.app],
    internalDependencies: [
        .data,
        .Features.RootFeature
    ]
)



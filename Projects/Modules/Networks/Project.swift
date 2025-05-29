//
//  Project.swift
//  Heylets-iOSManifests
//
//  Created by 류희재 on 12/17/24.
//

@preconcurrency import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: "Networks",
    targets: [.staticFramework], //, .unitTest, .demo
    internalDependencies: [
        .domain
    ]
)

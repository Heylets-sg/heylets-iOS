//
//  Project.swift
//  Heylets-iOSManifests
//
//  Created by 류희재 on 12/17/24.
//

import Foundation

import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: "Domain",
    targets: [.dynamicFramework],
    internalDependencies: [
        .core
    ]
)


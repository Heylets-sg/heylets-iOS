//
//  Project.swift
//  Heylets-iOSManifests
//
//  Created by 류희재 on 12/17/24.
//

import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: "RootFeature",
    targets: [.staticFramework], //, .demo
    internalDependencies: [
        .Features.Splash.Feature,
        .Features.Onboarding.Feature,
        .Features.MyPage.Feature,
        .Features.TimeTable.Feature,
        .Features.Todo.Feature
    ]
)

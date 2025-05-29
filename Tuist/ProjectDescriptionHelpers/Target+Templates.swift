//
//  Target+Templates.swift
//  Heylets-iOSManifests
//
//  Created by 류희재 on 12/17/24.
//

import Foundation
import ProjectDescription

import EnvPlugin

/// 빌드할 파일들의 집합을 만들어줌
struct TargetHandler {
    static func makeTarget(
        targetType: FeatureTarget,
        name: String,
        projectEnv: ProjectEnvironment = env,
        package: [Package] = [],
        bundleSuffix: String,
        infoPlist: InfoPlist = .default,
        resources: ResourceFileElements? = nil,
        entitlements: Entitlements? = nil,
        dependencies: [TargetDependency] = []
    ) -> Target {
        Target.target(
            name: name,
            destinations: projectEnv.destinations,
            product: targetType.product,
            bundleId: "\(projectEnv.bundlePrefix).\(bundleSuffix)",
            deploymentTargets: projectEnv.deploymentTarget,
            infoPlist: infoPlist,
            sources: targetType.sources,
            resources: resources,
            entitlements: entitlements,
            dependencies: dependencies
        )
    }
    
    static func makeProjectTargets(
        name: String,
        package: [Package] = [],
        hasResources: Bool,
        internalDependencies: [TargetDependency] = [],
        externalDependencies: [TargetDependency] = [],
        interfaceDependencies: [TargetDependency] = [],
        targets: Set<FeatureTarget>
    ) -> [Target] {
        return targets.map { $0.makeTarget(
            name: name,
            hasResources: hasResources,
            targets: targets,
            internalDependencies: internalDependencies,
            externalDependencies: externalDependencies,
            interfaceDependencies: interfaceDependencies
        )}
    }
}

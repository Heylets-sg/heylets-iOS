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
        package: [Package] = [],
        platform: Platform = env.platform,
        bundleID: String,
        deploymentTarget: DeploymentTarget = env.deploymentTarget,
        infoPlist: InfoPlist = .default,
        resources: ResourceFileElements? = nil,
        entitlements: ProjectDescription.Path? = nil,
        dependencies: [TargetDependency] = []
    ) -> Target {
        .init(
            name: name,
            platform: platform,
            product: targetType.product,
            bundleId: bundleID,
            deploymentTarget: deploymentTarget,
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
        var projectTargets: [Target] = []
        
        targets.forEach { targetType in
            let target = {
                switch targetType {
                case .app:
                    return TargetHandler.makeAppTarget(
                        name: name,
                        dependencies: internalDependencies + externalDependencies
                    )
                case .interface:
                    return TargetHandler.makeInterfaceTarget(
                        name: name,
                        dependencies: interfaceDependencies
                    )
                case .staticFramework, .dynamicFramework:
                    let deps: [TargetDependency] = targets.contains(.interface)
                    ? [.target(name: "\(name)Interface")]
                    : []
                    
                    return TargetHandler.makeFrameworkTarget(
                        targetType: targetType,
                        name: name,
                        hasResources: hasResources,
                        dependencies: deps + internalDependencies + externalDependencies
                    )
                case .unitTest:
                    return TargetHandler.makeUnitTestTarget(name: name)
                case .demo:
                    return TargetHandler.makeDemoTarget(name: name)
                }
            }()
            
            projectTargets.append(target)
        }
        
        return projectTargets
    }
}

extension TargetHandler {
    static func makeAppTarget(
        name: String,
        dependencies: [TargetDependency]
    ) -> Target {
        return TargetHandler.makeTarget(
            targetType: .app,
            name: name,
            bundleID: "\(env.bundlePrefix).\(name.contains("Demo") ? "test" : "release")",
            infoPlist: InfoPlistProvider.forApp(name: name),
            resources: [
                .glob(pattern: "Resources/**", excluding: [])
            ],
            entitlements: "\(name).entitlements",
            dependencies: dependencies
        )
    }
    
    static func makeInterfaceTarget(
        name: String,
        dependencies: [TargetDependency]
    ) -> Target {
        return TargetHandler.makeTarget(
            targetType: .interface,
            name: "\(name)Interface",
            bundleID: "\(env.bundlePrefix).\(name)Interface",
            dependencies: dependencies
        )
    }
    
    static func makeDemoTarget(name: String) -> Target {
        return TargetHandler.makeTarget(
            targetType: .demo,
            name: "\(name)Demo",
            bundleID: "\(env.bundlePrefix).\(name)Demo",
            infoPlist: .extendingDefault(with: Project.demoInfoPlist),
            resources: [.glob(pattern: "Demo/Resources/**", excluding: ["Demo/Resources/dummy.txt"])],
            dependencies: [.target(name:name)]
        )
    }
    
    static func makeUnitTestTarget(name: String) -> Target {
        return TargetHandler.makeTarget(
            targetType: .unitTest,
            name: "\(name)Tests",
            bundleID: "\(env.bundlePrefix).\(name)Tests",
            dependencies: [.target(name: name)]
        )
    }
    
    static func makeFrameworkTarget(
        targetType: FeatureTarget,
        name: String,
        package: [Package] = [],
        hasResources: Bool,
        dependencies: [TargetDependency]
    ) -> Target {
        return TargetHandler.makeTarget(
            targetType: targetType,
            name: name,
            bundleID: "\(env.bundlePrefix).\(name)",
            resources: hasResources ? [
                .glob(pattern: "Resources/**", excluding: [])
            ] : [],
            dependencies: dependencies
        )
    }
}


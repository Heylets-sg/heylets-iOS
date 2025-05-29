//
//  Feature+Target.swift
//  Heylets-iOSManifests
//
//  Created by 류희재 on 12/17/24.
//

import Foundation
import ProjectDescription

public enum FeatureTarget {
    case app   // iOSApp
    case interface  // Feature Interface
    case dynamicFramework
    case staticFramework
    case unitTest   // Unit Test
    case demo   // Feature Excutable Test
    
    public var hasFramework: Bool {
        switch self {
        case .dynamicFramework, .staticFramework: return true
        default: return false
        }
    }
    
    public var product: Product {
        switch self {
        case .app, .demo:
            return .app
        case .interface, .dynamicFramework:
            return .framework
        case .staticFramework:
            return .staticFramework
        case .unitTest:
            return .unitTests
        }
    }
    
    public var sources: SourceFilesList {
        switch self {
        case .app, .staticFramework, .dynamicFramework:
            return .sources
        case .interface:
            return .interface
        case .unitTest:
            return .unitTests
        case .demo:
            return .demoSources
        }
    }
}

extension FeatureTarget {
    func targetName(for name: String) -> String {
        switch self {
        case .interface: return "\(name)Interface"
        case .unitTest:  return "\(name)Tests"
        case .demo:      return "\(name)Demo"
        default:         return name
        }
    }
    
    func bundleSuffix(for name: String) -> String {
        switch self {
        case .app:
            return name.contains("Demo") ? "test" : "release"
        case .interface:
            return "\(name)Interface"
        case .unitTest:
            return "\(name)Tests"
        case .demo:
            return "\(name)Demo"
        default:
            return name
        }
    }
    
    func resources(for hasResources: Bool) -> ResourceFileElements? {
        switch self {
        case .app, .staticFramework, .dynamicFramework:
            return hasResources ? [.glob(pattern: "Resources/**")] : nil
        case .demo:
            return [.glob(pattern: "Demo/Resources/**", excluding: ["Demo/Resources/dummy.txt"])]
        default:
            return nil
        }
    }
    
    func entitlements(for name: String) -> Entitlements? {
        switch self {
        case .app:
            return "\(name).entitlements"
        default:
            return nil
        }
    }
    
    func infoPlist(for name: String) -> InfoPlist {
        switch self {
        case .app:
            return InfoPlistProvider.forApp(name: name)
        case .demo:
            return Project.demoInfoPlist
        default:
            return .default
        }
    }
    
    func dependencies(
        name: String,
        targets: Set<FeatureTarget>,
        internalDeps: [TargetDependency],
        externalDeps: [TargetDependency],
        interfaceDeps: [TargetDependency]
    ) -> [TargetDependency] {
        switch self {
        case .app:
            return internalDeps + externalDeps
        case .interface:
            return interfaceDeps
        case .staticFramework, .dynamicFramework:
            let interfaceTarget: [TargetDependency] = targets.contains(.interface)
            ? [.target(name: "\(name)Interface")]
            : []
            return interfaceTarget + internalDeps + externalDeps
        case .unitTest:
            return [.target(name: name)]
        case .demo:
            return [.target(name: name)]
        }
    }
    
    func makeTarget(
        name: String,
        hasResources: Bool,
        targets: Set<FeatureTarget>,
        internalDependencies: [TargetDependency],
        externalDependencies: [TargetDependency],
        interfaceDependencies: [TargetDependency]
    ) -> Target {
        TargetHandler.makeTarget(
            targetType: self,
            name: targetName(for: name),
            bundleSuffix: bundleSuffix(for: name),
            infoPlist: infoPlist(for: name),
            resources: resources(for: hasResources),
            entitlements: entitlements(for: name),
            dependencies: dependencies(
                name: name,
                targets: targets,
                internalDeps: internalDependencies,
                externalDeps: externalDependencies,
                interfaceDeps: interfaceDependencies
            )
        )
    }
}



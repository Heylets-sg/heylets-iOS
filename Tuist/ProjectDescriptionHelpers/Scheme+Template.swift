//
//  Scheme+Template.swift
//  Heylets-iOSManifests
//
//  Created by 류희재 on 12/17/24.
//

import ProjectDescription
import EnvPlugin

struct SchemeProvider {
    static func makeProjectScheme(targets: Set<FeatureTarget>, name: String) -> [Scheme] {
        if targets.contains(.app) {
            return Scheme.appSchemes
        } else {
            var scheme: [Scheme] = [Scheme.makeScheme(name: name)]
            if targets.contains(.demo) { scheme.append(Scheme.makeDemoScheme(name: name))}
            return scheme
        }
    }
}

extension Scheme {
    static let appSchemes: [Scheme] = [
        .init(
            name: "\(env.workspaceName)-DEV",
            shared: true,
            buildAction: .buildAction(targets: ["\(env.workspaceName)"]),
            testAction: .targets(
                ["\(env.workspaceName)Tests", "\(env.workspaceName)UITests"],
                configuration: "Development",
                options: .options(coverage: true, codeCoverageTargets: ["\(env.workspaceName)"])
            ),
            runAction: .runAction(configuration: "Development"),
            archiveAction: .archiveAction(configuration: "Development"),
            profileAction: .profileAction(configuration: "Development"),
            analyzeAction: .analyzeAction(configuration: "Development")
        ),
        .init(
            name: "\(env.workspaceName)-QA",
            shared: true,
            buildAction: .buildAction(targets: ["\(env.workspaceName)"]),
            runAction: .runAction(configuration: "QA"),
            archiveAction: .archiveAction(configuration: "QA"),
            profileAction: .profileAction(configuration: "QA"),
            analyzeAction: .analyzeAction(configuration: "QA")
        ),
        .init(
            name: "\(env.workspaceName)-PROD",
            shared: true,
            buildAction: .buildAction(targets: ["\(env.workspaceName)"]),
            runAction: .runAction(configuration: "PROD"),
            archiveAction: .archiveAction(configuration: "PROD"),
            profileAction: .profileAction(configuration: "PROD"),
            analyzeAction: .analyzeAction(configuration: "PROD")
        ),
    ]
    
    // makeDemoScheme은 개발환경에서 release로 (demo앱이기때문에!)
    static func makeDemoScheme(name: String) -> Scheme { // 데모앱
        return Scheme(
            name: "\(name)Demo",
            shared: true,
            buildAction: .buildAction(targets: ["\(name)Demo"]),
            testAction: .targets(
                ["\(name)Tests"],
                configuration: "QA",
                options: .options(coverage: true, codeCoverageTargets: ["\(name)Demo"])
            ),
            runAction: .runAction(configuration: "QA"),
            archiveAction: .archiveAction(configuration: "QA"),
            profileAction: .profileAction(configuration: "QA"),
            analyzeAction: .analyzeAction(configuration: "QA")
        )
    }
    
    // makeScheme은 개발환경에서 debug (그냥 개발 빌드이기 때문에)
    static func makeScheme(name: String) -> Scheme { // 일반앱
        return Scheme(
            name: name,
            shared: true,
            buildAction: .buildAction(targets: ["\(name)"]),
            testAction: .targets(
                ["\(name)Tests"],
                configuration: "Development",
                options: .options(coverage: true, codeCoverageTargets: ["\(name)"])
            ),
            runAction: .runAction(configuration: "Development"),
            archiveAction: .archiveAction(configuration: "Development"),
            profileAction: .profileAction(configuration: "Development"),
            analyzeAction: .analyzeAction(configuration: "Development")
        )
    }
}





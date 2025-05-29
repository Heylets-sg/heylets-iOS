//
//  Project+Templates.swift
//  Heylets-iOSManifests
//
//  Created by 류희재 on 12/17/24.
//

import ProjectDescription
import ConfigPlugin
import EnvPlugin


public extension Project {
    /// Sumarry: 모듈을 만드는 함수
    ///
    /// Discussion/Overview
    ///
    /// - Parameters:
    ///    - name: 프로젝트 이름 (모듈 이름)
    ///    - targets: 빌드할 타겟의 대상
    ///    - packages:SPM의 package
    ///    - internalDependencies: 내부 의존성
    ///    - externalDependencies: 외부 의존성
    ///    - interfaceDependencies: 인터페이스 의존성
    ///    - sources: 소스 파일
    ///    - hasResourcces: 리소스 파일 포함 여부
    static func makeModule(
        name: String,
        workspaceName: String = env.workspaceName,
        targets: Set<FeatureTarget> = Set([.staticFramework, .unitTest, .demo]),
        packages: [Package] = [],
        internalDependencies: [TargetDependency] = [],
        externalDependencies: [TargetDependency] = [],
        interfaceDependencies: [TargetDependency] = [],
        sources: SourceFilesList? = nil,
        hasResources: Bool = false
    ) -> Project {
        
        let projectTargets: [Target] = TargetHandler.makeProjectTargets(
            name: name,
            hasResources: hasResources,
            internalDependencies: internalDependencies,
            externalDependencies: externalDependencies,
            interfaceDependencies: interfaceDependencies,
            targets: targets
        )
        let projcetScheme: [Scheme] = SchemeProvider.makeProjectScheme(targets: targets, name: name)
        let baseSettings: SettingsDictionary = .baseSettings
            .allowEntitlementsModification()
            .setProvisioning()
        
        return Project(
            name: name,
            organizationName: workspaceName,
            packages: packages,
            settings: .settings(
                base: baseSettings,
                configurations: XCConfig.configurations
            ),
            targets: projectTargets,
            schemes: projcetScheme
        )
    }
    
    static func makeSPMModule(
        name: String,
        workspaceName: String = env.workspaceName,
        packages: [Package] = []
    ) -> Project {
        let projectTargets: [Target] = TargetHandler.makeProjectTargets(
            name: name,
            hasResources: false,
            externalDependencies: [
                .package(product: "FirebaseMessaging"),
                .package(product: "FirebaseCore"),
                .package(product: "AmplitudeSwift")
            ], targets: [.dynamicFramework]
        )
        
        let projcetScheme: [Scheme] = SchemeProvider.makeProjectScheme(targets: [.dynamicFramework], name: name)
        
        return Project(
            name: name,
            organizationName: workspaceName,
            packages: packages,
            settings: .settings(configurations: XCConfig.configurations),
            targets: projectTargets,
            schemes: projcetScheme
        )
    }
}


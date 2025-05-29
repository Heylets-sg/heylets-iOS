//
//  Enviroment.swift
//  DependencyPlugin
//
//  Created by 류희재 on 12/17/24.
//

@preconcurrency import ProjectDescription

/// 프로젝트 환경 관련 파일입니다

public struct ProjectEnvironment : Sendable{
    public let workspaceName: String
    public let destinations: Destinations
    public let deploymentTarget: DeploymentTargets
    public let platform: Platform
    public let bundlePrefix: String
}

extension ProjectEnvironment {
    public static let env = ProjectEnvironment(
        workspaceName: "Heylets-iOS",
        destinations: [.iPhone],
        deploymentTarget: DeploymentTargets.iOS("16.4"),
        platform: .iOS,
        bundlePrefix: "com.heeom.Heylets-iOS"
    )
}



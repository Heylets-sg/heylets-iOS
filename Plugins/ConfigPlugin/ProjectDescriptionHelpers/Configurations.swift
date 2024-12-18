//
//  Configurations.swift
//  MyPlugin
//
//  Created by 류희재 on 12/17/24.
//

import Foundation
import ProjectDescription

/// 빌드할 환경에 대한 설정

/// Target 분리 (The Modular Architecture 기반으로 분리했습니다)


/// DEV : 테스트 BaseURL을 사용하는 debug scheme
/// PROD : 실제 프로덕트 BaseURL을 사용하는 release scheme

public struct XCConfig {
    static func path(for target: BuildTarget) -> ProjectDescription.Path {
        .relativeToRoot("./XCConfig/\(target.rawValue).xcconfig")
    }

    public static let configurations: [Configuration] = [
        .build(.dev),
        .build(.qa),
        .build(.prod)
    ]
}

public enum BuildTarget: String {
    case dev = "DEV"
    case qa = "QA"
    case prod = "PROD"
}

public extension Configuration {
    static func build(_ target: BuildTarget) -> Self {
        switch target {
        case .dev:
            return .debug(
                name: "Development",
                xcconfig: XCConfig.path(for: .dev)
            )
        case .qa:
            return .debug(
                name: "QA",
                xcconfig: XCConfig.path(for: .qa)
            )
        case .prod:
            return .release(
                name: "PROD",
                xcconfig: XCConfig.path(for: .prod)
            )
        }
    }
}

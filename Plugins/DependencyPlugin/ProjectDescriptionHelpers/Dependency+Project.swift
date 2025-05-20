//
//  Dependency+Project.swift
//  MyPlugin
//
//  Created by 류희재 on 12/17/24.
//

@preconcurrency import ProjectDescription

/// 프로젝트 내 모듈 및 기능별 종속성을 체계적으로 관리하기 위한 유틸리티를 제공
/// 새로운 모듈이나 기능이 추가되더라도 해당 파일만 업데이트하면 되어 유지보수가 용이합니다.

public extension Dep {
    struct Features {
        public struct Splash {}
        public struct Onboarding {}
        public struct MyPage {}
        public struct TimeTable {}
        public struct Todo {}
        public struct Root {}
    }
    
    struct Modules {}
}

// MARK: - Root: 프로젝트의 핵심 모듈에 대한 종속성을 정의

public extension Dep {
    static let data = Dep.project(target: "Data", path: .data)
    
    static let domain = Dep.project(target: "Domain", path: .domain)
    
    static let core = Dep.project(target: "Core", path: .core)
}

// MARK: - Modules: 프로젝트 내 모듈 단위 종속성을 정의

public extension Dep.Modules {
    static let dsKit = Dep.project(
        target: "DSKit",
        path: .relativeToModules("DSKit")
    )
    
    static let networks = Dep.project(
        target: "Networks",
        path: .relativeToModules("Networks")
    )
    
    static let thirdPartyLibs = Dep.project(
        target: "ThirdPartyLibs",
        path: .relativeToModules("ThirdPartyLibs")
    )
}

// MARK: - Features

public extension Dep.Features {
    static func project(name: String, group: String) -> Dep {
        .project(
            target: "\(group)\(name)",
            path: .relativeToFeature("\(group)\(name)")
        )
    }
    
    static let BaseFeatureDependency = Dep.project(
        target: "BaseFeatureDependency",
        path: .relativeToFeature("BaseFeatureDependency")
    )
    
    static let RootFeature = Dep.project(
        target: "RootFeature",
        path: .relativeToFeature("RootFeature")
    )
}

//TODO: 폴더별로 분기처리하기 위해서 이런식으로 했다면 하나의 그룹이름만 주입해서 만드는게 좋지않나?

public extension Dep.Features.Splash {
    static let group = "Splash"
    
    static let Feature = Dep.Features.project(name: "Feature", group: group)
    static let Interface = Dep.Features.project(name: "\(group)FeatureInterface", group: group)
}

public extension Dep.Features.Onboarding {
    static let group = "Onboarding"
    
    static let Feature = Dep.Features.project(name: "Feature", group: group)
    static let Interface = Dep.Features.project(name: "\(group)FeatureInterface", group: group)
}

public extension Dep.Features.TimeTable {
    static let group = "TimeTable"
    
    static let Feature = Dep.Features.project(name: "Feature", group: group)
    static let Interface = Dep.Features.project(name: "\(group)FeatureInterface", group: group)
}

public extension Dep.Features.MyPage {
    static let group = "MyPage"
    
    static let Feature = Dep.Features.project(name: "Feature", group: group)
    static let Interface = Dep.Features.project(name: "\(group)FeatureInterface", group: group)
}

public extension Dep.Features.Todo {
    static let group = "Todo"
    
    static let Feature = Dep.Features.project(name: "Feature", group: group)
    static let Interface = Dep.Features.project(name: "\(group)FeatureInterface", group: group)
}







//
//  SourceFiles+Template.swift
//  ProjectDescriptionHelpers
//
//  Created by 류희재 on 12/17/24.
//

import ProjectDescription

public extension SourceFilesList {
    static let demoSources: SourceFilesList = "Demo/Sources/**/*.swift"
    static let interface: SourceFilesList = "Interface/Sources/**/*.swift"
    static let sources: SourceFilesList = "Sources/**/*.swift"
    static let testing: SourceFilesList = "Testing/**"
    static let unitTests: SourceFilesList = "Tests/Sources/**/*.swift"
    static let uiTests: SourceFilesList = "UITests/**"
}

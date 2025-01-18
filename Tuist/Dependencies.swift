//
//  Dependencies.swift
//  Heylets-iOSManifests
//
//  Created by 류희재 on 12/17/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

import ConfigPlugin

let spm = SwiftPackageManagerDependencies([
    .remote(url: "https://github.com/onevcat/Kingfisher.git", requirement: .upToNextMajor(from: "8.1.3"))
    
], baseSettings: Settings.settings(
    configurations: XCConfig.configurations
))

let dependencies = Dependencies(
    swiftPackageManager: spm,
    platforms: [.iOS]
)



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
    .remote(url: "https://github.com/firebase/firebase-ios-sdk.git",requirement: .exact("10.0.0"))
], baseSettings: Settings.settings(
    configurations: XCConfig.configurations
))

let dependencies = Dependencies(
    swiftPackageManager: spm,
    platforms: [.iOS]
)



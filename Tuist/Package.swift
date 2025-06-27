//
//  Package.swift
//  Manifests
//
//  Created by 류희재 on 6/26/25.
//

// swift-tools-version: 6.0
@preconcurrency import PackageDescription

#if TUIST
@preconcurrency import ProjectDescription
import ConfigPlugin

let packageSettings = PackageSettings(
    productTypes: [
        "FirebaseCore": .staticFramework,
        "FirebaseMessaging": .staticFramework,
        "Alamofire": .framework,
        "AmplitudeSwift": .staticFramework
    ],
    baseSettings: Settings.settings(
        configurations: XCConfig.configurations
    )
)
#endif

let package = Package(
    name: "HeyletsDependencies",
    dependencies: [
        .package(url: "https://github.com/firebase/firebase-ios-sdk", from: "11.0.0"),
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.8.0"),
        .package(url: "https://github.com/amplitude/Amplitude-Swift", from: "1.0.0")
    ]
)

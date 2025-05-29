//
//  Project.swift
//  Heylets-iOSManifests
//
//  Created by 류희재 on 12/17/24.
//

@preconcurrency import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeSPMModule(
    name: "ThirdPartyLibs",
    packages: [
        .remote(
            url: "https://github.com/firebase/firebase-ios-sdk.git",
            requirement: .exact("11.8.1")
        ),
        .remote(
            url: "https://github.com/amplitude/Amplitude-Swift.git",
            requirement: .exact("1.11.7")
        )
    ]
)

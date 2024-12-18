//
//  Config.swift
//  Heylets-iOSManifests
//
//  Created by 류희재 on 12/17/24.
//

import ProjectDescription

let config = Config(
    plugins: [
        .local(path: .relativeToRoot("Plugins/DependencyPlugin")),
        .local(path: .relativeToRoot("Plugins/EnvPlugin")),
        .local(path: .relativeToRoot("Plugins/ConfigPlugin"))
    ]
)

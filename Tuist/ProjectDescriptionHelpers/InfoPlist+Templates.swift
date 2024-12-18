//
//  InfoPlist+Templates.swift
//  Heylets-iOSManifests
//
//  Created by 류희재 on 12/17/24.
//

import Foundation
import ProjectDescription
import EnvPlugin

struct InfoPlistProvider {
    static func forApp(name: String) -> InfoPlist {
        var infoPlist = name.contains("Demo") ? Project.demoInfoPlist : Project.appInfoPlist
        
        return .extendingDefault(with: infoPlist)
        
    }
}


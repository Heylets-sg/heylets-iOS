//
//  InfoPlist.swift
//  DependencyPlugin
//
//  Created by 류희재 on 12/17/24.
//

import ProjectDescription

//TODO: 추후 환경에 맞게 InfoPlist 수정하기
/// InfoPList를 정리해둔 파일이빈다
public extension Project {
    static let appInfoPlist: [String: Plist.Value] = [
        "BASE_URL": "$(BASE_URL)",
        "NSAppTransportSecurity": [
            "NSAllowsArbitraryLoads": true
        ],
        "UIAppFonts": [
            "NotoSansKR-Medium.ttf",
            "NotoSansKR-Regular.ttf",
            "NotoSansKR-SemiBold.ttf",
            "NotoSansKR-Bold.ttf"
        ],
        "UILaunchStoryboardName": "LaunchScreen"
    ]
    
    
    static let demoInfoPlist: [String: Plist.Value] = [
        "BASE_URL": "$(BASE_URL)",
        "NSAppTransportSecurity": [
            "NSAllowsArbitraryLoads": true
        ],
        "UIAppFonts": [
            "NotoSansKR-Medium.ttf",
            "NotoSansKR-Regular.ttf",
            "NotoSansKR-SemiBold.ttf",
            "NotoSansKR-Bold.ttf"
        ],
        "UILaunchStoryboardName": "LaunchScreen"
    ]
}


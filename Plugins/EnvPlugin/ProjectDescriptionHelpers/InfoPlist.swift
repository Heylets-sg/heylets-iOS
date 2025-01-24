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
            "UILaunchStoryboardName": "LaunchScreen",
            // Photo library usage description
            "NSPhotoLibraryUsageDescription": "This app requires access to the photo library to select and upload photos.",
            // Notification usage description
            "UIUserNotificationUsageDescription": "The app requests permission to send notifications.",
            // Camera usage description
            "NSCameraUsageDescription": "This app requires access to the camera to take and upload photos.",
            // Disable dark mode
            "UIUserInterfaceStyle": "Light",
            // Restrict to portrait orientation
            "UISupportedInterfaceOrientations": [
                "UIInterfaceOrientationPortrait"
            ],
            "UISupportedInterfaceOrientations~ipad": [
                "UIInterfaceOrientationPortrait"
            ]
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


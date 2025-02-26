//
//  InfoPlist.swift
//  DependencyPlugin
//
//  Created by 류희재 on 12/17/24.
//

import ProjectDescription

//TODO: 추후 환경에 맞게 InfoPlist 수정하기
/// InfoPList를 정리해둔 파일이빈다
import ProjectDescription

public extension Project {
    static let appInfoPlist: [String: InfoPlist.Value] = [
        "BASE_URL": "$(BASE_URL)",
        "NSAppTransportSecurity": .dictionary([
            "NSAllowsArbitraryLoads": .boolean(true)
        ]),
        "UIBackgroundModes": .array([
            .string("fetch"),
            .string("remote-notification")
        ]),
        "UIAppFonts": .array([
            .string("NotoSansKR-Medium.ttf"),
            .string("NotoSansKR-Regular.ttf"),
            .string("NotoSansKR-SemiBold.ttf"),
            .string("NotoSansKR-Bold.ttf")
        ]),
        "UILaunchStoryboardName": .string("LaunchScreen"),
        "NSPhotoLibraryUsageDescription": .string("This app requires access to the photo library to select and upload photos."),
        "UIUserNotificationUsageDescription": .string("The app requests permission to send notifications."),
        "NSCameraUsageDescription": .string("This app requires access to the camera to take and upload photos."),
        "UIUserInterfaceStyle": .string("Light"),
        "UISupportedInterfaceOrientations": .array([
            .string("UIInterfaceOrientationPortrait")
        ]),
        "UISupportedInterfaceOrientations~ipad": .array([
            .string("UIInterfaceOrientationPortrait")
        ])
    ]
    
    static let demoInfoPlist: [String: InfoPlist.Value] = [
        "BASE_URL": .string("$(BASE_URL)"),
        "NSAppTransportSecurity": .dictionary([
            "NSAllowsArbitraryLoads": .boolean(true)
        ]),
        "UIAppFonts": .array([
            .string("NotoSansKR-Medium.ttf"),
            .string("NotoSansKR-Regular.ttf"),
            .string("NotoSansKR-SemiBold.ttf"),
            .string("NotoSansKR-Bold.ttf")
        ]),
        "UILaunchStoryboardName": .string("LaunchScreen")
    ]
}

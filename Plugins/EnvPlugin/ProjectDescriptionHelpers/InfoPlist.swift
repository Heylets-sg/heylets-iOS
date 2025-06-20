//
//  InfoPlist.swift
//  DependencyPlugin
//
//  Created by 류희재 on 12/17/24.
//

@preconcurrency import ProjectDescription

public extension Project {
    static let appInfoPlist: InfoPlist = .dictionary([
        "ENV": "dev",
        "BASE_URL": "$(BASE_URL)",
        "AMPLITUDE_API_KEY": "$(AMPLITUDE_API_KEY)",
        "NSAppTransportSecurity": .dictionary([
            "NSAllowsArbitraryLoads": .boolean(true)
        ]),
        "CFBundleShortVersionString": "$(MARKETING_VERSION)",
        "CFBundleVersion": "$(CURRENT_PROJECT_VERSION)",
        "CFBundleIdentifier": .string("$(PRODUCT_BUNDLE_IDENTIFIER)"),
        "CFBundleDisplayName": .string("HeyLets"),
        "CFBundleExecutable": .string("$(EXECUTABLE_NAME)"),
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
        "UIUserInterfaceStyle": .string("Automatic"),
        "UISupportedInterfaceOrientations": .array([
            .string("UIInterfaceOrientationPortrait")
        ]),
        "UISupportedInterfaceOrientations~ipad": .array([
            .string("UIInterfaceOrientationPortrait")
        ])
    ])
    
    static let demoInfoPlist: InfoPlist = .dictionary([
        "BASE_URL": .string("$(BASE_URL)"),
        "AMPLITUDE_API_KEY": .string("$(AMPLITUDE_API_KEY)"),
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
    ])
}
